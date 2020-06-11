//
//  TSGetParameterListRequest.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSGetParameterListRequest.h"

@implementation TSGetParameterListRequest


- (id)requestParameter
{
    NSArray *keysArray = @[@"apptoken"];
    
    NSString *keys = [keysArray componentsJoinedByString:@","];
    NSDictionary *params = @{@"keys":keys};
    return @{@"service":@"getParameterList",
             @"params":[params yy_modelToJSONString]};
}

- (TSGetParameterListModel *)responseModel
{
    TSGetParameterListModel *response = [TSGetParameterListModel yy_modelWithDictionary:self.responseObject];
    return response;
}
@end
