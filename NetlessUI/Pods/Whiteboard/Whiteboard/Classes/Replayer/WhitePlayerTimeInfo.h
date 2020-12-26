//
//  WhitePlayerTimeInfo.h
//  WhiteSDK
//
//  Created by yleaf on 2019/2/28.
//

#import "WhiteObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhitePlayerTimeInfo : WhiteObject

/** 当前时长（秒） */
@property (nonatomic, assign, readonly) NSTimeInterval scheduleTime;

/** 总时长（秒） */
@property (nonatomic, assign, readonly) NSTimeInterval timeDuration;

/** 一个回访中，含有的总 frame 数 */
@property (nonatomic, assign, readonly) NSInteger framesCount;

/** 开始时间，UTC 时间戳（秒） */
@property (nonatomic, assign, readonly) NSTimeInterval beginTimestamp;

@end

NS_ASSUME_NONNULL_END
