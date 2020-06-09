//
//  TSNetworkConstant.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/8.
//  Copyright © 2020 徐世船. All rights reserved.
//

#ifndef TSNetworkConstant_h
#define TSNetworkConstant_h

// 请求错误码
typedef NS_ENUM(NSInteger, TSRequestErrorCode) {
    TSRequestErrorCodeOutOfNetwork = 0,
};

// 网络状态
typedef NS_ENUM(NSInteger, TSRequestReachabilityStatus) {
    TSRequestReachabilityStatusUnknow = 0,
    TSRequestReachabilityStatusNotReachable,
    TSRequestReachabilityStatusViaWWAN,
    TSRequestReachabilityStatusViaWiFi,
};

// 请求参数组织方式
typedef NS_ENUM(NSInteger, TSRequestSerializerType){
    TSRequestSerializerTypeHTTP = 0,
    TSRequestSerializerTypeJSON,
};

// response serializer type
typedef NS_ENUM(NSInteger, TSResponseSerializerType) {
    TSResponseSerializerTypeHTTP = 0,
    TSResponseSerializerTypeJSON,
};

// 请求方式
typedef NS_ENUM(NSInteger, TSRequestMethod) {
    TSRequestMethodGET = 0,
    TSRequestMethodPOST,
    TSRequestMethodPUT,
    TSRequestMethodDELETE,
};

typedef NS_ENUM(NSInteger, TSRequestStatus) {
    TSRequestStatusRunning = 0,
    TSRequestStatusCanceling = 1,
    TSRequestStatusCompleted = 2,
};

// 接口最大并发数
#define MAX_CONCURRENT_REQUEST_COUNT   4

// 存储cookie的key
#define TS_HTTP_COOKIE_KEY @"TSHTTPCookieKey"

// URL头
#define HTTP_URL_SUFFIX   @"http"

// 透传接口才有的key，非透传接口没有，主要和业务相关
#define REQUEST_PARAM_KEY @"params"

//接口版本，为2位的小数的字符串
#define API_VERSION  @"2.9"

//默认（0或不传）：返回数据不包含测试频道相关数据；1：返回数据包括测试频道相关数据；
#define KEY_REQUEST_MODFLAG  @"KEY_REQUEST_MODFLAG"

// iPad
#define IsIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//终端类型
//#define KEY_TERMINAL_TYPE           (IsIPad?@"iospad":@"ios")
#define KEY_TERMINAL_TYPE           @"ios"

#endif /* TSNetworkConstant_h */
