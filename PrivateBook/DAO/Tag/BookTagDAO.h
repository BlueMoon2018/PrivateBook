//
//  BookTagDAO.h
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseDAO.h"

#import "BookTag.h"

@interface BookTagDAO : BookBaseDAO

+ (long long)insertModel:(BookTag *)bookTag withDataBase:(FMDatabase *)db;

+ (BOOL)removeModelWithBookId:(long long)bookId andDataBase:(FMDatabase *)db;

+ (NSArray<BookTag *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

@end
