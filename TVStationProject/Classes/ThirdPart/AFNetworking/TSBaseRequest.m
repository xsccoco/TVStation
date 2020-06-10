//
//  TSBaseRequest.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/8.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSBaseRequest.h"
#import "TSNetworkManager.h"
#import "TSBaseModel.h"

@implementation TSBaseRequest

#pragma mark - publicMethods

// 开始请求
- (void)start
{
    self.status = TSRequestStatusRunning;
    NSLog(@"%@ url:%@%@", NSStringFromClass(self.class), [self requestBaseUrl], [self requestUrl]);
    NSLog(@"%@ params:%@", NSStringFromClass(self.class), [self requestParameter]);
    [[TSNetworkManager shareInstance] startRequest:self];
    
}

// 开始请求设置成功失败回调
- (void)startWithRequestSuccessBlock:(void(^)(TSBaseRequest *request))success
                        failureBlock:(void(^)(TSBaseRequest *request))failure
{
    [self setRequestSuccessBlock:success failureBlock:failure];
    [self start];
}

// 停止请求
- (void)stop
{
    self.status = TSRequestStatusCanceling;
    [[TSNetworkManager shareInstance] cancelRequest:self];
}

// 请求是否正在执行
- (BOOL)isExecuting
{
    return self.status == TSRequestStatusRunning;
}

// 设置成功失败回调
- (void)setRequestSuccessBlock:(void(^)(TSBaseRequest *request))success
                  failureBlock:(void(^)(TSBaseRequest *request))failure
{
    self.requestSuccessBlock = success;
    self.requestFailureBlock = failure;
}

// 设置成功失败token校验回调
- (void)setRequestSuccessBlock:(void (^)(TSBaseRequest *))success
                  failureBlock:(void (^)(TSBaseRequest *))failure
          tokenInvalidateBlock:(void (^)(TSBaseRequest *))tokenInvalidate
{
    self.requestSuccessBlock = success;
    self.requestFailureBlock = failure;
    self.requestTokenInvalidateBlock = tokenInvalidate;
}



// 请求接口成功
- (void)requestCompleteSuccess
{
    self.status = TSRequestStatusCompleted;
    NSLog(@"%@ response:%@",NSStringFromClass(self.class), self.responseObject);
    // token失效校验
    TSBaseModel *baseModel = [TSBaseModel yy_modelWithDictionary:self.responseObject];
    if (baseModel.isTokenInvalid) {
        // 清除登录信息
        
        // 判断有没有回调
        if (self.requestTokenInvalidateBlock) {
            self.requestTokenInvalidateBlock(self);
        } else {
            //  统一处理拉起登录界面
        }
        return;
    }
    // 版本不兼容校验
    if (baseModel.isVersionIncompatible) {
        // 弹框引导用户去升级最新版本
        
    }
    if (self.requestSuccessBlock) {
        self.requestSuccessBlock(self);
    }
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
    return YANGFAN_SERVICE_URL;;
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
