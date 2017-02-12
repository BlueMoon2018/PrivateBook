//
//  BookBaseViewController.m
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseViewController.h"

@interface BookBaseViewController ()

@end

@implementation BookBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self adjustNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navigation config

- (void)adjustNavigation
{
    //是否隐藏导航底部的线
    if ([self shouldShowShadowImage]) {
        [self.navigationController.navigationBar setShadowImage:nil];
    } else {
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    }
    
    //是否使用自定义的背景（透明）
    if ([self navigationBarBackgroundImage]) {
        [self.navigationController.navigationBar setBackgroundImage:[self navigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    } else {
        self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x009D82);
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    }
}

- (UIImage *)navigationBarBackgroundImage
{
    return nil;
}

- (BOOL)shouldShowShadowImage
{
    return NO;
}

- (BOOL)shouldHideBottomBarWhenPushed
{
    return NO;
}

@end
