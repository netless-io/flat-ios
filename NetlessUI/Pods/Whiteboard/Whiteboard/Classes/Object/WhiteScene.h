//
//  WhiteScene.h
//  WhiteSDK
//
//  Created by yleaf on 2019/1/11.
//

#import "WhiteObject.h"
#import "WhitePptPage.h"
NS_ASSUME_NONNULL_BEGIN

@interface WhiteScene : WhiteObject

- (instancetype)init;
- (instancetype)initWithName:(nullable NSString *)name ppt:(nullable WhitePptPage *)ppt;

/** 通过 WhiteRoom 的 moveScene API 才可以改名。 */
@property (nonatomic, copy, readonly) NSString *name;
/**
 可以通过该属性是否为0，来判断该页面是否有内容。（该数字不计算 ppt，只有 ppt 时，也是0）。
 该属性，还在试验阶段，不稳定。
 */
@property (nonatomic, assign, readonly) NSInteger componentsCount;
@property (nonatomic, strong, readonly, nullable) WhitePptPage *ppt;
@end

NS_ASSUME_NONNULL_END
