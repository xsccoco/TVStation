//
//  TSEncryptUtil.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/11.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSEncryptUtil : NSObject
// md5加密
+ (NSString *)md5String:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
