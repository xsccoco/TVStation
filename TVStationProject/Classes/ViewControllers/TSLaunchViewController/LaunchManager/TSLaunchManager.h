//
//  TSLaunchManager.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSGetParameterListRequest.h"
#import "TSGetStartAdsListRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSLaunchManager : NSObject

// 获取系统参数接口
@property (nonatomic, strong, readonly) TSGetParameterListRequest *paramsRequest;
// 获取开机广告接口
@property (nonatomic, strong, readonly) TSGetStartAdsListRequest *adsRequest;


// 获取系统参数
- (void)loadParameterListRequestSuccessBlock:(void(^)(TSGetParameterListModel *paramListModel))success
                                failureBlock:(void(^)(TSBaseRequest *request))failure;

// 获取开机广告
- (void)loadStartAdListRequestSuccessBlock:(void(^)(TSGetStartAdsListModel *adsListModel))success
                              failureBlock:(void(^)(TSBaseRequest *request))failure;
@end

NS_ASSUME_NONNULL_END
