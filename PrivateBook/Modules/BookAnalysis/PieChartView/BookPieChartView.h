//
//  BookPieChartView.h
//  PrivateBook
//
//  Created by chenbin on 17/1/22.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookPieChartItem;

@interface BookPieChartView : UIView

/**
 *  要展示的数据.
 */
@property (nonatomic, strong) NSArray<BookPieChartItem *> *itemList;

/**
 *  界面的配置
 */
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat innerRadius;
@property (nonatomic, assign) CGFloat outterRadius;
@property (nonatomic, assign) CGFloat sliceSpace;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@end
