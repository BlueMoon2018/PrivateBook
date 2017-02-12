//
//  BookEntityDAO.h
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseDAO.h"

#import "BookEntity.h"

@interface BookEntityDAO : BookBaseDAO

+ (long long)insertModel:(BookEntity *)model withDataBase:(FMDatabase *)db;

+ (BOOL)removeModelWithBookId:(long long)bookId andDataBase:(FMDatabase *)db;

+ (BookEntity *)queryModelByDoubanId:(long long)doubanId withDatabase:(FMDatabase *)db;

+ (NSArray<BookEntity *> *)queryAllModelsWithDataBase:(FMDatabase *)db;

@end
