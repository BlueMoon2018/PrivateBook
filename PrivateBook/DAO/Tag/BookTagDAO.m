//
//  BookTagDAO.m
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookTagDAO.h"

@implementation BookTagDAO

+ (long long)insertModel:(BookTag *)bookTag withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_TAG (bookId, name, count) VALUES (?, ?, ?)", @(bookTag.bookId), bookTag.name, @(bookTag.count)];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}

+ (BOOL)removeModelWithBookId:(long long)bookId andDataBase:(FMDatabase *)db
{
    BOOL sucess = [db executeUpdate:@"DELETE FROM TB_BOOK_TAG WHERE bookId = ?", @(bookId)];
    
    return sucess;
}

+ (NSArray<BookTag *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db
{
    NSMutableArray *results = [@[] mutableCopy];
    
    FMResultSet *result = [db executeQuery:@"SELECT * FROM TB_BOOK_TAG WHERE bookId = ?", @(bookId)];
    while ([result next]) {
        BookTag *tag = [[BookTag alloc] initWithFMResultSet:result];
        [results addObject:tag];
    }
    
    return results;
}

@end
