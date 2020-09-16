//
//  AudioMixerBridge.h
//  Whiteboard
//
//  Created by yleaf on 2020/8/13.
//

#import <Foundation/Foundation.h>
#import "WhiteBoardView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WhiteAudioMixerBridgeDelegate <NSObject>


/**

 Starts audio mixing.
 白板音视频，请求混音。当白板中音视频开始接受播放事件时，会回调该 API。
 开发者需要在该回调中，再主动调用 rtc 等可以提供混音 API 接口的实现。同时当成功开始混音后（大多数为异步回调），主动调用 `WhiteAudioMixerBridge`的 setMediaState:errorCode: 方法。告知白板中音视频，混音完成状态。

  This method mixes the specified local audio file with the audio stream from the microphone, or replaces the microphone's audio stream with the specified local audio file. You can choose whether the other user can hear the local audio playback and specify the number of playback loops. This method also supports online music playback.

 A successful startAudioMixing method call triggers the [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:errorCode:])(AgoraAudioMixingStatePlaying) callback on the local client.

 When the audio mixing file playback finishes, the SDK triggers the [localAudioMixingStateDidChanged]([AgoraRtcEngineDelegate rtcEngine:localAudioMixingStateDidChanged:errorCode:])(AgoraAudioMixingStateStopped) callback on the local client.

 **Note:**

 * If you want to play an online music file, ensure that the time interval between playing the online music file and calling this method is greater than 100 ms, or the AudioFileOpenTooFrequent(702) warning occurs.
 * If the local audio mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL, the SDK returns AgoraWarningCodeAudioMixingOpenError(701).

 @param filePath The absolute path (including the suffixes of the filename) of the local or online audio file to be mixed, for example, /var/mobile/Containers/Data/audio.mp4. Supported audio formats: mp3, aac, mp4, m4a, 3gp, and wav.

 @param loopback Sets which user can hear the audio mixing:

 * YES: Only the local user can hear the audio mixing.
 * NO: Both users can hear the audio mixing.

 @param replace Sets the audio mixing content:

 * YES: Only the specified audio file is published; the audio stream received by the microphone is not published.
 * NO: The local audio file mixed with the audio stream from the microphone.

 @param cycle Sets the number of playback loops:
 * Positive integer: Number of playback loops.
 * -1：Infinite playback loops.

 */
- (void)startAudioMixing:(NSString *)filePath loopback:(BOOL)loopback replace:(BOOL)replace cycle:(NSInteger)cycle;


- (void)stopAudioMixing;


/**
 
 当白板中音视频需要进行跳转操作时，会主动回调该 API
 
 Sets the playback position of the audio mixing file to a different starting position (the default plays from the beginning).

 @param position The playback starting position (ms) of the audio mixing file.
*/
- (void)setAudioMixingPosition:(NSInteger)position;

@end

@interface WhiteAudioMixerBridge : NSObject

- (instancetype)initWithBridge:(WhiteBoardView *)bridge deletegate:(id<WhiteAudioMixerBridgeDelegate>)delegate;


/** 更新混音状态
* @param stateCode
*  710: 成功调用 startAudioMixing 或 resumeAudioMixing
*  711: 成功调用 pauseAudioMixing
*  713: 成功调用 stopAudioMixing
*  714: 播放失败，error code 会有具体原因
* @param errorCode 直接将 rtc 的 errorCode 传递过来即可
*/
- (void)setMediaState:(NSInteger)stateCode errorCode:(NSInteger)errorCode;

@end

NS_ASSUME_NONNULL_END
