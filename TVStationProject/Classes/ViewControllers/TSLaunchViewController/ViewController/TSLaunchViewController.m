
//
//  TSLaunchViewController.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/5.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSLaunchViewController.h"
#import "TSLaunchManager.h"

@interface TSLaunchViewController ()

@property (nonatomic, strong) TSLaunchManager *launchManager;

@end

@implementation TSLaunchViewController
#pragma mark - lifeCycle
- (void)dealloc
{
    NSLog(@"TSLaunchViewController dealloc");
    [self removeNotifications];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initMembers];
    [self initWidgets];
    [self registerNotifications];
    [self loadParameterListRequest];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - touchEvents

#pragma mark - publicMethods

#pragma mark - Delegate

#pragma mark - Request
- (void)loadRequest
{
    
}

// 请求系统参数
- (void)loadParameterListRequest
{
    WEAKSELF
    [self.launchManager loadParameterListRequestSuccessBlock:^(TSGetParameterListModel * _Nonnull paramListModel) {
        STRONGSELF
        [strongSelf handleParameterListRequestSuccess:paramListModel];
    } failureBlock:^(TSBaseRequest * _Nonnull request) {
        STRONGSELF
        [strongSelf handleParameterListRequestFailure:request];
    }];
}

// 请求开机广告
- (void)loadStartAdListRequest
{
    [self.launchManager loadStartAdListRequestSuccessBlock:^(TSGetStartAdsListModel * _Nonnull adsListModel) {
        
    } failureBlock:^(TSBaseRequest * _Nonnull request) {
        
    }];
}

#pragma mark - Notification
- (void)registerNotifications
{
    
}

- (void)removeNotifications
{
    
}

#pragma mark - privateMethods
- (void)initMembers
{
    
}

- (void)initWidgets
{
    
}

// 获取系统参数成功
- (void)handleParameterListRequestSuccess:(TSGetParameterListModel *)paramListModel
{
    [self needGetBook];
}

//
- (void)needGetBook
{
    BOOL hasShowGudie = [UserDefaults boolForKey:TSHasShowUserGuideKey];// YES是显示过引导页、NO是还没有显示过引导页
    if (!hasShowGudie) {// 需要显示引导页
        NSLog(@"进入登陆界面，请求引导页");
        [UserDefaults setBool:YES forKey:TSHasShowUserGuideKey];
        [UserDefaults setBool:YES forKey:TSIsFirstSetupKey];
        [self playMp4];
    }
    [self startBookPicReq:TSLaunchViewTypeLaunch];
}

// 请求启动图
- (void)startBookPicReq:(TSLaunchViewType)type
{
    
}

// 播放视频
- (void)playMp4
{
    
}

// 获取系统参数失败
- (void)handleParameterListRequestFailure:(TSBaseRequest *)request
{
    
}

#pragma mark - lazyload
- (TSLaunchManager *)launchManager
{
    if (!_launchManager) {
        _launchManager = [[TSLaunchManager alloc] init];
    }
    return _launchManager;
}


@end
