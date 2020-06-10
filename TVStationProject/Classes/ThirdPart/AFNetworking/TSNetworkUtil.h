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
@end

NS_ASSUME_NONNULL_END
