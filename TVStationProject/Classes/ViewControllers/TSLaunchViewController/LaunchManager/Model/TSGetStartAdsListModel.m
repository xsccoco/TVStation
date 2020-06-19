//
//  TSGetStartAdsListModel.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/11.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSGetStartAdsListModel.h"


@implementation TSGetStartAdContentModel

@end


@implementation TSGetStartAdModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"contentRows":[TSGetStartAdContentModel class]};
}

@end

@implementation TSGetStartAdsListData

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"rows":[TSGetStartAdModel class]};
}

@end

@implementation TSGetStartAdsListModel

@end
