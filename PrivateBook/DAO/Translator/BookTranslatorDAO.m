//
//  BookTranslatorDAO.m
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookTranslatorDAO.h"

@implementation BookTranslatorDAO

+ (long long)insertModel:(BookTranslator *)bookTranslator withDataBase:(FMDatabase *)db
{
    BOOL success = [db executeUpdate:@"INSERT INTO TB_BOOK_TRANSLATOR (bookId, name) VALUES (?, ?)", @(bookTranslator.bookId), bookTranslator.name];
    
    if (success) {
        return [db lastInsertRowId];
    } else {
        return 0;
    }
}

+ (BOOL)removeModelWithBookId:(long long)bookId andDataBase:(FMDatabase *)db
{
    BOOL sucess = [db executeUpdate:@"DELETE FROM TB_BOOK_TRANSLATOR WHERE bookId = ?", @(bookId)];
    
    return sucess;
}

+ (NSArray<BookTranslator *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db
{
    NSMutableArray *results = [@[] mutableCopy];
    
    FMResultSet *result = [db executeQuery:@"SELECT * FROM TB_BOOK_TRANSLATOR WHERE bookId = ?", @(bookId)];
    while ([result next]) {
        BookTranslator *translator = [[BookTranslator alloc] initWithFMResultSet:result];
        [results addObject:translator];
    }
    
    return results;
}

@end
