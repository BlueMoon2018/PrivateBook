//
//  BookListService.m
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookListService.h"

#import "BookDBHelper.h"

#import <FMDB.h>

#import "BookEntityDAO.h"
#import "BookAuthorDAO.h"
#import "BookTranslatorDAO.h"
#import "BookTagDAO.h"

@implementation BookListService

+ (NSArray<BookEntity *> *)getAllBookEntities
{
    FMDatabase *db = [FMDatabase databaseWithPath:[BookDBHelper dbPath]];
    if (![db open]) {
        return nil;
    }
    
    NSArray *bookEntities = [BookEntityDAO queryAllModelsWithDataBase:db];
    
    for (BookEntity *entity in bookEntities) {
        entity.authors = [BookAuthorDAO queryModelsWithBookId:entity.id withDataBase:db];
        entity.translators = [BookTranslatorDAO queryModelsWithBookId:entity.id withDataBase:db];
        entity.tags = [BookTagDAO queryModelsWithBookId:entity.id withDataBase:db];
    }
    
    [db close];
    
    return bookEntities;
}

@end
