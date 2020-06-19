//
//  TSNetworkUtil.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/9.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSNetworkUtil.h"
#import "TSDeviceUtil.h"
#import "TSEncryptUtil.h"
#import "NSString+TSExtension.h"

static NSString * TSPercentEscapedStringFromString(NSString *string) {
    static NSString * const kTSCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kTSCharactersSubDelimitersToEncode = @"!$&'()*+,;=";

    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kTSCharactersGeneralDelimitersToEncode stringByAppendingString:kTSCharactersSubDelimitersToEncode]];

    // FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];

    static NSUInteger const batchSize = 50;

    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;

    while (index < string.length) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wgnu"
        NSUInteger length = MIN(string.length - index, batchSize);
#pragma GCC diagnostic pop
        NSRange range = NSMakeRange(index, length);

        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [string rangeOfComposedCharacterSequencesForRange:range];

        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];

        index += range.length;
    }

    return escaped;
}

#pragma mark -

@interface TSQueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (instancetype)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValue;

- (NSString *)URLStringValue;
@end

@implementation TSQueryStringPair

- (instancetype)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.field = field;
    self.value = value;

    return self;
}

- (NSString *)URLEncodedStringValue {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return TSPercentEscapedStringFromString([self.field description]);
    } else {
        return [NSString stringWithFormat:@"%@=%@", TSPercentEscapedStringFromString([self.field description]), TSPercentEscapedStringFromString([self.value description])];
    }
}

- (NSString *)URLStringValue {
//    if (!self.value || [self.value isEqual:[NSNull null]]) {
//        return [self.field description];
//    }
    if (!self.value || [self.value isEqual:[NSNull null]] || [self.value isEqual:@""]) {
        return nil; //20170730李运确认修改
    }  else {
        NSString *valueTmp = [NSString filterSpecialOnlyString:[self.value description]];
        if (!valueTmp || [valueTmp isEqual:[NSNull null]] || [valueTmp isEqual:@""]) {
            return nil;
        }
        return [NSString stringWithFormat:@"%@=%@", ([self.field description]), (valueTmp)];
    }
}

@end


@implementation TSNetworkUtil

#pragma mark - publicMethods
+ (NSDictionary*)commonParamsApiVersionModFlag
{
    NSDictionary *params = @{@"apiVersion":API_VERSION,
                             @"modFlag":@([[NSUserDefaults standardUserDefaults] integerForKey:KEY_REQUEST_MODFLAG])
                             };
    return params;
}

+ (NSDictionary*)commonParamsImeiTerminalType
{
    NSDictionary *params = @{@"imei":[self getSSKeychainValue],
                             @"terminalType":KEY_TERMINAL_TYPE
                             };
    return params;
}

+ (NSDictionary*)commonParams
{
    NSDictionary *params = @{@"imei":[self getSSKeychainValue],
                             @"terminalType":KEY_TERMINAL_TYPE,
                             @"apiVersion":API_VERSION,
                             @"modFlag":@([[NSUserDefaults standardUserDefaults] integerForKey:KEY_REQUEST_MODFLAG])
                             };
    return params;
}

// 新增参数系统版本号
+ (NSDictionary*)commonParamsAppVersion
{
    NSDictionary *params = @{@"clientVersion":[@"v" stringByAppendingString:[self appVersionString]]
                             };
    return params;
}

// 对请求的URL进行加密处理
+ (NSString *)getSecurityKey:(NSURL *)requestURL withParameters:(id)parameters requestMethod:(TSRequestMethod)requestMethod
{
    
    //根据url是否包含imurl
    NSString *url = requestURL.absoluteString;
    NSString *imUrl = [[NSUserDefaults standardUserDefaults] objectForKey:TSParamPaasApiUrl];
    if (imUrl) {
        if ([url containsString:imUrl]) {
            return  [self getMessageSecurityKey:requestURL withParameters:parameters requestMethod:requestMethod];
        }
    }
    return [self getNormalSecurityKey:requestURL withParameters:parameters requestMethod:requestMethod];
}

// 当前应用版本号
+ (NSString *)appVersionString
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark - privateMethods

// 当前设备的uuid
+ (NSString *)getSSKeychainValue
{
    return [TSDeviceUtil getSSKeychainValue];
}

// 对普通请求的URL进行加密处理
+ (NSString *)getNormalSecurityKey:(NSURL *)requestURL withParameters:(id)parameters requestMethod:(TSRequestMethod)requestMethod
{
    // 添加必要的防攻击代码
    NSString *formatCode = [requestURL path];
    // requestParam md5加密
    NSString *requestParam = nil;
    NSString *param = nil;
    if (parameters) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if ([parameters isKindOfClass:[NSDictionary class]]) {
            for (NSString *key in ((NSDictionary*)parameters).allKeys) {
                [dict setObject:[(NSDictionary*)parameters valueForKey:key] forKey:key.lowercaseString];
            }
        }
        //20170724编码规则修正
        requestParam = YFPercentEscapedStringFromString(TSQueryStringFromParametersNoEncoding(dict));
        
        
        param = [TSEncryptUtil md5String:requestParam];
    }
    
    NSString *securitykey = [TSEncryptUtil md5String:KEY_APP_SECRET];
    
    //1.所有value的值需要utf8编码
    //2.生成butelsign原文：
    //service=formatCode&securitykey=MD5(securitykey)&butelTst=1493709800222&param=MD5(requestParam)
    //如果requestParam为空(null 或者空串)，则原文如下：
    //service=formatCode&securitykey=MD5(securitykey)&butelTst=1493709800222
    NSString *bulteSign = nil;
    NSTimeInterval dateInterval = [[NSDate date] timeIntervalSince1970];
    if (requestParam) {
        bulteSign = [NSString stringWithFormat:@"service=%@&securitykey=%@&butelTst=%ld&param=%@",formatCode,securitykey,(long)dateInterval*1000, param];
    } else {
        bulteSign = [NSString stringWithFormat:@"service=%@&securitykey=%@&butelTst=%ld",formatCode,securitykey,(long)dateInterval*1000];
    }
    NSLog(@"requestParam:%@",requestParam);
    bulteSign = [TSEncryptUtil md5String:bulteSign];
    NSString *addQueryStr = [NSString stringWithFormat:@"butelAppkey=%@&butelTst=%ld&butelSign=%@",KEY_APP_ID,(long)dateInterval*1000,bulteSign];
    NSLog(@"add QueryStr:%@",addQueryStr);
    return addQueryStr;
    
}

// 对消息请求的URL进行加密处理
+ (NSString *)getMessageSecurityKey:(NSURL *)requestURL withParameters:(id)parameters requestMethod:(TSRequestMethod)requestMethod
{
    
    // 添加必要的防攻击代码
    NSString *path = [requestURL path];
    
    NSArray *pathArr = [path componentsSeparatedByString:@"/"];
    NSString *formatCode = [pathArr lastObject];
    
    // requestParam md5加密
    NSString *requestParam = nil;
    NSString *param = nil;

    if (parameters) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        if ([parameters isKindOfClass:[NSDictionary class]]) {
            for (NSString *key in ((NSDictionary*)parameters).allKeys) {
                [dict setObject:[(NSDictionary*)parameters valueForKey:key] forKey:key.lowercaseString];
            }
        }
        //后台要求不要对=进行转码
        if (requestMethod ==TSRequestMethodPOST) {
            requestParam = [dict yy_modelToJSONString];
        }else{
            requestParam = TSQueryStringFromParametersNoEncoding(dict);
        }
        param = [TSEncryptUtil md5String:requestParam];
    }
    NSString *appsecret = [[NSUserDefaults standardUserDefaults] valueForKey:TSParamNewTopicClientAppSecretKey];
    if (!appsecret) {
        appsecret = @"";
    }
    NSString *securitykey = [TSEncryptUtil md5String:appsecret];
    //1.所有value的值需要utf8编码
    //2.生成sign原文：
    //service=formatCode&securitykey=MD5(appsecret)&timestamp=1493709800222&param=MD5(requestParam)
    //如果requestParam为空(null 或者空串)，则原文如下：
    //service=formatCode&securitykey=MD5(securitykey)&timestamp=1493709800222
    NSString *messageSign = nil;
    NSTimeInterval dateInterval = [[NSDate date] timeIntervalSince1970] *1000;
    
    if (requestParam) {
        messageSign = [NSString stringWithFormat:@"service=%@&securitykey=%@&timestamp=%ld&param=%@",formatCode,securitykey,(long)dateInterval, param];
    } else {
        messageSign = [NSString stringWithFormat:@"service=%@&securitykey=%@&timestamp=%ld",formatCode,securitykey,(long)dateInterval];
    }
    NSLog(@"requestParam:%@",requestParam);
    messageSign = [TSEncryptUtil md5String:messageSign];
    NSString *appkey    = [[NSUserDefaults standardUserDefaults] valueForKey:TSParamNewTopicClientAppKeyKey];
//    NSString *appkey = @"68e6a8db48bb4870";
    
    if (!appkey) {
        appkey = @"";
    }
    
    NSString *addQueryStr = [NSString stringWithFormat:@"appkey=%@&timestamp=%ld&sign=%@",appkey,(long)dateInterval,messageSign];
    NSLog(@"add QueryStr:%@",addQueryStr);
    return addQueryStr;
}


//20170724扬帆修正URL编码
NSString * YFPercentEscapedStringFromString(NSString *string) {
    static NSString * const kAFCharactersGeneralDelimitersToEncode = @""; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'(),;=:#[]@/?~+";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
    
    // FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    while (index < string.length) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wgnu"
        NSUInteger length = MIN(string.length - index, batchSize);
#pragma GCC diagnostic pop
        NSRange range = NSMakeRange(index, length);
        
        // To avoid breaking up character sequences such as ����
        range = [string rangeOfComposedCharacterSequencesForRange:range];
        
        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    
    return escaped;
}


#pragma mark -


FOUNDATION_EXPORT NSArray * TSQueryStringPairsFromDictionary(NSDictionary *dictionary);
FOUNDATION_EXPORT NSArray * TSQueryStringPairsFromKeyAndValue(NSString *key, id value);

NSString * TSQueryStringFromParameters(NSDictionary *parameters) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (TSQueryStringPair *pair in TSQueryStringPairsFromDictionary(parameters)) {
        [mutablePairs addObject:[pair URLEncodedStringValue]];
    }

    return [mutablePairs componentsJoinedByString:@"&"];
}

NSString * TSQueryStringFromParametersNoEncoding(NSDictionary *parameters) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
//    for (TSQueryStringPair *pair in TSQueryStringPairsFromDictionary(parameters)) {
//        if ([pair URLStringValue] != nil) {
//            [mutablePairs addObject:[pair URLStringValue]];
//        }
//    }
    //20170804李运确认修改
    for (TSQueryStringPair *pair in TSQueryStringPairsFromDictionary(parameters)) {
        if ([pair URLStringValue]) {
            [mutablePairs addObject:[pair URLStringValue]];
        }
    }
    return [[mutablePairs componentsJoinedByString:@"&"] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}


NSArray * TSQueryStringPairsFromDictionary(NSDictionary *dictionary) {
    return TSQueryStringPairsFromKeyAndValue(nil, dictionary);
}

NSArray * TSQueryStringPairsFromKeyAndValue(NSString *key, id value) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];

    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];

    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = dictionary[nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:TSQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:TSQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:TSQueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[TSQueryStringPair alloc] initWithField:key value:value]];
    }

    return mutableQueryStringComponents;
}

@end

