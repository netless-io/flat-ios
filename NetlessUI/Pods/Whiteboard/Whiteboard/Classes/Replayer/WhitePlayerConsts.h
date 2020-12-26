//
//  WhitePlayerConsts.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/3.
//

#ifndef WhitePlayerConsts_h
#define WhitePlayerConsts_h

typedef NS_ENUM(NSInteger, WhiteObserverMode) {
    WhiteObserverModeDirectory, //跟随模式，默认
    WhiteObserverModeFreedom    //自由模式
};

typedef NS_ENUM(NSInteger, WhitePlayerPhase) {
    WhitePlayerPhaseWaitingFirstFrame,  //等待第一帧，默认
    WhitePlayerPhasePlaying,            //播放状态
    WhitePlayerPhasePause,              //暂停状态
    WhitePlayerPhaseStopped,            //停止
    WhitePlayerPhaseEnded,              //播放结束
    WhitePlayerPhaseBuffering,          //缓冲中
};

#endif /* WhitePlayerConsts_h */
