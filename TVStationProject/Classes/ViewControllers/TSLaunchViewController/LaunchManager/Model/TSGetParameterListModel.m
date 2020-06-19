//
//  TSGetParameterListModel.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/11.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSGetParameterListModel.h"

@implementation TSParamModel

@end

@implementation TSPassParamModel

@end

@implementation TSGetParameterListData

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"rows":[TSParamModel class]};
}

@end

@implementation TSGetParameterListModel

@end

