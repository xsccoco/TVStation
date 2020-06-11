//
//  TSBaseRequest.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/8.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSNetworkConstant.h"
#import <AFNetworking.h>
#import "TSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);

@interface TSBaseRequest : NSObject
// 错误信息
@property (nonatomic, strong) NSError *error;
// 接口返回数据
@property (nonatomic, strong) id responseObject;
// 请求失败回调
@property (nonatomic, strong) void(^requestFailureBlock)(TSBaseRequest *request);
// 请求成功回调
@property (nonatomic, strong) void(^requestSuccessBlock)(TSBaseRequest *request);
// 下载进度回调
@property (nonatomic, copy) void(^downloadProgress)(NSProgress *progress);
// 上传进度回调
@property (nonatomic, copy) void(^uploadProgress)(NSProgress *progress);
// 请求任务
@property (nonatomic, strong) NSURLSessionDataTask *task;
// 请求状态
@property (nonatomic, assign) TSRequestStatus status;
// 请求token失效
@property (nonatomic, copy) void(^requestTokenInvalidateBlock)(TSBaseRequest *);
// 开始请求
- (void)start;

// 开始请求带缓存的
- (void)startWithCache;

// 开始请求设置成功失败回调
- (void)startWithRequestSuccessBlock:(void(^)(TSBaseRequest *request))success
                        failureBlock:(void(^)(TSBaseRequest *request))failure;

// 停止请求
- (void)stop;

// 请求是否正在执行
- (BOOL)isExecuting;

// 设置成功失败回调
- (void)setRequestSuccessBlock:(void(^)(TSBaseRequest *request))success
                  failureBlock:(void(^)(TSBaseRequest *request))failure;

// 设置成功失败token校验回调
- (void)setRequestSuccessBlock:(void (^)(TSBaseRequest *))success
                  failureBlock:(void (^)(TSBaseRequest *))failure
          tokenInvalidateBlock:(void (^)(TSBaseRequest *))tokenInvalidate;

// 请求接口成功
- (void)requestCompleteSuccess;
// 请求接口失败
- (void)requestCompleteFailure;


// 返回当前缓存数据
- (id)cacheJson;

// 当前数据是否从缓存获得
- (BOOL)isDataFromCache;

// 更新缓存
- (void)updateJsonResponse:(id)jsonResponse;

// 子类覆盖方法

// 是否使用缓存
- (BOOL)useCache;

// 缓存有效时间，单位秒，默认300s
- (NSInteger)cacheTimeInSeconds;

// 向缓存文件名添加关键敏感词
- (id)cacheSensitiveData;

// 是否可以更新缓存，default YES
- (BOOL)canUpdateCache:(id)jsonResponse;

// 用于在cache结果，计算cache文件名时，忽略掉一些指定的参数
- (id)cacheFileNameFilterForRequestParameter:(id)parameter;

// 是否使用Cookies, default NO
- (BOOL)useCookies;

// url是否已经编码了
- (BOOL)isAlreadEncode;

#pragma mark - 子类覆盖方法
// 请求的BaseUrl
- (NSString *)requestBaseUrl;

// 请求的url
- (NSString *)requestUrl;

// 请求的参数列表
- (id)requestParameter;

// 是否需要添加通用参数
- (BOOL)isNeedAddCommonParams;

// 请求的SerializerType
- (TSRequestSerializerType)requestSerializerType;

// 请求超时时间，默认为60s
- (NSTimeInterval)requestTimeoutInterval;

// 响应的SerializerType
- (TSResponseSerializerType)responseSerializerType;

// 请求方式
- (TSRequestMethod)requestMethod;

// 当POST的内容带有文件等富文本时使用
- (AFConstructingBlock)constructingBodyBlock;
@end

NS_ASSUME_NONNULL_END
