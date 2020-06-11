//
//  TSNetworkUtil.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/9.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSNetworkUtil.h"
#import "TSNetworkConstant.h"
#import "TSDeviceUtil.h"

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


// json转dict
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// dict转json
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dict
{
    if (dict == nil) {
        return nil;
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

// 给指定文件目录添加不备份属性
+ (void)addDoNotBackupAttribute:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        NSLog(@"error in set back up attribute: %@", error.localizedDescription);
    }
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

@end

