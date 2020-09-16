//
//  Converterter.h
//  WhiteSDK
//
//  Created by yleaf on 2019/6/25.
//

#import <Foundation/Foundation.h>
#import "WhiteConversionInfo.h"

NS_ASSUME_NONNULL_BEGIN


/**
 查询成功后回调

 @param success 是否成功
 @param ppt 转换后的 ppt,已经有默认的 ppt.scenes 可以直接调用 whiteSDK WhiteRoom 的 putScenes API
 @param info 从服务器获取到的 转换进度信息
 @param error 报错信息
 */
typedef void(^ConvertCompletionHandler)(BOOL success, ConvertedFiles * _Nullable ppt, WhiteConversionInfo * _Nullable info, NSError * _Nullable error);
typedef void(^ConvertProgress)(CGFloat progress, WhiteConversionInfo * _Nullable info);

/**
 本地 Converter 状态
 只有一个转换服务器，完整结束（成功，失败）才可以创建下一个转换服务。
 */
typedef NS_ENUM(NSInteger, ConverterStatus) {
    /** 初始化状态，可以开始新转换服务 */
    ConverterStatusIdle,
    /** 本地转换创建成功，无法创建新转换服务 */
    ConverterStatusCreated,
    /**
     创建转换任务失败
     在对应回调 error 中查看具体原因，
     一般为网络错误请求失败，或者未开启文档转换服务
     可以开始新转换服务
     */
    ConverterStatusCreateFail,
    /** 正在向服务器查询转换状态，无法创建新转换服务 */
    ConverterStatusChecking,
    /**
     向服务器查询转换状态失败
     重启查询服务，查询服务器转换状态
     无法创建新转换服务
     */
    ConverterStatusCheckFail,
    /** 等待下次查询转换服务状态，无法创建新转换服务 */
    ConverterStatusWaitingForNextCheck,
    /** 查询服务超时，已停止检查，可以手动重启查询服务，无法创建新转换服务 */
    ConverterStatusTimeout,
    /** 转换服务完成，可以开启新转换服务 */
    ConverterStatusSuccess,
    /**
     转换服务失败
     在对应回调 error 中查看具体原因，
     可以开启新转换服务
     */
    ConverterStatusFail,
};

typedef NS_ENUM(NSInteger, ConverterErrorCode) {
    /** 创建转换服务失败，请重新创建 */
    ConverterErrorCodeCreatedFail = 20001,
    /** 服务器转换失败；具体请查看 error userInfo 信息 */
    ConverterErrorCodeConvertFail = 20002,
    /** 服务器端不存在该任务 */
    ConverterErrorCodeNotFound    = 20003,
    /** 查询时出错，一般是网络问题，请重启查询服务 */
    ConverterErrorCodeCheckFail   = 20004,
    /** 查询时间，超过timeout时间 */
    ConverterErrorCodeCheckTimeout= 20005,
};

@interface WhiteConverter : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithRoomToken:(NSString *)roomToken;
- (instancetype)initWithRoomToken:(NSString *)roomToken pollingInterval:(NSTimeInterval)interval timeout:(NSTimeInterval)timeout;

@property (nonatomic, copy, readonly) NSString *roomToken;

/**
 轮询间隔时间，默认 15s，从前一个请求完整结束，开始计时
 */
@property (nonatomic, assign) NSTimeInterval interval;

/**
 轮询超时停止时间，默认 3 分钟
 */
@property (nonatomic, assign) NSTimeInterval timeout;

/**
 服务器转换任务的 uuid。如遇错，可以提供 taskId 和 type 类型进行排查。
 只有成功创建转换任务，才会有 taskId，如果未开启服务
 */
@property (nonatomic, copy, readonly, nullable) NSString *taskId;

/**
 错误信息
 */
@property (nonatomic, strong, readonly, nullable)  NSError *error;
/**
 转换类型，在创建转换任务时，传入。
 */
@property (nonatomic, assign, readonly) ConvertType type;
@property (nonatomic, assign, readonly) ConverterStatus status;

/**
 创建文档转换服务，并开始轮询请求服务器。
 部分状态下无法新建服务，具体看 @link{{ConverterStatus}} 枚举

 @param url 文档所在网络地址，需要对外可下载（即使无法下载，也会成功创建转换服务，但是会立即变成转换失败状态），SDK 服务器会去下载，然后进行转换。
 @param type 文档类型
 @param progress 进度回调提示
 @param completionHandler 转换完成回调(主线程回调）
 */
- (void)startConvertTask:(NSString *)url type:(ConvertType)type progress:(_Nullable  ConvertProgress)progress completionHandler:(_Nullable ConvertCompletionHandler)completionHandler;

/**
 重新轮询执行检查（外部调用时，只有ConverterStatusTimeout，才允许重新开启轮询检查）

 间隔与超时时间，继承 启动文档转换服务 API 的设置
 @param progress 进度回调
 @param completionHandler 转换完成回调(主线程回调）
 */
- (void)startPolling:(_Nullable ConvertProgress)progress completionHandler:(_Nullable ConvertCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
