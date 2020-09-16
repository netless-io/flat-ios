//
//  WhiteDisplayer+Private.h
//  WhiteSDK
//
//  Created by yleaf on 2019/7/1.
//

#import "WhiteDisplayer.h"
#import "WhiteBoardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteDisplayer ()

- (instancetype)initWithUuid:(NSString *)uuid bridge:(WhiteBoardView *)bridge;

@property (nonatomic, weak, readonly) WhiteBoardView *bridge;

@end

NS_ASSUME_NONNULL_END
