//
//  TSNetworkUtil.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/9.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSNetworkUtil : NSObject

// 通用参数
+ (NSDictionary*)commonParamsApiVersionModFlag;
+ (NSDictionary*)commonParamsImeiTerminalType;
+ (NSDictionary*)commonParams;
+ (NSDictionary*)commonParamsAppVersion;


// json转dict
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// dict转json
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dict;

// 当前应用版本号
+ (NSString *)appVersionString;

// 给指定文件目录添加不备份属性
+ (void)addDoNotBackupAttribute:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
