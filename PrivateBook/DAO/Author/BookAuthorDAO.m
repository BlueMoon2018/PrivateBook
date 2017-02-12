//
//  BookAuthorDAO.m
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookAuthorDAO.h"

@implementation BookAuthorDAO

+ (long long)insertModel:(BookAuthor *)bookAuthor withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_AUTHOR (bookId, name) VALUES (?, ?)", @(bookAuthor.bookId), bookAuthor.name];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}

+ (BOOL)removeModelWithBookId:(long long)bookId andDataBase:(FMDatabase *)db
{
    BOOL sucess = [db executeUpdate:@"DELETE FROM TB_BOOK_AUTHOR WHERE bookId = ?", @(bookId)];
    
    return sucess;
}

+ (NSArray<BookAuthor *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db
{
    NSMutableArray *results = [@[] mutableCopy];
    
    FMResultSet *result = [db executeQuery:@"SELECT * FROM TB_BOOK_AUTHOR WHERE bookId = ?", @(bookId)];
    while ([result next]) {
        BookAuthor *author = [[BookAuthor alloc] initWithFMResultSet:result];
        [results addObject:author];
    }
    
    return results;
}

+ (NSInteger)queryNumberOfBooksWithAuthor:(BookAuthor *)author andDataBase:(FMDatabase *)db
{
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(*) FROM TB_BOOK_AUTHOR WHERE name = ?", author.name];
    
    if (result.next) {
        return [result intForColumnIndex:0];
    }
    
    return 0;
}


+ (NSArray *)queryAllAuthorWith:(FMDatabase *)db
{
    NSMutableArray *results = [@[] mutableCopy];
    
    FMResultSet *result = [db executeQuery:@"SELECT DISTINCT * FROM TB_BOOK_AUTHOR"];
    while ([result next]) {
        BookAuthor *author = [[BookAuthor alloc] initWithFMResultSet:result];
        [results addObject:author];;
    }
    
    return results;
}

@end
