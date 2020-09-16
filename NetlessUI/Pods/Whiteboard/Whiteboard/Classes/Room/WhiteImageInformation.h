//
//  WhiteImageInformation.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import "WhiteObject.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhiteImageInformation : WhiteObject

/** 系统生成 UUID，指定宽高以及左上角坐标（白板坐标系内） */
- (instancetype)initWithFrame:(CGRect)frame;

/** 系统生成 UUID，指定宽高，图片中点为坐标系原点（白板坐标系内）*/
- (instancetype)initWithSize:(CGSize)size;

- (instancetype)initWithUuid:(NSString *)uuid frame:(CGRect)frame;

@property (nonatomic, copy) NSString *uuid;
/** 图片中点在白板内部坐标系的 X 坐标，白板坐标原点为初始状态下，WhiteboardView 中点。 */
@property (nonatomic, assign) CGFloat centerX;
/** 图片中点在白板内部坐标系上的 Y 坐标，白板坐标原点为初始状态下，WhiteboardView 中点。*/
@property (nonatomic, assign) CGFloat centerY;
/** 白板 1:1 缩放时，图片所占宽度 */
@property (nonatomic, assign) CGFloat width;
/** 白板 1:1 缩放时，图片所占高度 */
@property (nonatomic, assign) CGFloat height;

/** 新增字段，后续版本会根据该字段决定橡皮对该参数效果。当为 true 时，橡皮将不能擦除该图片，默认 false */
@property (nonatomic, assign) BOOL locked;

@end

NS_ASSUME_NONNULL_END
