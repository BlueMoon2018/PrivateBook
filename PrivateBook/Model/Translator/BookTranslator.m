//
//  BookTranslator.m
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookTranslator.h"

@implementation BookTranslator

- (BookTranslator *)initWithFMResultSet:(FMResultSet *)resultSet
{
    BookTranslator *bookTranslator = [[[self class] alloc] init];
    
    bookTranslator.bookId = [resultSet longLongIntForColumn:@"bookId"];
    bookTranslator.name = [resultSet stringForColumn:@"name"];
    
    return bookTranslator;
}

@end
