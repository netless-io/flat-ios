//
//  Converterter.m
//  WhiteSDK
//
//  Created by yleaf on 2019/6/25.
//

#import "WhiteConverter.h"
#import "WhiteConsts.h"
#import "WhiteConversionInfo.h"

static dispatch_queue_t converter_processing_queue() {
    static dispatch_queue_t netless_converter_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netless_converter_processing_queue = dispatch_queue_create("com.netless.convert", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return netless_converter_processing_queue;
}


static NSString * const PptApiOrigin = @"https://cloudcapiv4.herewhite.com";

static NSString * const kHttpCode = @"httpCode";
static NSString * const kErrorCode = @"errorCode";
static NSString * const kErrorDomain = @"errorDomain";

#pragma mark - Converterter

@interface WhiteConverter ()
@property (nonatomic, copy, readwrite) NSString *roomToken;
@property (nonatomic, strong, readwrite, nullable) NSError *error;
@property (nonatomic, copy, readwrite, nullable) NSString *taskId;
@property (nonatomic, assign, readwrite) ConvertType type;
@property (nonatomic, assign, readwrite) ConverterStatus status;

@property (nonatomic, strong) NSDate *beginDate;
@end

@implementation WhiteConverter

- (instancetype)initWithRoomToken:(NSString *)roomToken
{
    self = [self initWithRoomToken:roomToken pollingInterval:15 timeout:3 * 60];
    return self;
}

- (instancetype)initWithRoomToken:(NSString *)roomToken pollingInterval:(NSTimeInterval)interval timeout:(NSTimeInterval)timeout
{
    self = [super init];
    if (self) {
        _type = ConvertTypeUnknown;
        _roomToken = roomToken;
        _interval = interval;
        _timeout = timeout;
    }
    return self;
}

#pragma mark - Public Methods

- (void)startConvertTask:(NSString *)url type:(ConvertType)type progress:(_Nullable  ConvertProgress)progress completionHandler:(_Nullable ConvertCompletionHandler)completionHandler
{
    if (![self canStartNewTask]) {
        NSAssert(false, @"请勿重复启动");
        return;
    }
    
    self.beginDate = [NSDate date];
    self.error = nil;
    self.type = type;
    
    ConvertCompletionHandler result = ^ void (BOOL success, ConvertedFiles *ppt, WhiteConversionInfo *info, NSError *error) {
        if (completionHandler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(success, ppt, info, error);
            });
        }
    };
    
    dispatch_async(converter_processing_queue(), ^{
        
        //多次 async 后，NSURLSession 启动的 task 会丢失 completionHandler
        //改用 group enter leave，减少异步次数
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_enter(group);
        [self createConvertTask:url ppt:type result:^(BOOL success, NSString *taskId, NSError *error) {
            if (success) {
                self.status = ConverterStatusCreated;
                self.taskId = taskId;
                dispatch_group_leave(group);
            } else {
                self.status = ConverterStatusCreateFail;
                self.error = error;
                dispatch_group_leave(group);
            }
        }];
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        if (self.status == ConverterStatusCreateFail) {
            result(NO, nil, nil, self.error);
            return ;
        }
        
        [self startPolling:progress completionHandler:completionHandler];
    });
}

- (void)startPolling:(_Nullable ConvertProgress)progress completionHandler:(_Nullable ConvertCompletionHandler)completionHandler;
{
    if (![self canRestartPolling]) {
        NSAssert(false, @"请勿重复启动轮询");
        return;
    }
    
    ConvertCompletionHandler result = ^ void (BOOL success, ConvertedFiles *ppt, WhiteConversionInfo *info, NSError *error) {
        if (completionHandler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(success, ppt, info, error);
            });
        }
    };
    
    dispatch_async(converter_processing_queue(), ^{
        [self pollingTask:self.taskId progress:progress result:^(WhiteConversionInfo *convertInfo, NSError *error) {
            if (error) {
                //报错时，在各个异常位置，自行设置 status
                self.error = error;
                result(NO, nil, convertInfo, error);
            } else {
                ConvertedFiles *cPpt = [self getStaticPptFrom:convertInfo convertType:self.type];
                self.status = ConverterStatusSuccess;
                result(YES, cPpt, convertInfo, nil);
            }
        }];
    });
}

#pragma mark -
#pragma mark - Private Methods
#pragma mark -

#pragma mark - Judge
- (BOOL)canStartNewTask
{
    switch (self.status) {
        case ConverterStatusIdle:
        case ConverterStatusCreateFail:
        case ConverterStatusSuccess:
        case ConverterStatusFail:
            return YES;
        case ConverterStatusTimeout:
        case ConverterStatusWaitingForNextCheck:
        case ConverterStatusChecking:
        case ConverterStatusCheckFail:
        case ConverterStatusCreated:
            return NO;
    }
}

- (BOOL)canRestartPolling
{
    switch (self.status) {
        case ConverterStatusIdle:
        case ConverterStatusCreateFail:
        case ConverterStatusSuccess:
        case ConverterStatusFail:
            return NO;
        case ConverterStatusTimeout:
        case ConverterStatusWaitingForNextCheck:
        case ConverterStatusChecking:
        case ConverterStatusCheckFail:
        case ConverterStatusCreated:
            return YES;
    }
}

#pragma mark - HTTP

- (void)createConvertTask:(NSString *)url ppt:(ConvertType)type result:(void (^)(BOOL succed, NSString *uuid, NSError *error))result
{
    NSString *postAPI = [PptApiOrigin stringByAppendingString:@"/services/conversion/tasks"];
    NSString *serviceType = @"";
    switch (type) {
        case ConvertTypeUnknown:
        case ConvertTypeStatic:
            serviceType = @"static_conversion";
            break;
        case ConvertTypeDynamic:
            serviceType = @"dynamic_conversion";
            break;
    }
    
    postAPI = [postAPI stringByAppendingString:[NSString stringWithFormat:@"?roomToken=%@", self.roomToken]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:postAPI]];
    NSMutableURLRequest *modifyRequest = [request mutableCopy];
    
    NSDictionary *body = @{@"sourceUrl": url ? : @"", @"serviceType": serviceType};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    
    modifyRequest.HTTPMethod = @"POST";
    modifyRequest.HTTPBody = postData;
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];

    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:modifyRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (error && result) {
            NSMutableDictionary *mutableDict = [(error.userInfo ? : @{}) mutableCopy];
            mutableDict[kErrorDomain] = error.domain;
            mutableDict[kErrorCode] = @(error.code);
            NSError *error = [NSError errorWithDomain:WhiteConstsConvertDomain code:ConverterErrorCodeCreatedFail userInfo:mutableDict];
            result(NO, nil, error);
        } else if (httpResponse.statusCode == 200) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString *succeed = responseObject[@"msg"][@"succeed"];
            if ([succeed boolValue]) {
                NSString *taskId = responseObject[@"msg"][@"taskUUID"];
                !result ? : result(YES, taskId, nil);
            } else {
                NSError *error = [NSError errorWithDomain:WhiteConstsConvertDomain code:ConverterErrorCodeCreatedFail userInfo:responseObject];
                !result ? : result(NO, nil, error);
            }
        } else {
            NSMutableDictionary *responseObject = [([NSJSONSerialization JSONObjectWithData:data options:0 error:nil] ? : @{}) mutableCopy];
            responseObject[kHttpCode] = @(httpResponse.statusCode);
            NSError *error = [NSError errorWithDomain:WhiteConstsConvertDomain code:ConverterErrorCodeCreatedFail userInfo:responseObject];
            !result ? : result(NO, nil, error);
        }
    }];
    [task resume];
}

- (void)pollingTask:(NSString *)taskId progress:(_Nullable ConvertProgress)progress result:(void (^)(WhiteConversionInfo *conversionInfo, NSError *error))result
{
    if (self.status == ConverterStatusTimeout || self.status == ConverterStatusCheckFail) {
        self.beginDate = [NSDate date];
    } else if (self.status != ConverterStatusCreated || !self.taskId) {
        NSAssert(false, @"正在查询中，请勿重复调用");
        return;
    }
    
    BOOL __block converting = YES;
    WhiteConversionInfo __block *lastInfo;
    while (converting && [[self.beginDate dateByAddingTimeInterval:self.timeout] compare:[NSDate date]] == NSOrderedDescending) {
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_enter(group);
        self.status = ConverterStatusChecking;
        [self checkProgress:taskId result:^(WhiteConversionInfo *info, NSError *error) {
            lastInfo = info;
            if (!info) {
                converting = NO;
                self.status = ConverterStatusCheckFail;
                !result ? : result(nil, error);
            } else if (info.convertStatus == ServerConversionStatusFail || info.convertStatus == ServerConversionStatusNotFound) {
                converting = NO;
                self.status = ConverterStatusFail;
                ConverterErrorCode errorCode = info.convertStatus == ServerConversionStatusFail ? ConverterErrorCodeConvertFail : ConverterErrorCodeNotFound;
                error = error ? error : [NSError errorWithDomain:WhiteConstsConvertDomain code:errorCode userInfo:@{@"reason": info.reason ? : @""}];
                !result ? : result(info, error);
            } else if (info.convertStatus == ServerConversionStatusFinished) {
                !progress ? : progress(1, info);
                converting = NO;
                self.status = ConverterStatusSuccess;
                !result ? : result(info, nil);
            } else {
                self.status = ConverterStatusWaitingForNextCheck;
                !progress ? : progress(info.convertedPercentage, info);
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_group_leave(group);
            });
            
        }];
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    }
    if (self.status == ConverterStatusWaitingForNextCheck) {
        self.status = ConverterStatusTimeout;
        NSError *error = [NSError errorWithDomain:WhiteConstsConvertDomain code:ConverterErrorCodeCheckTimeout userInfo:nil];
        !result ? : result(lastInfo, error);
    }
}

- (void)checkProgress:(NSString *)taskId result:(void (^)(WhiteConversionInfo *conversionInfo, NSError *error))result
{
    NSString *typeName;
    switch (self.type) {
        case ConvertTypeUnknown:
        case ConvertTypeStatic:
            typeName = @"static_conversion";
            break;
        case ConvertTypeDynamic:
            typeName = @"dynamic_conversion";
            break;
    }
    NSString *questUrl = [PptApiOrigin stringByAppendingString:[NSString stringWithFormat:@"/services/conversion/tasks/%@/progress?serviceType=%@&roomToken=%@", taskId, typeName, self.roomToken]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:questUrl]];
    NSMutableURLRequest *modifyRequest = [request mutableCopy];
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:modifyRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (error && result) {
            self.status = ConverterStatusCheckFail;
            NSMutableDictionary *mutableDict = [(error.userInfo ? : @{}) mutableCopy];
            mutableDict[kErrorDomain] = error.domain;
            mutableDict[kErrorCode] = @(error.code);
            NSError *error = [NSError errorWithDomain:WhiteConstsConvertDomain code:ConverterErrorCodeCheckFail userInfo:mutableDict];
            result(nil, error);
        } else if (httpResponse.statusCode == 200) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *task = responseObject[@"msg"][@"task"];
            WhiteConversionInfo *info = [WhiteConversionInfo modelWithJSON:task];
            !result ? : result(info, nil);
        } else {
            NSMutableDictionary *responseObject = [([NSJSONSerialization JSONObjectWithData:data options:0 error:nil] ? : @{}) mutableCopy];
            responseObject[kHttpCode] = @(httpResponse.statusCode);
            NSError *error = [NSError errorWithDomain:WhiteConstsConvertDomain code:ConverterErrorCodeCheckFail userInfo:responseObject];
            !result ? : result(nil, error);
        }
    }];
    [task resume];
}

#pragma mark - PPT transform

- (ConvertedFiles *)getStaticPptFrom:(WhiteConversionInfo *)pptProgressInfo convertType:(ConvertType)type
{
    ConvertedFiles *cPpt = [[ConvertedFiles alloc] init];
    cPpt.taskId = self.taskId;
    cPpt.type = type;

    NSArray *fileList = pptProgressInfo.convertedFileList;
    NSMutableArray<NSString *> *sildeURLs = [NSMutableArray arrayWithCapacity:fileList.count];
    NSMutableArray<WhiteScene *> *scenes = [NSMutableArray arrayWithCapacity:fileList.count];
    
    int i = 0;
    for (WhitePptPage *pptPage in fileList) {
        pptPage.src = [NSString stringWithFormat:@"%@%@", pptProgressInfo.prefix ? : @"", pptPage.src];
        WhiteScene *scene = [[WhiteScene alloc] initWithName:[NSString stringWithFormat:@"%d", i + 1] ppt:pptPage];
        [scenes addObject:scene];
        [sildeURLs addObject:pptPage.src];
        cPpt.width = pptPage.width;
        cPpt.height = pptPage.height;
        i ++;
    }
    
    cPpt.slideURLs = sildeURLs;
    cPpt.scenes = scenes;
    return cPpt;
}

@end
