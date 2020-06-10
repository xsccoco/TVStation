//
//  TSNetworkManager.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/8.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSNetworkConstant.h"
NS_ASSUME_NONNULL_BEGIN

@class TSBaseRequest;
@interface TSNetworkManager : NSObject

// 最大并发数，默认4
@property (nonatomic, assign) NSInteger maxConcurrentRequestCount;
// 网络状态
@property (nonatomic, assign, readonly) TSRequestReachabilityStatus reachabilityStatus;

// 单例对象
+ (instancetype)shareInstance;

// 启动网络监听
- (void)startNetworkStateMonitoring;
// 开始请求
- (void)startRequest:(TSBaseRequest *)request;
// 取消单个请求
- (void)cancelRequest:(TSBaseRequest *)request;
// 取消全部请求
- (void)cancelAllRequest;


@end

NS_ASSUME_NONNULL_END
