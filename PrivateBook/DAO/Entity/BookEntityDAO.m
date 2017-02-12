//
//  BookEntityDAO.m
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookEntityDAO.h"

@implementation BookEntityDAO

+ (long long)insertModel:(BookEntity *)bookEntity withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_ENTITY (doubanId, isbn10, isbn13, title, doubanUrl, image, publisher, pubdate, price, summary, author_intro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", @(bookEntity.doubanId), bookEntity.isbn10, bookEntity.isbn13, bookEntity.title, bookEntity.doubanUrl, bookEntity.image, bookEntity.publisher, bookEntity.pubdate, bookEntity.price, bookEntity.summary, bookEntity.author_intro];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}

+ (BOOL)removeModelWithBookId:(long long)bookId andDataBase:(FMDatabase *)db
{
    BOOL sucess = [db executeUpdate:@"DELETE FROM TB_BOOK_ENTITY WHERE id = ?", @(bookId)];
    
    return sucess;
}

+ (BookEntity *)queryModelByDoubanId:(long long)doubanId withDatabase:(FMDatabase *)db
{
    FMResultSet *result = [db executeQuery:@"SELECT * FROM TB_BOOK_ENTITY WHERE doubanId = ?", @(doubanId)];
    if ([result next]) {
        BookEntity *entity = [[BookEntity alloc] initWithFMResultSet:result];
        return entity;
    }
    
    return nil;
}

+ (NSArray<BookEntity *> *)queryAllModelsWithDataBase:(FMDatabase *)db
{
    NSMutableArray *results = [@[] mutableCopy];
    
    FMResultSet *result = [db executeQuery:@"SELECT * FROM TB_BOOK_ENTITY"];
    while ([result next]) {
        BookEntity *entity = [[BookEntity alloc] initWithFMResultSet:result];
        [results addObject:entity];
    }
    
    return results;
}

@end
