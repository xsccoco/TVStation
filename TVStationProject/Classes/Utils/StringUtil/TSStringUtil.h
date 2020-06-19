//
//  TSStringUtil.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/19.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSStringUtil : NSObject
//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// 字典转成字符串
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
