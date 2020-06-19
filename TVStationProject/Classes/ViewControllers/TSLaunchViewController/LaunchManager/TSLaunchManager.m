//
//  TSLaunchManager.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/10.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSLaunchManager.h"
#import "TSStringUtil.h"

@interface TSLaunchManager ()

// 获取系统参数接口
@property (nonatomic, strong, readwrite) TSGetParameterListRequest *paramsRequest;
// 获取开机广告接口
@property (nonatomic, strong, readwrite) TSGetStartAdsListRequest *adsRequest;

@end

@implementation TSLaunchManager

#pragma mark - publishMethods
// 获取系统参数
- (void)loadParameterListRequestSuccessBlock:(void(^)(TSGetParameterListModel *paramListModel))success
                                failureBlock:(void(^)(TSBaseRequest *request))failure
{
    WEAKSELF
    [self.paramsRequest setRequestSuccessBlock:^(TSBaseRequest * _Nonnull request) {
        STRONGSELF
        TSGetParameterListModel *paramListModel =  [strongSelf.paramsRequest responseModel];
        NSLog(@"请求成功 %@",paramListModel);
        if (paramListModel.state == TSResponseStatusSuccess) {
            [strongSelf saveSystemParamtersWithGetParameterListModel:paramListModel];
            if (success) {
                success(paramListModel);
            }
        } else {
            if (failure) {
                failure(request);
            }
        }
    } failureBlock:^(TSBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request);
        }
    }];
    [self.paramsRequest start];
}

// 获取开机广告
- (void)loadStartAdListRequestSuccessBlock:(void(^)(TSGetStartAdsListModel *adsListModel))success
                              failureBlock:(void(^)(TSBaseRequest *request))failure
{
    WEAKSELF
    [self.adsRequest setRequestSuccessBlock:^(TSBaseRequest * _Nonnull request) {
        STRONGSELF
        TSGetStartAdsListModel *adsListModel =  [strongSelf.adsRequest responseModel];
        NSLog(@"请求成功 %@",adsListModel);
        if (adsListModel.state == TSResponseStatusSuccess) {
            if (success) {
                success(adsListModel);
            }
        } else {
            if (failure) {
                failure(request);
            }
        }
    } failureBlock:^(TSBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request);
        }
    }];
    [self.adsRequest startWithCache];
}

#pragma mark - privateMethods

// 保存系统参数
- (void)saveSystemParamtersWithGetParameterListModel:(TSGetParameterListModel *)paramListModel
{
    TSPassParamModel *passParamModel =  paramListModel.data.paasParams;
    if (passParamModel) {
        [UserDefaults setObject:passParamModel.fileuploadurl forKey:TSParamFileUploadUrlKey];
        [UserDefaults setObject:passParamModel.fileprocessurl forKey:TSParamFileProcessUrlKey];
    }
    NSArray *paramModels = paramListModel.data.rows;
    if (paramModels && paramModels.count >0) {
        for (TSParamModel *paramModel in paramModels) {
            if ([paramModel.name isEqualToString:TSParamPassToken]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamPassToken];
            } else if ([paramModel.name isEqualToString:TSParamPassCallBack]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamPassCallBack];
            } else if ([paramModel.name isEqualToString:TSParamContributeChannelId]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamContributeChannelId];
            } else if ([paramModel.name isEqualToString:TSParamContributeChannelName]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamContributeChannelName];
            } else if([paramModel.name isEqualToString:TSParamThirdPartyUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamThirdPartyUrl];
            } else if ([paramModel.name isEqualToString:TSParamMyNoticePageUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamMyNoticePageUrl];
            } else if ([paramModel.name isEqualToString:TSParamUserCenterAppKey]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamUserCenterAppKey];
            } else if ([paramModel.name isEqualToString:TSParamPayWebapiUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamPayWebapiUrl];
            } else if ([paramModel.name isEqualToString:TSParamUserActionUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamUserActionUrl];
            } else if ([paramModel.name isEqualToString:TSParamShoutKeyUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamShoutKeyUrl];
            } else if ([paramModel.name isEqualToString:TSParamShoutKeySignUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamShoutKeySignUrl];
            } else if ([paramModel.name isEqualToString:TSParamShoutKeySignPublicKey]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamShoutKeySignPublicKey];
            } else if ([paramModel.name isEqualToString:TSParamShoutKeySignAppid]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamShoutKeySignAppid];
            } else if ([paramModel.name isEqualToString:TSParamPcLoginUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamPcLoginUrl];
            } else if ([paramModel.name isEqualToString:TSParamMyRedPacketH5Url]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamMyRedPacketH5Url];
            } else if ([paramModel.name isEqualToString:TSParamAlbumDetailUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamAlbumDetailUrl];
            } else if ([paramModel.name isEqualToString:TSParamRedPacketSwitch]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamRedPacketSwitch];
            } else if ([paramModel.name isEqualToString:TSParamColumnExpandSwitch]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamColumnExpandSwitch];
            } else if ([paramModel.name isEqualToString:TSParamRedPacketPicUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamRedPacketPicUrl];
            } else if ([paramModel.name isEqualToString:TSParamRegisterChannelFlag]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamRegisterChannelFlag];
            } else if ([paramModel.name isEqualToString:TSParamRegisterAuditinfo]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamRegisterAuditinfo];
            } else if ([paramModel.name isEqualToString:TSParamRegisterAppspace]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamRegisterAppspace];
            } else if ([paramModel.name isEqualToString:TSParamDownAnchorUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamDownAnchorUrl];
            } else if ([paramModel.name isEqualToString:TSParamSDKMediaProcessAddress]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamSDKMediaProcessAddress];
            } else if ([paramModel.name isEqualToString:TSParamCircleTipoffId]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamCircleTipoffId];
            } else if ([paramModel.name isEqualToString:TSParamMallHomePageUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamMallHomePageUrl];
            } else if ([paramModel.name isEqualToString:TSParamSearchPageUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamSearchPageUrl];
            } else if ([paramModel.name isEqualToString:TSParamSearchHotwords]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamSearchHotwords];
            } else if ([paramModel.name isEqualToString:TSParamMyShoppingMallUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamMyShoppingMallUrl];
            } else if ([paramModel.name isEqualToString:TSParamFundsOrderlistUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamFundsOrderlistUrl];
            } else if ([paramModel.name isEqualToString:TSParamFileuploadurlbak]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamFileuploadurlbak];
            } else if ([paramModel.name isEqualToString:TSParamIsWebpOn]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamIsWebpOn];
            } else if ([paramModel.name isEqualToString:TSParamSkinStyle]) {
                int themeType = [paramModel.value intValue];
                
                //                        [YFTopicColorManager sharedYFTopicColorManager].themeType = themeType;
            } else if ([paramModel.name isEqualToString:TSParamAppStyleConf]) {
                NSLog(@"appStyleConf=%@",paramModel.value);
                NSString *oldAppStyleConf = [UserDefaults objectForKey:TSParamAppStyleConf];
                [UserDefaults setObject:paramModel.value forKey:TSParamAppStyleConf];
                if (![oldAppStyleConf isEqualToString:paramModel.value]) {
                    //                            [[YFTopicColorManager sharedYFTopicColorManager] postTopicChangeMessage];
                }
            } else if ([paramModel.name isEqualToString:TSParamApptokenForCircle]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamApptokenForCircle];
            } else if ([paramModel.name isEqualToString:TSParamPaasApiUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamPaasApiUrl];
            } else if ([paramModel.name isEqualToString:TSParamPaasImServerUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamPaasImServerUrl];
            } else if ([paramModel.name isEqualToString:TSParamNewTopicInitParam]) {
                NSDictionary *dict = [TSStringUtil dictionaryWithJsonString:paramModel.value];
                [UserDefaults setObject:[dict valueForKey:@"key"] forKey:TSParamNewTopicClientAppKeyKey];
                [UserDefaults setObject:[dict valueForKey:@"secret"] forKey:TSParamNewTopicClientAppSecretKey];
                [UserDefaults setObject:[dict valueForKey:@"imAppId"] forKey:TSParamNewTopicClientAppIdKey];
            } else if ([paramModel.name isEqualToString:TSParamInvitedregister]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamInvitedregister];
            } else if ([paramModel.name isEqualToString:TSParamCreditLevelUrl]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamCreditLevelUrl];
            } else if ([paramModel.name isEqualToString:TSParamAliSvChannelId]) {
                NSDictionary *dict = [TSStringUtil dictionaryWithJsonString:paramModel.value];
                [UserDefaults setObject:[dict valueForKey:@"channelId"] forKey:TSParamAliContributeChannelIdKey];
                [UserDefaults setObject:[dict valueForKey:@"channelName"] forKey:TSParamAliContributeChannelNameKey];
            } else if ([paramModel.name isEqualToString:TSParamIsShowPayButton]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamIsShowPayButton];
            } else if ([paramModel.name isEqualToString:TSParamH5Template]) {
                NSDictionary *dict = [TSStringUtil dictionaryWithJsonString:paramModel.value];
                NSString *version = dict[@"version"];
                NSString *downloadUrl = dict[@"downloadUrl"];
                [UserDefaults setObject:downloadUrl forKey:TSParamHtmlTemplateDownloadUrlKey];
//                [[HtmlTemplateAction shareAction] checkIfDownloadH5TemplateWithVersion:version];
            } else if ([paramModel.name isEqualToString:TSParamCommentIntervalTime]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamCommentIntervalTime];
            } else if ([paramModel.name isEqualToString:TSParamArticleUseH5Page]) {
                [UserDefaults setObject:paramModel.value forKey:TSParamArticleUseH5Page];
            }
        }
    }
}

#pragma mark - lazyload
- (TSGetParameterListRequest *)paramsRequest
{
    if (!_paramsRequest) {
        _paramsRequest = [[TSGetParameterListRequest alloc] init];
    }
    return _paramsRequest;
}

- (TSGetStartAdsListRequest *)adsRequest
{
    if (!_adsRequest) {
        _adsRequest = [[TSGetStartAdsListRequest alloc] init];
    }
    return _adsRequest;
}
@end
