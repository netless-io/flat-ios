//
//  WhiteEvent.h
//  WhiteSDK
//
//  Created by yleaf on 2018/10/9.
//

#import "WhiteObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteEvent : WhiteObject

- (instancetype)initWithName:(NSString *)eventName payload:(id)payload;

/** 注册事件时的事件名 */
@property (nonatomic, strong) NSString *eventName;
/**
 发送自定义事件时，附带的信息。
 消息格式根据发送方（也可以不带内容）NSArray（内部元素也需要可以被转换成 JSON ），NSString，NSDictionary，NSNumber（with Boolean，NSInteger，CGFloat）等可以在 JSON 中正常展示的类型。
 */
@property (nonatomic, strong, nullable) id payload;

/** 房间号 */
@property (nonatomic, strong, readonly) NSString *uuid;

/**
 发送事件的用户角色。
 system，app，custom，magix。
 自定义事件为 custom
 */
@property (nonatomic, strong, readonly) NSString *scope;

/**
 发送事件的用户
 */
@property (nonatomic, strong, readonly) NSString *authorId;

@end

NS_ASSUME_NONNULL_END
