//
//  TSBaseRequest.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/8.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSBaseRequest.h"

@implementation TSBaseRequest

// 请求接口成功
- (void)requestCompleteSuccess
{
    self.status = TSRequestStatusCompleted;
    NSLog(@"%@ response:%@",NSStringFromClass(self.class), self.responseObject);
    // token 失效校验
    // 接口版本号校验
    
}
// 请求接口失败
- (void)requestCompleteFailure
{
    self.status = TSRequestStatusCompleted;
    NSLog(@"%@ error:%@", NSStringFromClass(self.class), self.error.localizedDescription);
}



// 子类覆盖方法
// 是否使用Cookies, default NO
- (BOOL)useCookies
{
    return NO;
}

// url是否已经编码了
- (BOOL)isAlreadEncode
{
    return NO;
}

// 请求的BaseUrl
- (NSString *)requestBaseUrl
{
    return @"";
}

// 请求的url
- (NSString *)requestUrl
{
    return @"";
}

// 请求的参数列表
- (id)requestParameter
{
    return nil;
}

// 是否需要添加通用参数
- (BOOL)isNeedAddCommonParams
{
    return YES;
}

// 请求的SerializerType
- (TSRequestSerializerType)requestSerializerType
{
    return TSRequestSerializerTypeHTTP;
}

// 请求超时时间，默认为60s
- (NSTimeInterval)requestTimeoutInterval
{
    return 60;
}

// 响应的SerializerType
- (TSResponseSerializerType)responseSerializerType
{
    return TSResponseSerializerTypeJSON;
}

// 请求方式
- (TSRequestMethod)requestMethod
{
    return TSRequestMethodPOST;
}

// 当POST的内容带有文件等富文本时使用
- (AFConstructingBlock)constructingBodyBlock
{
    return nil;
}
@end
