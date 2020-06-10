//
//  TSLaunchManager.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSLaunchManager.h"

@interface TSLaunchManager ()
@property (nonatomic, strong, readwrite) TSGetParameterListRequest *paramsRequest;

@end

@implementation TSLaunchManager

#pragma mark - publishMethods
// 获取系统参数
- (void)getParameterList
{
    [self.paramsRequest startWithRequestSuccessBlock:^(TSBaseRequest * _Nonnull request) {
        
    } failureBlock:^(TSBaseRequest * _Nonnull request) {
        
    }];
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
@end
