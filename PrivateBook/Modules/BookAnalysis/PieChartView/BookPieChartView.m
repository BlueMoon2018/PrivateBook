//
//  BookPieChartView.m
//  PrivateBook
//
//  Created by chenbin on 17/1/22.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookPieChartView.h"

#import "BookPieChartItem.h"

@interface BookPieChartView()

@property (nonatomic, assign) NSInteger totalValue;

@end

@implementation BookPieChartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置默认的属性
        // 半径
        _radius = 180;
        
        // 内圆半径
        _innerRadius = 120;
        
        // 最外圆的模糊的外圆半径
        _outterRadius = 190;
        
        // 每项间距
        _sliceSpace = 0;
        
        [self initSubViews];
        
        _numberLabel.text = @"0";
        _descriptionLabel.text = @"作者总数";
    }
    
    return self;
}

#pragma mark - subviews

- (void)initSubViews
{
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.font = [UIFont systemFontOfSize:42.0f];
    self.numberLabel.textColor = UIColorFromRGB(0x009D82);
    self.numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.numberLabel];
    
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.font = [UIFont systemFontOfSize:15.0f];
    self.descriptionLabel.textColor = UIColorFromRGB(0x999999);
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.descriptionLabel];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_numberLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_numberLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:-16]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:16]];
    
}

#pragma mark - draw

- (void)drawRect:(CGRect)rect {
    [self drawData:self.itemList];
}

- (void)drawData:(NSArray<BookPieChartItem *> *)itemList {
    
    if ([itemList count] == 0) {
        return;
    }
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 半径与圆点
    CGFloat radius = self.radius;
    CGFloat innerRadius = self.innerRadius;
    CGFloat sliceSpace = self.sliceSpace;
    CGFloat centerX = CGRectGetMidX(self.bounds);
    CGFloat centerY = CGRectGetMidY(self.bounds);
    CGFloat deg2Rad = (M_PI / 180.0);
    
    // 起始弧度
    CGFloat rotationAngle = 180;
    CGFloat angle = 0.0;
    NSInteger index = 0;
    for (BookPieChartItem * item in itemList) {
        CGFloat value = item.value;
        CGFloat sliceAngle = value * 360.0 / _totalValue;
        if (fabs(value) > 0.000001) {
            // 起始角度与结束角度.
            CGFloat startAngle = rotationAngle + (angle + sliceSpace / 2.0);
            CGFloat sweepAngle = (sliceAngle - sliceSpace / 2.0);
            if (sweepAngle < 0.0) {
                sweepAngle = 0.0;
            }
            CGFloat endAngle = startAngle + sweepAngle;
            
            // 外圆
            CGFloat outRadius = radius;
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, nil, centerX, centerY);
            CGPathAddArc(path, nil, centerX, centerY, outRadius, startAngle * deg2Rad, endAngle * deg2Rad, false);
            CGPathCloseSubpath(path);
            
            // 内圆
            if (innerRadius > 0.0) {
                CGPathMoveToPoint(path, nil, centerX, centerY);
                CGPathAddArc(path, nil, centerX, centerY, innerRadius, startAngle * deg2Rad, endAngle * deg2Rad, false);
                CGPathCloseSubpath(path);
            }
            
            // 绘制
            CGContextBeginPath(context);
            CGContextAddPath(context, path);
            CGContextSetFillColorWithColor(context, item.color.CGColor);
            CGContextEOFillPath(context);
        
        }
        
        index ++;
        angle += sliceAngle;
    }
    
    //内圆
    if (_innerRadius > 0) {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, centerX, centerY);
        CGPathAddArc(path, nil, centerX, centerY, _innerRadius, 0 * deg2Rad, 360 * deg2Rad, false);
        CGPathCloseSubpath(path);
        
        // 绘制
        CGContextBeginPath(context);
        CGContextAddPath(context, path);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillPath(context);
    }
    
    //最外圆的外圆模糊环
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, centerX, centerY);
    CGPathAddArc(path, nil, centerX, centerY, _outterRadius, 0 * deg2Rad, 360 * deg2Rad, false);
    CGPathCloseSubpath(path);

    if (_radius > 0.0) {
        CGPathMoveToPoint(path, nil, centerX, centerY);
        CGPathAddArc(path, nil, centerX, centerY, _radius, 0 * deg2Rad, 360 * deg2Rad, false);
        CGPathCloseSubpath(path);
    }
    
    // 绘制
    CGContextBeginPath(context);
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:1.0f alpha:0.1].CGColor);
    CGContextEOFillPath(context);
}

- (void)setItemList:(NSArray<BookPieChartItem *> *)itemList
{
    _itemList = itemList;
    
    _totalValue = 0;
    
    for (BookPieChartItem *item in _itemList) {
        _totalValue += item.value;
    }
    
    _numberLabel.text = [NSString stringWithFormat:@"%ld", _totalValue];
    
    [self setNeedsDisplay];
}

@end
