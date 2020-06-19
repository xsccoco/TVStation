//
//  TSNetworkUtil.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/9.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSNetworkConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSNetworkUtil : NSObject

// 通用参数
+ (NSDictionary*)commonParamsApiVersionModFlag;
+ (NSDictionary*)commonParamsImeiTerminalType;
+ (NSDictionary*)commonParams;
+ (NSDictionary*)commonParamsAppVersion;


// 对请求的URL进行加密处理
+ (NSString *)getSecurityKey:(NSURL *)requestURL withParameters:(id)parameters requestMethod:(TSRequestMethod)requestMethod;

// 当前应用版本号
+ (NSString *)appVersionString;
@end

NS_ASSUME_NONNULL_END
