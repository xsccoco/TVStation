//
//  NSString+TSExtension.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TSExtension)
// str串是否是空串
+ (BOOL)isEmpty:(NSString *)str;

// 将str转换成非nil的字符串
+ (NSString *)safeEmptyString:(NSString *)str;

// 过滤特殊字符
+ (NSString *)filterSpecialOnlyString:(NSString *)originStr;
@end

NS_ASSUME_NONNULL_END
