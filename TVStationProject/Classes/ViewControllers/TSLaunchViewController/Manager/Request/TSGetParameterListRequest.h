//
//  TSGetParameterListRequest.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSBaseRequest.h"
#import "TSGetParameterListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSGetParameterListRequest : TSBaseRequest
//非空场合，按差分返回大于updateTime时间的数据  非必填
@property (nonatomic, assign) long updateTime;

- (TSGetParameterListModel *)responseModel;
@end

NS_ASSUME_NONNULL_END
