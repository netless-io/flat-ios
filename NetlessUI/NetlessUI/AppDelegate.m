//
//  AppDelegate.m
//  NetlessUI
//
//  Created by tinntay on 2020/9/7.
//  Copyright © 2020 yize. All rights reserved.
//

#import "AppDelegate.h"
#import "NetlessLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NetlessLoginViewController *login = [[NetlessLoginViewController alloc] init];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = login;
    [self.window makeKeyAndVisible];
    
    return YES;
}





@end
