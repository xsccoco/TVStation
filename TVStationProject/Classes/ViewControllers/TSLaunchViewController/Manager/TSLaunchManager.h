//
//  TSLaunchManager.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSGetParameterListRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSLaunchManager : NSObject
// 获取系统参数接口
@property (nonatomic, strong, readonly) TSGetParameterListRequest *paramsRequest;


// 获取系统参数
- (void)getParameterList;
@end

NS_ASSUME_NONNULL_END
