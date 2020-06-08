//
//  AppDelegate.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/4.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "AppDelegate.h"

#import "TSLaunchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 初始化启动页控制器
    [self setWindowRootIsLaunchViewController];
    return YES;
}

#pragma mark - privateMethods
 // 初始化启动页控制器
- (void)setWindowRootIsLaunchViewController
{
    TSLaunchViewController *launchViewController = [[TSLaunchViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = launchViewController;
    [self.window makeKeyAndVisible];
}
@end
