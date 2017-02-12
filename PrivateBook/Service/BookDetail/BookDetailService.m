//
//  BookDetailService.m
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookDetailService.h"

#import "BookDBHelper.h"

#import <FMDB.h>

#import "BookEntityDAO.h"
#import "BookAuthorDAO.h"
#import "BookTranslatorDAO.h"
#import "BookTagDAO.h"


@implementation BookDetailService

+ (long long)favBook:(BookEntity *)bookEntity
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open]) {
        return 0;
    }
    
    //保存图书
    long long bookId = [BookEntityDAO insertModel:bookEntity withDataBase:db];
    if (!bookId) {
        return bookId;
    }
    
    //保存作者
    [bookEntity.authors enumerateObjectsUsingBlock:^(BookAuthor*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookAuthorDAO insertModel:obj withDataBase:db];
    }];
    
    //保存译者
    [bookEntity.translators enumerateObjectsUsingBlock:^(BookTranslator*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookTranslatorDAO insertModel:obj withDataBase:db];
    }];
    
    //保存Tag
    [bookEntity.tags enumerateObjectsUsingBlock:^(BookTag*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bookId = bookId;
        [BookTagDAO insertModel:obj withDataBase:db];
    }];
    
    [db close];
    
    return bookId;
}

+ (BOOL)unFavBookWithId:(long long)id
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open]) {
        return 0;
    }
    
    BOOL sucess = [BookEntityDAO removeModelWithBookId:id andDataBase:db];
    [BookAuthorDAO removeModelWithBookId:id andDataBase:db];
    [BookTranslatorDAO removeModelWithBookId:id andDataBase:db];
    [BookTagDAO removeModelWithBookId:id andDataBase:db];
    
    [db close];
    
    return sucess;
}

+ (BookEntity *)searchFavedBookWithDoubanId:(long long)doubanId
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open]) {
        return 0;
    }
    
    BookEntity *bookEntity = [BookEntityDAO queryModelByDoubanId:doubanId withDatabase:db];
    
    [db close];
    
    return bookEntity;
}


@end

