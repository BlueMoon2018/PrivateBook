//
//  BookAnalysisTableViewCell+PieChartItem.m
//  PrivateBook
//
//  Created by chenbin on 17/1/22.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookAnalysisTableViewCell+PieChartItem.h"

#import "BookPieChartItem.h"

@implementation BookAnalysisTableViewCell (PieChartItem)

- (void)configureWithBookPieChartItem:(BookPieChartItem *)item with:(NSInteger)totalValue
{
    self.indicatorView.backgroundColor = item.color;
    self.nameLabel.text = item.name;
    self.countLabel.text = [NSString stringWithFormat:@"%.0f本", item.value];
    if (totalValue > 0) {
        self.percentLabel.text = [NSString stringWithFormat:@"%.0f%%", item.value/totalValue*100.0];
    } else {
        self.percentLabel.text = nil;
    }
    
}

@end
