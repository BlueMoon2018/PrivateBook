//
//  BookAuthorDAO.h
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseDAO.h"

#import "BookAuthor.h"

@interface BookAuthorDAO : BookBaseDAO

+ (long long)insertModel:(BookAuthor *)bookAuthor withDataBase:(FMDatabase *)db;

+ (BOOL)removeModelWithBookId:(long long)bookId andDataBase:(FMDatabase *)db;

+ (NSArray<BookAuthor *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

+ (NSArray *)queryAllAuthorWith:(FMDatabase *)db;

+ (NSInteger)queryNumberOfBooksWithAuthor:(BookAuthor *)author andDataBase:(FMDatabase *)db;

@end
