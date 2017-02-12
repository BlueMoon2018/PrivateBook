//
//  BookTag.m
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookTag.h"

@implementation BookTag

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    BookTag *bookTag = [[[self class] alloc] init];
    
    bookTag.bookId = [[dict objectForKey:@"bookId"] longLongValue];
    bookTag.name = [dict objectForKey:@"name"];
    bookTag.count = [[dict objectForKey:@"count"] longValue];
    
    return bookTag;
}

- (BookTag *)initWithFMResultSet:(FMResultSet *)resultSet
{
    BookTag *bookTag = [[[self class] alloc] init];
    
    bookTag.bookId = [resultSet longLongIntForColumn:@"bookId"];
    bookTag.name = [resultSet stringForColumn:@"name"];
    bookTag.count = [resultSet longForColumn:@"count"];
    
    return bookTag;
}

- (id)copyWithZone:(NSZone *)zone
{
    BookTag *bookTag = [[[self class] allocWithZone:zone] init];
    
    bookTag.bookId = self.bookId;
    bookTag.name = [self.name copy];
    bookTag.count = self.count;
    
    return bookTag;
}

@end
