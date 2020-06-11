//
//  TSGetStartAdsListModel.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/11.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSGetStartAdContentModel : NSObject
//id    string    广告内容标识
@property (nonatomic, strong) NSString *id;
// 所属广告主题标识
@property (nonatomic, strong) NSString *advertisementId;
// 广告内容名称
@property (nonatomic, strong) NSString *title;
// 播放资源地址
@property (nonatomic, strong) NSString *displayUrl;
// Pad用播放资源地址
@property (nonatomic, strong) NSString *displayUrlForPad;
// 广告大图url，iPhone X备用
@property (nonatomic, strong) NSString *bigPicUrl;
// 链接类型：参考【链接类型】
@property (nonatomic, assign) int actionType;
// 链接地址：参考【链接地址】
@property (nonatomic, strong) NSString *actionUrl;
// 链接类型为5时返回，为17时可能返回(频道下的功能板块会返回)
@property (nonatomic, strong) NSString *channelId;
// 内链内容为资讯时返回：资讯所属频道名称
@property (nonatomic, strong) NSString *channelName;
// 内链内容为资讯、音频时返回：资讯ID
@property (nonatomic, strong) NSString *contentId;
// 分享标题
@property (nonatomic, strong) NSString *shareTitle;
// 分享内容
@property (nonatomic, strong) NSString *shareContent;
// 分享小图片
@property (nonatomic, strong) NSString *shareImg;
// 分享大图片
@property (nonatomic, strong) NSString *shareBigImg;
// 分享URL
@property (nonatomic, strong) NSString *shareUrl;

@end


@interface TSGetStartAdModel : NSObject

// 广告主题标识
@property (nonatomic, strong) NSString *id;
// 主题名称
@property (nonatomic, strong) NSString *title;
// 主题类型:1. 图片； 2. 视频
@property (nonatomic, assign) int type;
// 是否默认主题:0. 否 1.是
@property (nonatomic, assign) int isDefault;
// 开始生效日期：yyyyMMdd
@property (nonatomic, strong) NSString *startDate;
// 结束生效日期：yyyyMMdd
@property (nonatomic, strong) NSString *stopDate;
// 生效时段:json串格式[{start:HHmm,stop:xxx},{start:xxx,stop:xxx}]
@property (nonatomic, strong) NSString *effectiveTime;
// 是否允许跳过:0.不允许1.允许
@property (nonatomic, assign) int isSkip;
// 持续时间
@property (nonatomic, assign) int duration;
@property (nonatomic,strong) NSArray *contentRows;

@end

@interface TSGetStartAdsListData : NSObject

// 记录总数
@property (nonatomic, assign) int totalCount;
@property (nonatomic,strong) NSArray *rows;

@end

@interface TSGetStartAdsListModel : TSBaseModel

@property (nonatomic, strong) TSGetStartAdsListData *data;

@end

NS_ASSUME_NONNULL_END
