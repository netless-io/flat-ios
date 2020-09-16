//
//  WhiteProgressView.h
//  WhiteCombinePlayer
//
//  Created by yleaf on 2019/7/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



/**
 进度条最简实现。更多自定义需求，推荐参考 ZFPlayer 的 ZFSilderView
 */
@interface WhiteSliderView : UIView

/** 当前进度 0.0 ~ 1.0 */
@property (nonatomic, assign) CGFloat value;


/** 已缓存进度 0.0 ~ 1.0 */
@property (nonatomic, assign) CGFloat bufferValue;

@end

NS_ASSUME_NONNULL_END
