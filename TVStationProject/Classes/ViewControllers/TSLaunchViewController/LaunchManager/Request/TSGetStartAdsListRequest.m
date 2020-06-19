//
//  TSGetStartAdsListRequest.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/11.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSGetStartAdsListRequest.h"

@implementation TSGetStartAdsListRequest

- (id)requestParameter
{
    NSDictionary *params = [[NSDictionary alloc] init];
    return @{@"service":@"getStartAdsList",
             @"params":[params yy_modelToJSONString]
             };
}

- (BOOL)useCache
{
    return YES;
}

- (id)cacheFileNameFilterForRequestParameter:(id)parameter
{
    return @{@"service":@"getStartAdsList"};
}

- (BOOL)canUpdateCache:(id)jsonResponse
{
    if (jsonResponse) {
        TSGetStartAdsListModel *response = [TSGetStartAdsListModel yy_modelWithJSON:jsonResponse];
        if (response) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (TSGetStartAdsListModel *)responseModel
{
    TSGetStartAdsListModel *response = [TSGetStartAdsListModel yy_modelWithDictionary:self.responseObject];
    return response;
}
@end
