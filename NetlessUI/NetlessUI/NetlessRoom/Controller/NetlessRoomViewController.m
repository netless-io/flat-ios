//
//  NetlessRoomViewController.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/12.
//  Copyright © 2020 yize. All rights reserved.
//

#import "NetlessRoomViewController.h"
#import "AppDelegate.h"
#import "WhiteboardToolsBar.h"
#import "WhiteBoardFunctionBar.h"
#import "WhiteBoardColorSelectView.h"
#import "ToolsGraphicalSelectView.h"
#import "WhiteUtils.h"
#import "CustomPopOverView.h"
#import "WhiteBoardPaperViewController.h"
#import "UIViewController+CWLateralSlide.h"

@interface NetlessRoomViewController ()<WhiteCommonCallbackDelegate,functionBarDelegate,toolsBarDelegate>

@property (nonatomic, strong)WhiteboardToolsBar *toolsBar;
@property (nonatomic, strong)WhiteBoardFunctionBar *functionBar;

@property (nonatomic, strong) WhiteBoardView *boardView;
@property (nonatomic, strong) WhiteSDK *sdk;

#pragma mark - CallbackDelegate
@property (nonatomic, weak, nullable) id<WhiteCommonCallbackDelegate> commonDelegate;
#pragma mark - CallbackDelegate
@property (nonatomic, weak, nullable) id<WhiteRoomCallbackDelegate> roomCallbackDelegate;

@end

@implementation NetlessRoomViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    ((AppDelegate *)[UIApplication sharedApplication].delegate).allowRotation = YES;
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    ((AppDelegate *)[UIApplication sharedApplication].delegate).allowRotation = NO;
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(@"F4F4F4");
    [self setupUI];
    [self initSDK];
//    [WhiteUtils createRoomWithResult:^(BOOL success, id response, NSError *error) {
//        NSLog(@"%@,error = %@",response,error);
//    }];
    [WhiteUtils getRoomTokenWithUuid:@"71009d70fd7811ea8a6a89c586a4dabc" completionHandler:^(NSString * _Nullable roomToken, NSError * _Nullable error) {
        [self joinRoomWithToken:roomToken];
    }];
}

- (void)initSDK
{
    // 初始化 SDK 配置类，根据需求设置配置
    WhiteSdkConfiguration *config = [[WhiteSdkConfiguration alloc] initWithApp:@"JFhiwPvrEeqMwmsIx83bkQ/oafOfKbFPN6KUQ"];

    // 初始化 WhiteSDK，并传入callback
    self.sdk = [[WhiteSDK alloc] initWithWhiteBoardView:self.boardView config:config commonCallbackDelegate:self.commonDelegate];
}

- (void)joinRoomWithToken:(NSString *)roomToken
{
    
    [self.sdk joinRoomWithUuid:@"71009d70fd7811ea8a6a89c586a4dabc" roomToken:roomToken completionHandler:^(BOOL success, WhiteRoom * _Nullable room, NSError * _Nullable error) {
        if (success) {
            self.room = room;
            // 获取当前缩放比例
            self.functionBar.scaleLabel.text = [NSString stringWithFormat:@"%.0f%%",self.room.scale*100];
            // 获取当前画笔颜色
            NSArray *color = self.room.memberState.strokeColor;
            if (color.count != 0) {
                CGFloat R = [color[0] floatValue];
                CGFloat G = [color[1] floatValue];
                CGFloat B = [color[2] floatValue];
                self.functionBar.colorButton.backgroundColor  = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
            }

        } else {
            // 错误处理
            NSLog(@"%@",error);
        }
    }];
}

#pragma mark - UI布局
- (void)setupUI
{
    CGSize size = UIScreen.mainScreen.bounds.size;
    [self.view addSubview:self.boardView];
    [self.view addSubview:self.functionBar];
    [self.view addSubview:self.toolsBar];

    self.boardView.opaque = NO;
    self.boardView.backgroundColor = Color(@"F4F4F4");
    [self.boardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.size.mas_equalTo(CGSizeMake(size.height, size.width));
    }];
    
    [self.toolsBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(0);
        make.size.mas_equalTo(CGSizeMake(size.height, 48));
    }];
    
    [self.functionBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.size.mas_equalTo(CGSizeMake(size.height, 48));
    }];
}

#pragma mark - 自定义事件


#pragma mark - 工具栏代理
- (void)toolsSelectWithToolsType:(ToolsType)toolsType
{
    __weak typeof(self) weakSelf = self;
    switch (toolsType) {
        case ToolsType_select:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = ApplianceSelector;
            [self.room setMemberState:mState];
            break;
        }
            
        case ToolsType_pencil:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = AppliancePencil;
            [self.room setMemberState:mState];
            break;
        }
            
        case ToolsType_edit:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = ApplianceText;
            [self.room setMemberState:mState];
            break;
        }
            
        case ToolsType_eraser:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = ApplianceEraser;
            [self.room setMemberState:mState];
            break;
        }
            
        case ToolsType_figure:
        {
            CustomPopOverView *view = [CustomPopOverView popOverView];
            ToolsGraphicalSelectView *graphicalView = [[ToolsGraphicalSelectView alloc] init];
            [view setContent:graphicalView];
            [view showFrom:self.toolsBar.figureButton alignStyle:CPAlignStyleCenter relativePosition:CPContentPositionAlwaysUp];
            
            graphicalView.ellipseSelectBlock = ^{
                WhiteMemberState *mState = [[WhiteMemberState alloc] init];
                mState.currentApplianceName = ApplianceEllipse;
                [weakSelf.room setMemberState:mState];
                [view dismiss];
            };
            graphicalView.rectangleSelectBlock = ^{
                WhiteMemberState *mState = [[WhiteMemberState alloc] init];
                mState.currentApplianceName = ApplianceRectangle;
                [weakSelf.room setMemberState:mState];
                [view dismiss];
            };
            break;
        }
        
        
        case ToolsType_straightLine:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = ApplianceStraight;
            [self.room setMemberState:mState];
            break;
        }
        
            
        case ToolsType_arrow:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = ApplianceArrow;
            [self.room setMemberState:mState];
            break;
        }
        
            
        case ToolsType_reset:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = ApplianceHand;
            [self.room setMemberState:mState];
            break;
        }
        
            
        case ToolsType_upload:
        {
        
            break;
        }
        
            
        default:
            break;
    }
}

#pragma mark - 功能栏代理
- (void)functionSelectWithToolsType:(FunctionType)functionType
{

    __weak typeof(self) weakSelf = self;

    switch (functionType) {
        case FunctionType_lastOperation:
        {
            [self.room redo];
            break;
        }
            
        case FunctionType_nextOperation:
        {
            [self.room undo];
            break;
        }
            
        case FunctionType_color:
        {
            CustomPopOverView *view = [CustomPopOverView popOverView];
            WhiteBoardColorSelectView *colorView = [[WhiteBoardColorSelectView alloc] init];
            [view setContent:colorView];
            [view showFrom:self.functionBar.colorButton alignStyle:CPAlignStyleCenter relativePosition:CPContentPositionAlwaysDown];

            colorView.colorSelectBlock = ^(NSArray * _Nonnull RGBColor) {
                WhiteMemberState *mState = [[WhiteMemberState alloc] init];
                mState.strokeColor = RGBColor;
                [weakSelf.room setMemberState:mState];
            };
            break;
        }
            
        case FunctionType_reset:
        {
            [self.room zoomChange:1.0];
            break;
        }
            
        case FunctionType_page:
        {
            WhiteBoardPaperViewController *paperVC = [[WhiteBoardPaperViewController alloc] init];
            CWLateralSlideConfiguration *config = [[CWLateralSlideConfiguration alloc] init];
            config.direction = CWDrawerTransitionFromRight;
            config.distance = 240;
            [self cw_showDrawerViewController:paperVC animationType:CWDrawerAnimationTypeDefault configuration:config];
            break;
        }
            
        case FunctionType_startPage:
        {
            break;
        }
            
        case FunctionType_endPage:
        {
            break;
        }
            
        case FunctionType_lastPage:
        {
            break;
        }
            
        case FunctionType_nextPage:
        {
            break;
        }
            
        case FunctionType_currentPage:
        {
            break;
        }
            
        case FunctionType_video:
        {
            break;
        }
            
        case FunctionType_file:
        {
            break;
        }
            
        case FunctionType_link:
        {
            break;
        }
            
        case FunctionType_exitRoom:
        {
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - 懒加载
- (WhiteboardToolsBar *)toolsBar
{
    if (!_toolsBar) {
        _toolsBar = [[WhiteboardToolsBar alloc] init];
        _toolsBar.toolsDelegate = self;
    }
    return _toolsBar;
}

- (WhiteBoardFunctionBar *)functionBar
{
    if (!_functionBar) {
        _functionBar = [[WhiteBoardFunctionBar alloc] init];
        _functionBar.delegate = self;
        _functionBar.backgroundColor = [UIColor whiteColor];
    }
    return _functionBar;
}

- (WhiteBoardView *)boardView
{
    if (!_boardView) {
        _boardView = [[WhiteBoardView alloc] init];
    }
    return _boardView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
