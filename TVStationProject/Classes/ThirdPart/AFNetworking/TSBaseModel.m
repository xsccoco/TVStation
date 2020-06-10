//
//  TSBaseModel.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSBaseModel.h"

@implementation TSBaseModel
// token失效
- (BOOL)isTokenInvalid
{
    return (self.state == TSResponseStatusTokenValid) || (self.state == TSResponseStatusUserNotExist) || (self.state == TSResponseStatusUnknownTokenValid);
}

// 版本不兼容
- (BOOL)isVersionIncompatible
{
    return (self.state == TSResponseStatusVersionIncompatible);
}
@end
