//
//  TSKeyConstant.h
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/19.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark - 系统参数
// pass平台
// 访问paas平台的token
extern NSString * const TSParamPassToken;
// paas回调接口地址
extern NSString * const TSParamPassCallBack;
// 后台媒体处理接口服务器的地址
extern NSString * const TSParamSDKMediaProcessAddress;
// 上传备用url
extern NSString * const TSParamFileuploadurlbak;
// 圈子系统的paastoken
extern NSString * const TSParamApptokenForCircle;
// 直播厅获取历史消息paas接口地址
extern NSString * const TSParamPaasApiUrl;
// 消息服务接口地址
extern NSString * const TSParamPaasImServerUrl;
// topic消息接口初始化参数
extern NSString * const TSParamNewTopicInitParam;

// H5平台
// 第三方页面（用户反馈、注册协议、关于杨帆、免责声明）
extern NSString * const TSParamThirdPartyUrl;
// 我的消息html页面url
extern NSString * const TSParamMyNoticePageUrl;
// 行为汇报地址--手机终端汇用户行为
extern NSString * const TSParamUserActionUrl;
// 专辑详情页面地址
extern NSString * const TSParamAlbumDetailUrl;
// 我的积分、经验等级、积分兑换、兑换记录URL集合
extern NSString * const TSParamCreditLevelUrl;

// 文字互动
// 单位秒控制发评论的时间间隔，同一个终端（或用户）在指定时间内（默认为20秒，后台可设置参数）只能发布一条内容；发评论小于指定时间间隔，则提示用户“您发表评论过于频繁，请稍后再发”。
extern NSString * const TSParamCommentIntervalTime;

// 摇一摇平台
// 我的红包”h5页面的url
extern NSString * const TSParamMyRedPacketH5Url;
// 喊红包接口地址
extern NSString * const TSParamShoutKeyUrl;
// 喊红包新签名接口地址
extern NSString * const TSParamShoutKeySignUrl;
// 喊红包新签名接口签名公钥
extern NSString * const TSParamShoutKeySignPublicKey;
// 喊红包新签名接口aapid
extern NSString * const TSParamShoutKeySignAppid;

// 其他系统
// 默认投稿频道ID（专题频道）
extern NSString * const TSParamContributeChannelId;
// 默认投稿频道名称
extern NSString * const TSParamContributeChannelName;
// 红云用户中心appkey
extern NSString * const TSParamUserCenterAppKey;
// 支付接口地址
extern NSString * const TSParamPayWebapiUrl;
// 扬帆pc登录地址
extern NSString * const TSParamPcLoginUrl;
// 红包显示开关，1：显示，0：不显示
extern NSString * const TSParamRedPacketSwitch;
// 首页推荐频道展开开关 1：展开  0：不展开
extern NSString * const TSParamColumnExpandSwitch;
// 红包系统默认图片地址
extern NSString * const TSParamRedPacketPicUrl;
// 申请个人频道功能显示开关，1：显示，0：不显示
extern NSString * const TSParamRegisterChannelFlag;
// 开通个人频道审核退回访问地址
extern NSString * const TSParamRegisterAuditinfo;
// 申请开通频道和编辑频道资料访问地址
extern NSString * const TSParamRegisterAppspace;
// 主播下载页面地址(APP使用)
extern NSString * const TSParamDownAnchorUrl;
// 圈子模块爆料TopicId
extern NSString * const TSParamCircleTipoffId;
// 商城首页URL
extern NSString * const TSParamMallHomePageUrl;
// 商城搜索页URL
extern NSString * const TSParamSearchPageUrl;
// 商城搜索热词
extern NSString * const TSParamSearchHotwords;
// 我的购物车
extern NSString * const TSParamMyShoppingMallUrl;
// 我的账单
extern NSString * const TSParamFundsOrderlistUrl;
// webP是否开启（ 0:是未开启，1是开启 ）
extern NSString * const TSParamIsWebpOn;
// 皮肤样式：0:默认，1:黑白，2:国庆，3:春节，5:中秋，6:自定义
extern NSString * const TSParamSkinStyle;
// 邀请注册URL地址集【json字符串】
extern NSString * const TSParamInvitedregister;
// 阿里短视频投稿频道参数
extern NSString * const TSParamAliSvChannelId;
// 是否显示打赏按钮 0：否        1：是
extern NSString * const TSParamIsShowPayButton;
// iOS h5富文本模板文件参数 version：模板的版本号 downloadUrl：模板文件zip包的下载地址
extern NSString * const TSParamH5Template;
// 自定义主题数据： titleBgUrl：首页主标题背景图片； titleColor：二级页面标题颜色
extern NSString * const TSParamAppStyleConf;
// 文章图集是否使用原H5页面【1表示使用，其他为不使用】
extern NSString * const TSParamArticleUseH5Page;

//文件上传服务入口地址
extern NSString * const TSParamFileUploadUrlKey;
//文件处理服务地址
extern NSString * const TSParamFileProcessUrlKey;
// new topicclient sdk appKey
extern NSString * const TSParamNewTopicClientAppKeyKey;
// new topicclient sdk appSecrect
extern NSString * const TSParamNewTopicClientAppSecretKey;
// TIM: 腾讯云通信应用id
extern NSString * const TSParamNewTopicClientAppIdKey;
// 阿里云短视频投稿的频道id
extern NSString * const TSParamAliContributeChannelIdKey;
// 阿里云短视频投稿的频道名称
extern NSString * const TSParamAliContributeChannelNameKey;
// h5模板文件的版本
extern NSString * const TSParamHtmlTemplateVersionKey;
// h5模板文件下载地址
extern NSString * const TSParamHtmlTemplateDownloadUrlKey;


// 是否显示过引导页，引导页致显示一次
extern NSString * const TSHasShowUserGuideKey;
// 是否是首次安装
extern NSString * const TSIsFirstSetupKey;

@interface TSKeyConstant : NSObject

@end

NS_ASSUME_NONNULL_END
