//
//  WhitePlayerConfig.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/1.
//

#import "WhiteObject.h"
#import "WhiteCameraBound.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhitePlayerConfig : WhiteObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithRoom:(NSString *)roomUuid roomToken:(NSString *)roomToken;

/** 房间UUID，目前必须要有 */
@property (nonatomic, copy) NSString *room;

/** 房间token，目前必须要有 */
@property (nonatomic, copy) NSString *roomToken;

/** 分片 ID，可以跳转至特定的房间位置，目前可以不关心。 */
@property (nonatomic, copy, nullable) NSString *slice;

/** 传入对应的UTC 时间戳(秒)，如果正确，则会在对应的位置开始播放。 */
@property (nonatomic, strong, nullable) NSNumber *beginTimestamp;


/** 传入持续时间（秒），当播放到对应位置时，就不会再播放。如果不设置，则从开始时间，一直播放到房间结束。 */
@property (nonatomic, strong, nullable) NSNumber *duration;

/** 音频地址。
 传入视频，也只会播放音频部分。设置后，sdk 会负责与白板同步播放 。
 如需播放音频，请使用 WhiteNativePlayer 模块中的 WhiteCombinePlayer。
 */
@property (nonatomic, strong, nullable) NSString *mediaURL;

/**
 控制回放时，时间进度的回调频率。默认为 0.5 秒。单位：秒。回调间隔，不会准确为 0.5 秒，只是近似值。
 */
@property (nonatomic, strong) NSNumber *step;

/** 视野范围 */
@property (nonatomic, strong, nullable) WhiteCameraBound *cameraBound;

@end

@interface WhitePlayerConfig (Deprecated)

/** 音频地址。
 传入视频，也只会播放音频部分。设置后，sdk 会负责与白板同步播放 。
 如需播放音频，请使用 WhiteNativePlayer 模块中的 WhiteCombinePlayer。
 */
@property (nonatomic, strong, nullable) NSString *audioUrl DEPRECATED_MSG_ATTRIBUTE("use mediaURL property");

@end

NS_ASSUME_NONNULL_END
