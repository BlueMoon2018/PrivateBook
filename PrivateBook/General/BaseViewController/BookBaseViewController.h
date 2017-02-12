//
//  BookBaseViewController.h
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookBaseViewController : UIViewController

- (BOOL)shouldHideBottomBarWhenPushed;
- (BOOL)shouldShowShadowImage;
- (UIImage *)navigationBarBackgroundImage;

@end
