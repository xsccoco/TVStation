//
//  TSLaunchManager.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSLaunchManager.h"

@interface TSLaunchManager ()

// 获取系统参数接口
@property (nonatomic, strong, readwrite) TSGetParameterListRequest *paramsRequest;
// 获取开机广告接口
@property (nonatomic, strong, readwrite) TSGetStartAdsListRequest *adsRequest;

@end

@implementation TSLaunchManager

#pragma mark - publishMethods
// 获取系统参数
- (void)getParameterList
{
    WEAKSELF
    [self.paramsRequest startWithRequestSuccessBlock:^(TSBaseRequest * _Nonnull request) {
        STRONGSELF
        TSGetParameterListModel *paramListModel =  [strongSelf.paramsRequest responseModel];
        NSLog(@"请求成功 %@",paramListModel);
    } failureBlock:^(TSBaseRequest * _Nonnull request) {
        
    }];
}

// 获取开机广告
- (void)getStartAdList
{
    WEAKSELF
    [self.adsRequest setRequestSuccessBlock:^(TSBaseRequest * _Nonnull request) {
        STRONGSELF
        TSGetStartAdsListModel *adsListModel =  [strongSelf.adsRequest responseModel];
        NSLog(@"请求成功 %@",adsListModel);
    } failureBlock:^(TSBaseRequest * _Nonnull request) {
        
    }];
    [self.adsRequest startWithCache];
}

#pragma mark - privateMethods


#pragma mark - lazyload
- (TSGetParameterListRequest *)paramsRequest
{
    if (!_paramsRequest) {
        _paramsRequest = [[TSGetParameterListRequest alloc] init];
    }
    return _paramsRequest;
}

- (TSGetStartAdsListRequest *)adsRequest
{
    if (!_adsRequest) {
        _adsRequest = [[TSGetStartAdsListRequest alloc] init];
    }
    return _adsRequest;
}
@end
