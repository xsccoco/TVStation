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

// 请求状态
typedef NS_ENUM(NSInteger, TSRequestStatus) {
    TSRequestStatusRunning = 0,
    TSRequestStatusCanceling = 1,
    TSRequestStatusCompleted = 2,
};

// 响应状态码
typedef NS_ENUM(NSInteger, TSResponseStatus) { // 根据后台业务确定
    TSResponseStatusSuccess = 1000, // 请求成功state状态码
    TSResponseStatusTokenValid = 10002, //用户中心的接口token失效返回
    TSResponseStatusUserNotExist = 2009, //我们自己后台token失效返回
    TSResponseStatusPayTokenValid = 42001, //支付后台token失效返回
    TSResponseStatusUnknownTokenValid = 80045,
    TSResponseStatusVersionIncompatible = 4008, //版本不兼容
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



#define BASE_SERVICE_URL     @"https://vapp.96189.com"

// http接口地址
#define YANGFAN_SERVICE_URL     [NSString stringWithFormat:@"%@/setsail/external/externalService",BASE_SERVICE_URL]

//Https Key
#define KEY_APP_ID        @"appid_yangfanapp"
#define KEY_APP_SECRET    @"B8A7E63EDB50D6C16485DE128327B775"


#endif /* TSNetworkConstant_h */
