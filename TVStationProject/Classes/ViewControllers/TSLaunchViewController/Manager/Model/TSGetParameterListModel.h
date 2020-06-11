//
//  TSGetParameterListModel.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/11.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSParamModel : NSObject

// 参数名
@property(nonatomic,strong) NSString *name;
// 参数值
@property(nonatomic,strong) NSString *value;
// 更新时间
@property(nonatomic,strong) NSString *updateTime;
@end


@interface TSPassParamModel : NSObject

// 文件上传服务入口地址 格式：p:port或域名:port
@property(nonatomic,strong) NSString *fileuploadurl;
// 文件处理服务地址 格式：ip:port或域名:port
@property(nonatomic,strong) NSString *fileprocessurl;

@end

@interface TSGetParameterListData : NSObject

// 记录总数
@property (nonatomic, assign) int totalCount;
@property (nonatomic,strong) TSPassParamModel *paasParams;
@property (nonatomic,strong) NSArray *rows;

@end

@interface TSGetParameterListModel : TSBaseModel

@property (nonatomic, strong) TSGetParameterListData *data;

@end

NS_ASSUME_NONNULL_END
