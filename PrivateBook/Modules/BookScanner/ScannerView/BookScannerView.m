//
//  BookScannerView.m
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookScannerView.h"

@interface BookScannerView ()

/**
 *  扫描区域
 */
@property (nonatomic, assign) CGSize rectSize;
/**
 *  扫描区域相对view的中心点的偏移量，向上为负值，向下为正值
 */
@property (nonatomic, assign) CGFloat offsetY;
/**
 *  扫描线
 */
@property (nonatomic, strong) UIImageView *animationLine;
/**
 *  扫描线是否在上下摆动
 */
@property (nonatomic, assign, getter=isAnimating) BOOL animating;

@property (nonatomic, assign) BOOL animationReverse;

@end

@implementation BookScannerView

- (instancetype)initWithFrame:(CGRect)frame rectSize:(CGSize)size offsetY:(CGFloat)offsetY
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rectSize = size;
        self.offsetY = offsetY;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //计算基准坐标
    CGFloat minX = (self.frame.size.width - self.rectSize.width) / 2;
    CGFloat maxX = minX + self.rectSize.width;
    CGFloat minY = (self.frame.size.height - self.rectSize.height) / 2 + self.offsetY;
    CGFloat maxY = minY + self.rectSize.height;
    
    //绘制半透明黑色区域
    
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.4f);
    
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, minY));
    CGContextFillRect(context, CGRectMake(0, minY, minX, self.rectSize.height));
    CGContextFillRect(context, CGRectMake(0, maxY, self.frame.size.width, self.frame.size.height - maxY));
    CGContextFillRect(context, CGRectMake(maxX, minY, self.frame.size.width - maxX, self.rectSize.height));
    
    //绘制中间区域的白色边框
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 0.6f);
    
    CGContextAddRect(context, CGRectMake(minX, minY, self.rectSize.width, self.rectSize.height));
    
    CGContextStrokePath(context);
    
    //绘制中间的四个角落
    
    CGFloat cornerLineLength = 9.0f;
    CGFloat cornerLineThick = 1.0f;
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 1.0f);
    
    //左上角
    CGContextMoveToPoint(context, minX + cornerLineLength - cornerLineThick , minY - cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick, minY - cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick, minY  + cornerLineLength - cornerLineThick);
    
    //左下角
    CGContextMoveToPoint(context, minX + cornerLineLength - cornerLineThick , maxY + cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick, maxY + cornerLineThick);
    CGContextAddLineToPoint(context, minX - cornerLineThick, maxY - cornerLineLength + cornerLineThick);
    
    //右上角
    CGContextMoveToPoint(context, maxX - cornerLineLength + cornerLineThick , minY - cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick, minY - cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick, minY + cornerLineLength - cornerLineThick);
    
    //右下角
    CGContextMoveToPoint(context, maxX - cornerLineLength + cornerLineThick , maxY + cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick, maxY + cornerLineThick);
    CGContextAddLineToPoint(context, maxX + cornerLineThick, maxY - cornerLineLength + cornerLineThick);
    
    CGContextStrokePath(context);
    
}

- (UIImageView *)animationLine
{
    if (_animationLine == nil) {
        //计算基准坐标
        CGFloat minX = (self.frame.size.width - self.rectSize.width) / 2;
        CGFloat minY = (self.frame.size.height - self.rectSize.height) / 2 + self.offsetY;
        
        _animationLine = [[UIImageView alloc] initWithFrame:CGRectMake(minX, minY, self.rectSize.width, 1.0f)];
        _animationLine.image = [UIImage imageNamed:@"scanner-line"];
        
        [self addSubview:_animationLine];
    }
    
    return _animationLine;
}

- (void)startAnimation
{
    if (self.isAnimating) {
        return;
    }
    
    self.animating = YES;
    
    //计算基准坐标
    CGFloat minX = (self.frame.size.width - self.rectSize.width) / 2;
    CGFloat minY = (self.frame.size.height - self.rectSize.height) / 2 + self.offsetY;
    CGFloat maxY = minY + self.rectSize.height;
    
    [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.animationReverse) {
            self.animationLine.frame = CGRectMake(minX, maxY, self.rectSize.width, 1.0f);
        } else {
            self.animationLine.frame = CGRectMake(minX, minY, self.rectSize.width, 1.0f);
        }
    } completion:^(BOOL finished) {
        if (finished) {
            self.animationReverse = !self.animationReverse;
            self.animating = NO;
            [self startAnimation];
        } else {
            [self stopAnimation];
        }
    }];
}

- (void)stopAnimation
{
    [self.animationLine removeFromSuperview];
    self.animationLine = nil;
    self.animationReverse = NO;
    self.animating = NO;
}

@end
