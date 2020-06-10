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

@end
