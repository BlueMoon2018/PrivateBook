//
//  BookBaseNavigationController.m
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseNavigationController.h"
#import "BookBaseViewController.h"

@interface BookBaseNavigationController ()

@end

@implementation BookBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x009D82)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[BookBaseViewController class]]) {
        ((BookBaseViewController *)viewController).hidesBottomBarWhenPushed = [(BookBaseViewController *)viewController shouldHideBottomBarWhenPushed];
    } else {
    
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
