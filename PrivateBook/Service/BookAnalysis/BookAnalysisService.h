//
//  BookAnalysisService.h
//  PrivateBook
//
//  Created by chenbin on 17/1/22.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BookPieChartItem.h"

@interface BookAnalysisService : NSObject

+ (NSArray<BookPieChartItem *> *)getAllBookPieChartItems;

@end
