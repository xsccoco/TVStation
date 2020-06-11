//
//  TSDeviceUtil.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/11.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSDeviceUtil : NSObject

// 使用第三方库SSKeychain 获取保存在keychain里面的 uuid 如果第一次则生成一个并保存到keychain中
+ (NSString *)getSSKeychainValue;

@end

NS_ASSUME_NONNULL_END
