//
//  BookScannerView.h
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookScannerView : UIView

- (instancetype)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offsetY;

- (void)startAnimation;
- (void)stopAnimation;

@end
