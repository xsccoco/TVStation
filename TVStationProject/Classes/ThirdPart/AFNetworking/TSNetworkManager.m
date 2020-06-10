//
//  TSNetworkManager.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/8.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSNetworkManager.h"
#import <AFNetworking.h>
#import "TSBaseRequest.h"
#import "TSNetworkUtil.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface TSNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
// 所有请求的容器
@property (nonatomic, strong) NSMutableDictionary *requests;
// 网络状态
@property (nonatomic, assign, readwrite) TSRequestReachabilityStatus reachabilityStatus;
@end

// 网络错误域名
NSString * const TSRequestOutOfNetwork = @"com.xsc.network.request.outofNetwork";

@implementation TSNetworkManager

#pragma marks - init
- (instancetype)init
{
    if (self = [super init]) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.requests = [NSMutableDictionary dictionary];
        self.maxConcurrentRequestCount = MAX_CONCURRENT_REQUEST_COUNT;
        _reachabilityStatus = TSRequestReachabilityStatusViaWiFi;
    }
    return self;
}

#pragma marks - publicMethods
// 设置最大并发数
- (void)setMaxConcurrentRequestCount:(NSInteger)maxConcurrentRequestCount
{
    self.sessionManager.operationQueue.maxConcurrentOperationCount = maxConcurrentRequestCount;
}

// 单例对象
+ (instancetype)shareInstance
{
    static TSNetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

// 启动网络监听
- (void)startNetworkStateMonitoring
{
    __weak typeof(self) weakSelf = self;
    [self.sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                strongSelf.reachabilityStatus = TSRequestReachabilityStatusUnknow;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                strongSelf.reachabilityStatus = TSRequestReachabilityStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                strongSelf.reachabilityStatus = TSRequestReachabilityStatusViaWiFi;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                strongSelf.reachabilityStatus = TSRequestReachabilityStatusViaWWAN;
                break;
            default:
                break;
        }
    }];
    [self.sessionManager.reachabilityManager startMonitoring];
}

// 开始请求
- (void)startRequest:(TSBaseRequest *)request
{
    if (self.reachabilityStatus == TSRequestReachabilityStatusUnknow || self.reachabilityStatus == TSRequestReachabilityStatusNotReachable) {
        NSError *error = [NSError errorWithDomain:TSRequestOutOfNetwork code:TSRequestErrorCodeOutOfNetwork userInfo:nil];
        request.error = error;
        [self requestDidFinishTag:request];
        return;
    }
    if (request.useCookies) {
        [self loadCookies];
    }
    // 处理请求url
    NSString *url = [self configRequestURL:request];
    if (!request.isAlreadEncode) {
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    // 处理参数
    id params = [self configRequestParams:request];
    if (request.requestSerializerType == TSRequestSerializerTypeJSON) {
        if (![NSJSONSerialization isValidJSONObject:params] && params) {
            NSLog(@"error id JSON parameters:%@",params);
            return;
        }
    }
    // 处理序列化类型
    TSRequestSerializerType requestSerializerType = request.requestSerializerType;
    switch (requestSerializerType) {
        case TSRequestSerializerTypeHTTP:
            self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case TSRequestSerializerTypeJSON:
            self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        default:
            break;
    }
    self.sessionManager.requestSerializer.timeoutInterval = request.requestTimeoutInterval;
    TSResponseSerializerType responseSerializerType = request.responseSerializerType;
    switch (responseSerializerType) {
        case TSRequestSerializerTypeHTTP:
            self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case TSRequestSerializerTypeJSON:
            self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        default:
            break;
    }
    self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/xml", @"text/plain", @"text/json", @"text/javascript", @"image/png", @"image/jpeg", @"application/json", @"application/pdf", nil];
    TSRequestMethod requestMethod = request.requestMethod;
    NSURLSessionDataTask *task = nil;
    __weak typeof(self) weakSelf = self;
    switch (requestMethod) {
        case TSRequestMethodGET:
        {
            task = [self.sessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                if (request.downloadProgress) {
                    request.downloadProgress(downloadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleResponseResult:task response:responseObject error:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleResponseResult:task response:nil error:error];
            }];
        }
            break;
        case TSRequestMethodPOST:
        {
            if (request.constructingBodyBlock) {
                task = [self.sessionManager POST:url parameters:params constructingBodyWithBlock:request.constructingBodyBlock progress:^(NSProgress * _Nonnull uploadProgress) {
                    if (request.uploadProgress) {
                        request.uploadProgress(uploadProgress);
                    }
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [strongSelf handleResponseResult:task response:responseObject error:nil];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [strongSelf handleResponseResult:task response:nil error:error];
                }];
            } else {
                task = [self.sessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    if (request.uploadProgress) {
                        request.uploadProgress(uploadProgress);
                    }
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [strongSelf handleResponseResult:task response:responseObject error:nil];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [strongSelf handleResponseResult:task response:nil error:error];
                }];
            }
        }
            break;
        case TSRequestMethodPUT:
        {
            task = [self.sessionManager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleResponseResult:task response:responseObject error:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleResponseResult:task response:nil error:error];
            }];
        }
            break;
            
        case TSRequestMethodDELETE:
        {
            task = [self.sessionManager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleResponseResult:task response:responseObject error:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf handleResponseResult:task response:nil error:error];
            }];
        }
            break;
        default:
            break;
    }
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    request.task = task;
    [self addRequest:request];
}

// 取消单个请求
- (void)cancelRequest:(TSBaseRequest *)request
{
    [request.task cancel];
    [self removeRequest:request.task];
}

// 取消全部请求
- (void)cancelAllRequest
{
    for (NSString *key in self.requests.allKeys) {
        TSBaseRequest *request = self.requests[key];
        [self cancelRequest:request];
    }
}

#pragma marks - privateMethods

// 将请求从到字典中移除
- (void)removeRequest:(NSURLSessionDataTask *)task
{
    NSString *key = [self taskHashKey:task];
    @synchronized(self) {
        [self.requests removeObjectForKey:key];
    }
}

// 哈希
- (NSString *)taskHashKey:(NSURLSessionDataTask *)task
{
    return [NSString stringWithFormat:@"%lu", (unsigned long)[task hash]];
}

// 将请求添加到字典中保存
- (void)addRequest:(TSBaseRequest *)request
{
    if (request.task) {
        NSString *key = [self taskHashKey:request.task];
        @synchronized (self) {
            [self.requests setValue:request forKey:key];
        }
    }
}

// 响应数据处理
- (void)handleResponseResult:(NSURLSessionDataTask *)task response:(id)responseObject error:(NSError *)error
{
    NSString *key = [self taskHashKey:task];
    TSBaseRequest *request = self.requests[key];
    request.responseObject = responseObject;
    request.error = error;
    if (request.useCookies) {
        [self saveCookies];
    }
    [self requestDidFinishTag:request];
    [self removeRequest:task];
}

// 处理请求参数
- (id)configRequestParams:(TSBaseRequest *)request
{
    NSMutableDictionary* params = [[NSMutableDictionary alloc]initWithDictionary:request.requestParameter];
    if ([request isNeedAddCommonParams])
    {
        if (![[params allKeys] containsObject:REQUEST_PARAM_KEY])
        {   //透传接口
            [params addEntriesFromDictionary:[TSNetworkUtil commonParams]];
        } else {
            //非透传接口
            NSString *jsonString = [params valueForKey:REQUEST_PARAM_KEY];
            NSMutableDictionary *dicWithJson = [[NSMutableDictionary alloc]initWithDictionary:[TSNetworkUtil dictionaryWithJsonString:jsonString]];
            [dicWithJson addEntriesFromDictionary:[TSNetworkUtil commonParamsImeiTerminalType]];
            NSString *paramsString = [TSNetworkUtil jsonStringWithDictionary:dicWithJson];
            [params setObject:paramsString forKey:REQUEST_PARAM_KEY];
            [params addEntriesFromDictionary:[TSNetworkUtil commonParamsApiVersionModFlag]];
        }
        [params addEntriesFromDictionary:[TSNetworkUtil commonParamsAppVersion]];
    }
    return params;
}

// 处理请求的url
- (NSString *)configRequestURL:(TSBaseRequest *)request
{
    if ([request.requestUrl hasSuffix:HTTP_URL_SUFFIX]) {
        return [request requestUrl];
    }
    if ([request.requestBaseUrl hasPrefix:HTTP_URL_SUFFIX]) {
        return [NSString stringWithFormat:@"%@%@",request.requestBaseUrl, request.requestUrl];
    } else {
        NSLog(@"invalid baseUrl: %@ requestUrl: %@",request.requestBaseUrl, request.requestUrl);
        return @"";
    }
}


// 加载cookie
- (void)loadCookies
{
    id cookieData = [[NSUserDefaults standardUserDefaults] objectForKey:TS_HTTP_COOKIE_KEY];
    if (!cookieData) {
        return;
    }
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookieData];
    if ([cookies isKindOfClass:NSArray.class] && cookies.count > 0) {
        NSHTTPCookieStorage *cookiesStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in cookies) {
            [cookiesStorage setCookie:cookie];
        }
    }
}

// 保存cookie
- (void)saveCookies
{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [cookieStorage cookies];
    if (cookies.count > 0) {
        NSData *cookieData = [NSKeyedArchiver archivedDataWithRootObject:cookies];
        
        [[NSUserDefaults standardUserDefaults] setObject:cookieData forKey:TS_HTTP_COOKIE_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// 请求结束操作
- (void)requestDidFinishTag:(TSBaseRequest *)request
{
    if (request.error) {
        if (request.requestFailureBlock) {
            request.requestFailureBlock(request);
        }
        [request requestCompleteFailure];
    } else {
        [request requestCompleteSuccess];
    }
}
@end
