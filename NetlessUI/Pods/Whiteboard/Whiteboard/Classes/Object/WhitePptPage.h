//
//  WhitePptPage.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import <UIKit/UIkit.h>
#import "WhiteObject.h"

NS_ASSUME_NONNULL_BEGIN


@interface WhitePptPage : WhiteObject

- (instancetype)initWithSrc:(NSString *)src size:(CGSize)size;
- (instancetype)initWithSrc:(NSString *)src preview:(NSString *)url size:(CGSize)size;

@property (nonatomic, copy) NSString *src;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

/**
 动态转码ppt，预览截图时，使用的背景图片
 */
@property (nonatomic, copy, readonly) NSString *previewURL;

@end

NS_ASSUME_NONNULL_END
