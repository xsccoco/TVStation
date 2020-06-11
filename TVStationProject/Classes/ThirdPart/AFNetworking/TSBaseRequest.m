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
#import "TSFileUtil.h"
#import "TSEncryptUtil.h"
#import "TSNetworkUtil.h"


@interface TSBaseRequest ()

// 接口缓存数据
@property (nonatomic, strong) id cacheJson;
@property (nonatomic, assign) BOOL dataFromCache;

@end

@implementation TSBaseRequest

#pragma mark - publicMethods

// 开始请求
- (void)start
{
    _dataFromCache = NO;
    self.status = TSRequestStatusRunning;
    NSLog(@"%@ url:%@%@", NSStringFromClass(self.class), [self requestBaseUrl], [self requestUrl]);
    NSLog(@"%@ params:%@", NSStringFromClass(self.class), [self requestParameter]);
    [[TSNetworkManager shareInstance] startRequest:self];
}


// 开始请求带缓存的
- (void)startWithCache
{
    if (self.useCache && self.cacheTimeInSeconds > 0) {
        NSString *path = [self cacheFilePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path isDirectory:nil]) {
            // 检查缓存时间
            long seconds = [TSFileUtil cacheFileDuration:path];
            if (seconds > 0 || seconds < [self cacheTimeInSeconds]) {
                // 加载缓存
                _cacheJson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
                if (_cacheJson) {
                    _dataFromCache = YES;
                    self.responseObject = self.cacheJson;
                    [self requestCompleteSuccess];
                    return;
                }
            }
        }
    }
    [self start];
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
    if (self.useCache) {
        [self saveJsonResponseToCacheFile:self.responseObject];
    }
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


// 返回当前缓存数据
- (id)cacheJson
{
    NSString *path = [self cacheFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path isDirectory:nil] == YES) {
        _cacheJson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    } else {
        _cacheJson = nil;
    }
    return _cacheJson;
}

// 当前数据是否从缓存获得
- (BOOL)isDataFromCache
{
    return _dataFromCache;
}

// 更新缓存
- (void)updateJsonResponse:(id)jsonResponse
{
    if (jsonResponse) {
        [NSKeyedArchiver archiveRootObject:jsonResponse toFile:[self cacheFilePath]];
    }
}

#pragma mark - 子类覆盖方法
// 是否使用缓存
- (BOOL)useCache
{
    return NO;
}

// 缓存有效时间，单位秒，默认300s
- (NSInteger)cacheTimeInSeconds
{
    return 5*60;
}

// 向缓存文件名添加关键敏感词
- (id)cacheSensitiveData
{
    return nil;
}

// 是否可以更新缓存，default YES
- (BOOL)canUpdateCache:(id)jsonResponse
{
    return YES;
}

// 用于在cache结果，计算cache文件名时，忽略掉一些指定的参数
- (id)cacheFileNameFilterForRequestParameter:(id)parameter
{
    return parameter;
}

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

#pragma mark - privateMethods

- (NSString *)cacheFilePath
{
    NSString *cacheFileName = [self cacheFileName];
    NSString *path = [TSFileUtil getBasePathWithEndString:@"TSNetworkLazyRequestCache"];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

- (NSString *)cacheFileName
{
    NSString *requestUrl = [self requestUrl];
    NSString *baseUrl = [self requestBaseUrl];
    id argument = [self cacheFileNameFilterForRequestParameter:self.requestParameter];
    NSString *requestInfo = [NSString stringWithFormat:@"Method:%ld Host:%@ Url:%@ Argument:%@ AppVersion:%@ Sensitive:%@", (long)self.requestMethod, baseUrl, requestUrl, argument, [TSNetworkUtil appVersionString], [self cacheSensitiveData]];
    NSString *cacheFileName = [TSEncryptUtil md5String:requestInfo];
    return cacheFileName;
}

- (void)saveJsonResponseToCacheFile:(id)jsonResponse
{
    if ([self cacheTimeInSeconds] > 0 && ![self isDataFromCache] && [self canUpdateCache:jsonResponse]) {
        NSDictionary *json = jsonResponse;
        if (json != nil) {
            [NSKeyedArchiver archiveRootObject:json toFile:[self cacheFilePath]];
        }
    }
}

@end
