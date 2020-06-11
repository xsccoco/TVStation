//
//  TSBaseModel.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSNetworkConstant.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSBaseModel : NSObject

// 返回状态码，详见接口返回状态码表
@property (nonatomic, assign) TSResponseStatus state;
// 结果描述
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *currTime;

// 接口返回扩展字段  20190328
//扩展状态，比如app版本不兼容时，返回此字段为1101
@property (nonatomic, assign) int extendState;
//扩展信息，比如app版本不兼容时，返回此字段
@property (nonatomic, strong) NSString *extendMsg;

// 校验登录是否失效
- (BOOL)isTokenInvalid;
// 校验登录是否失效
- (BOOL)isVersionIncompatible;

@end

NS_ASSUME_NONNULL_END
