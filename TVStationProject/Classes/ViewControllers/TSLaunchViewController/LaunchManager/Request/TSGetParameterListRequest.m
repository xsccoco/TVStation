//
//  TSGetParameterListRequest.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSGetParameterListRequest.h"
#import "TSKeyConstant.h"

@implementation TSGetParameterListRequest

// 系统参数


//extern NSString * const TSParamDownAnchorUrl;
//extern NSString * const TSParamCircleTipoffId;
//extern NSString * const TSParamMallHomePageUrl;
//extern NSString * const TSParamSearchPageUrl;
//extern NSString * const TSParamSearchHotwords;
//extern NSString * const TSParamMyShoppingMallUrl;
//extern NSString * const TSParamFundsOrderlistUrl;
//extern NSString * const TSParamFileuploadurlbak;
//extern NSString * const TSParamIsWebpOn;
//extern NSString * const TSParamSkinStyle;
//extern NSString * const TSParamApptokenForCircle;
//extern NSString * const TSParamPaasApiUrl;
//extern NSString * const TSParamPaasImServerUrl;
//extern NSString * const TSParamNewTopicInitParam;
//extern NSString * const TSParamInvitedregister;
//extern NSString * const TSParamCreditLevelUrl;
//extern NSString * const TSParamAliSvChannelId;
//extern NSString * const TSParamIsShowPayButton;
//extern NSString * const TSParamH5Template;
//extern NSString * const TSParamCommentIntervalTime;
//extern NSString * const TSParamAppStyleConf;
//extern NSString * const TSParamArticleUseH5Page;

- (id)requestParameter
{
    NSArray *keysArray = @[TSParamPassToken,
                           TSParamPassCallBack,
                           TSParamContributeChannelId,
                           TSParamContributeChannelName,
                           TSParamThirdPartyUrl,
                           TSParamMyNoticePageUrl,
                           TSParamUserCenterAppKey,
                           TSParamSDKMediaProcessAddress,
                           TSParamPayWebapiUrl,
                           TSParamUserActionUrl,
                           TSParamMyRedPacketH5Url,
                           TSParamShoutKeyUrl,
                           TSParamShoutKeySignUrl,
                           TSParamShoutKeySignPublicKey,
                           TSParamShoutKeySignAppid,
                           TSParamPcLoginUrl,
                           TSParamAlbumDetailUrl,
                           TSParamRedPacketSwitch,
                           TSParamColumnExpandSwitch,
                           TSParamRedPacketPicUrl,
                           TSParamRegisterChannelFlag,
                           TSParamRegisterAuditinfo,
                           TSParamRegisterAppspace,
                           TSParamDownAnchorUrl,
                           TSParamCircleTipoffId,
                           TSParamMallHomePageUrl,
                           TSParamSearchPageUrl,
                           TSParamSearchHotwords,
                           TSParamMyShoppingMallUrl,
                           TSParamFundsOrderlistUrl,
                           TSParamFileuploadurlbak,
                           TSParamIsWebpOn,
                           TSParamSkinStyle,
                           TSParamApptokenForCircle,
                           TSParamPaasApiUrl,
                           TSParamPaasImServerUrl,
                           TSParamNewTopicInitParam,
                           TSParamInvitedregister,
                           TSParamCreditLevelUrl,
                           TSParamAliSvChannelId,
                           TSParamIsShowPayButton,
                           TSParamH5Template,
                           TSParamCommentIntervalTime,
                           TSParamAppStyleConf,
                           TSParamArticleUseH5Page
    ];
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
