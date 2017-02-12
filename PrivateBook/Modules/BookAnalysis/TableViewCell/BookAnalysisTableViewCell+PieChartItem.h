//
//  BookAnalysisTableViewCell+PieChartItem.h
//  PrivateBook
//
//  Created by chenbin on 17/1/22.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookAnalysisTableViewCell.h"

@class BookPieChartItem;

@interface BookAnalysisTableViewCell (PieChartItem)

- (void)configureWithBookPieChartItem:(BookPieChartItem *)item with:(NSInteger)totalValue;

@end
