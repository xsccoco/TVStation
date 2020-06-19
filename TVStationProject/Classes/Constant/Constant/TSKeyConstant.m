//
//  TSKeyConstant.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/19.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSKeyConstant.h"

#pragma mark - 系统参数
// pass平台
// 访问paas平台的token
NSString * const TSParamPassToken = @"apptoken";
// paas回调接口地址
NSString * const TSParamPassCallBack = @"callBack";
// 后台媒体处理接口服务器的地址
NSString * const TSParamSDKMediaProcessAddress = @"sdkpMediaProcessAddress";
// 上传备用url
NSString * const TSParamFileuploadurlbak = @"fileuploadurlbak";
// 圈子系统的paastoken
NSString * const TSParamApptokenForCircle = @"apptokenForCircle";
// 直播厅获取历史消息paas接口地址
NSString * const TSParamPaasApiUrl = @"paasApiUrl";
// 消息服务接口地址
NSString * const TSParamPaasImServerUrl = @"PaasImServerUrl";
// topic消息接口初始化参数
NSString * const TSParamNewTopicInitParam = @"newTopicInitParam";

// H5平台
// 第三方页面（用户反馈、注册协议、关于杨帆、免责声明）
NSString * const TSParamThirdPartyUrl = @"thirdPartyPageUrl";
// 我的消息html页面url
NSString * const TSParamMyNoticePageUrl = @"myNoticePageUrl";
// 行为汇报地址--手机终端汇用户行为
NSString * const TSParamUserActionUrl = @"userActionUrl";
// 专辑详情页面地址
NSString * const TSParamAlbumDetailUrl = @"albumDetailUrl";
// 我的积分、经验等级、积分兑换、兑换记录URL集合
NSString * const TSParamCreditLevelUrl = @"creditLevelUrl";

// 文字互动
// 单位秒控制发评论的时间间隔，同一个终端（或用户）在指定时间内（默认为20秒，后台可设置参数）只能发布一条内容；发评论小于指定时间间隔，则提示用户“您发表评论过于频繁，请稍后再发”。
NSString * const TSParamCommentIntervalTime = @"commentIntervalTime";

// 摇一摇平台
// 我的红包”h5页面的url
NSString * const TSParamMyRedPacketH5Url = @"myRedPacketH5Url";
// 喊红包接口地址
NSString * const TSParamShoutKeyUrl = @"shoutKeyUrl";
// 喊红包新签名接口地址
NSString * const TSParamShoutKeySignUrl = @"shoutKeySignUrl";
// 喊红包新签名接口签名公钥
NSString * const TSParamShoutKeySignPublicKey = @"shoutKeySignPublicKey";
// 喊红包新签名接口aapid
NSString * const TSParamShoutKeySignAppid = @"shoutKeySignAppid";

// 其他系统
// 默认投稿频道ID（专题频道）
NSString * const TSParamContributeChannelId = @"contributeDefChannelId";
// 默认投稿频道名称
NSString * const TSParamContributeChannelName = @"contributeDefChannelName";
// 红云用户中心appkey
NSString * const TSParamUserCenterAppKey = @"usercenter_appkey";
// 支付接口地址
NSString * const TSParamPayWebapiUrl = @"payWebapiUrl";
// 扬帆pc登录地址
NSString * const TSParamPcLoginUrl = @"pcLoginUrl";
// 红包显示开关，1：显示，0：不显示
NSString * const TSParamRedPacketSwitch = @"redPacketSwitch";
// 首页推荐频道展开开关 1：展开  0：不展开
NSString * const TSParamColumnExpandSwitch = @"columnExpandSwitch";
// 红包系统默认图片地址
NSString * const TSParamRedPacketPicUrl = @"redPacketPicUrl";
// 申请个人频道功能显示开关，1：显示，0：不显示
NSString * const TSParamRegisterChannelFlag = @"registerChannelFlag";
// 开通个人频道审核退回访问地址
NSString * const TSParamRegisterAuditinfo = @"registerAuditinfo";
// 申请开通频道和编辑频道资料访问地址
NSString * const TSParamRegisterAppspace = @"registerAppspace";
// 主播下载页面地址(APP使用)
NSString * const TSParamDownAnchorUrl = @"downAnchorUrl";
// 圈子模块爆料TopicId
NSString * const TSParamCircleTipoffId = @"circleTipoffId";
// 商城首页URL
NSString * const TSParamMallHomePageUrl = @"mallHomePageUrl";
// 商城搜索页URL
NSString * const TSParamSearchPageUrl = @"searchPageUrl";
// 商城搜索热词
NSString * const TSParamSearchHotwords = @"searchHotwords";
// 我的购物车
NSString * const TSParamMyShoppingMallUrl = @"myShoppingMallUrl";
// 我的账单
NSString * const TSParamFundsOrderlistUrl = @"fundsOrderlistUrl";
// webP是否开启（ 0:是未开启，1是开启 ）
NSString * const TSParamIsWebpOn = @"isWebpOn";
// 皮肤样式：0:默认，1:黑白，2:国庆，3:春节，5:中秋，6:自定义
NSString * const TSParamSkinStyle = @"skinStyle";
// 邀请注册URL地址集【json字符串】
NSString * const TSParamInvitedregister = @"invitedregister";
// 阿里短视频投稿频道参数
NSString * const TSParamAliSvChannelId = @"aliSvChannelId";
// 是否显示打赏按钮 0：否        1：是
NSString * const TSParamIsShowPayButton = @"isShowPayButton";
// iOS h5富文本模板文件参数 version：模板的版本号 downloadUrl：模板文件zip包的下载地址
NSString * const TSParamH5Template = @"h5Template";
// 自定义主题数据： titleBgUrl：首页主标题背景图片； titleColor：二级页面标题颜色
NSString * const TSParamAppStyleConf = @"appStyleConf";
// 文章图集是否使用原H5页面【1表示使用，其他为不使用】
NSString * const TSParamArticleUseH5Page = @"articleUseH5Page";


//文件上传服务入口地址
NSString * const TSParamFileUploadUrlKey = @"fileUploadUrlKey";
//文件处理服务地址
NSString * const TSParamFileProcessUrlKey = @"fileProcessUrlKey";
// new topicclient sdk appKey
NSString * const TSParamNewTopicClientAppKeyKey = @"newTopicClientAppKeyKey";
// new topicclient sdk appSecrect
NSString * const TSParamNewTopicClientAppSecretKey = @"newTopicClientAppSecrectKey";
// TIM: 腾讯云通信应用id
NSString * const TSParamNewTopicClientAppIdKey = @"newTopicClientAppIdKey";
// 阿里云短视频投稿的频道id
NSString * const TSParamAliContributeChannelIdKey = @"aliContributeChannelIdKey";
// 阿里云短视频投稿的频道名称
NSString * const TSParamAliContributeChannelNameKey = @"aliContributeChannelNameKey";
// h5模板文件的版本
NSString * const TSParamHtmlTemplateVersionKey = @"htmlTemplateVersionKey";
// h5模板文件下载地址
NSString * const TSParamHtmlTemplateDownloadUrlKey = @"htmlTemplateDownloadUrlKey";


// 是否显示过引导页，引导页致显示一次
NSString * const TSHasShowUserGuideKey = @"hasShowUserGuideKey";
// 是否是首次安装
NSString * const TSIsFirstSetupKey = @"isFirstSetupKey";

@implementation TSKeyConstant


@end
