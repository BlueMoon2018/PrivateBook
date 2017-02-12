//
//  BookAnalysisService.m
//  PrivateBook
//
//  Created by chenbin on 17/1/22.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookAnalysisService.h"

#import "BookDBHelper.h"

#import <FMDB.h>

#import "BookAuthorDAO.h"


@implementation BookAnalysisService

+ (NSArray<BookPieChartItem *> *)getAllBookPieChartItems
{
    NSMutableArray *results = [NSMutableArray array];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open]) {
        return nil;
    }

    NSArray *allAuthors = [BookAuthorDAO queryAllAuthorWith:db];
    
    NSInteger index = 0;
    
    for (BookAuthor *author in allAuthors) {
        
        BookPieChartItem *item = [[BookPieChartItem alloc] init];
        
        item.name = author.name;
        
        item.value = [BookAuthorDAO queryNumberOfBooksWithAuthor:author andDataBase:db];
        
        item.color = [[self class] getColorWithIndex:(index % 5)];
        index++;
        
        [results addObject:item];
    }
    
    
    [db close];
    
    return results;
}

+ (UIColor *)getColorWithIndex:(NSInteger)index
{
    switch (index) {
            case 0:
            return UIColorFromRGB(0x2C3644);
            break;
            
            case 1:
            return UIColorFromRGB(0xF4A81E);
            break;
            
            case 2:
            return UIColorFromRGB(0xF43E28);
            break;
            
            case 3:
            return UIColorFromRGB(0x1496D2);
            break;
            
            case 4:
            return UIColorFromRGB(0x781E91);
            break;
            
        default:
            break;
    }
    return [UIColor blackColor];
}

@end
