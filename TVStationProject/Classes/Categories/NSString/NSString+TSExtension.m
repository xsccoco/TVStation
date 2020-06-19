//
//  NSString+TSExtension.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "NSString+TSExtension.h"

@implementation NSString (TSExtension)

// str串是否是空串
+ (BOOL)isEmpty:(NSString *)str
{
    if (str == nil || str == NULL || [str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!str.length) {
        return YES;
    }
    if (str == nil || [@"" isEqualToString:str] || [@"(null)" isEqualToString:str]) {
        return YES;
    }
    return NO;
}

// 将str转换成非nil的字符串
+ (NSString *)safeEmptyString:(NSString *)str
{
    if ([NSString isEmpty:str]) {
        return @"";
    }
    return str;
}

// 过滤特殊字符
+ (NSString *)filterSpecialOnlyString:(NSString *)originStr
{
    if ([originStr isKindOfClass:[NSString class]]) {
        NSString *regex = @"^[A-Za-z\\d\\u4E00-\\u9FA5]+$";
        NSMutableString *resultStr = [NSMutableString string];
        NSInteger length = originStr.length;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        int index = 0;
        for (; index < length; index++) {
            NSString *str = [originStr substringWithRange:NSMakeRange(index, 1)];
            if ([predicate evaluateWithObject:str]) {
                [resultStr appendString:str];
            }
        }
        return resultStr;
    } else {
        return originStr;
    }
}
@end
