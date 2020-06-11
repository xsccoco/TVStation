//
//  TSGetStartAdsListRequest.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/11.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSBaseRequest.h"
#import "TSGetStartAdsListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSGetStartAdsListRequest : TSBaseRequest


- (TSGetStartAdsListModel *)responseModel;
@end

NS_ASSUME_NONNULL_END
