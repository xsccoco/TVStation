//
//  TSLaunchViewController.m
//  TVStationProject
//
//  Created by 徐世船 on 2020/6/5.
//  Copyright © 2020 徐世船. All rights reserved.
//

#import "TSLaunchViewController.h"
#import "TSLaunchManager.h"

@interface TSLaunchViewController ()
@property (nonatomic, strong) TSLaunchManager *launchManager;
@end

@implementation TSLaunchViewController
#pragma mark - lifeCycle
- (void)dealloc
{
    NSLog(@"TSLaunchViewController dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.launchManager getParameterList];
}


#pragma mark - lazyload
- (TSLaunchManager *)launchManager
{
    if (!_launchManager) {
        _launchManager = [[TSLaunchManager alloc] init];
    }
    return _launchManager;
}


@end
