//
//  WhiteObject.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import <Foundation/Foundation.h>

@interface WhiteObject : NSObject

+ (instancetype)modelWithJSON:(id)json;
- (NSString *)jsonString;
- (NSDictionary *)jsonDict;

@end
