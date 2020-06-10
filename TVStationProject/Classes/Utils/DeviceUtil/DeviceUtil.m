//
//  DeviceUtil.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "DeviceUtil.h"
#import <SSKeychain.h>
#import "NSString+TSExtension.h"

NSString* keychainUUID = nil;
NSString * const KeyChainPwd = @"055273038.com.yunzhi.Yangfan";
NSString * const KeyChainAccount = @"user";

@implementation DeviceUtil

// 使用第三方库SSKeychain 获取保存在keychain里面的 uuid 如果第一次则生成一个并保存到keychain中
+ (NSString *)getSSKeychainValue
{
    if (![NSString isEmpty:keychainUUID]) {
        NSLog(@"getSSKeychainValue %@",keychainUUID);
        return keychainUUID;
    }
    NSError *error = nil;
    keychainUUID = [SSKeychain passwordForService:KeyChainPwd account:KeyChainAccount error:&error];
    if ([error code] == SSKeychainErrorBadArguments || [NSString isEmpty:keychainUUID]) {
        keychainUUID = [self generateUuid];
        OSStatus status = [SSKeychain setPassword:[NSString stringWithFormat:@"%@", keychainUUID] forService:KeyChainPwd account:KeyChainAccount];
        if (status != noErr) {
            NSLog(@"SSKeychain setPassword status:%d", status);
        }
    }
    return keychainUUID;
}


// 产生唯一标识
+ (NSString *)generateUuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(nil);
    CFStringRef uuidStringRef = CFUUIDCreateString(nil, uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)(uuidStringRef)];
    CFRelease(uuidStringRef);
    return uuid;
}
@end
