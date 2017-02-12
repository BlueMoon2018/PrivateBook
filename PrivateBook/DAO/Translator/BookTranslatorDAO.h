//
//  BookTranslatorDAO.h
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseDAO.h"

#import "BookTranslator.h"

@interface BookTranslatorDAO : BookBaseDAO

+ (long long)insertModel:(BookTranslator *)bookTranslator withDataBase:(FMDatabase *)db;

+ (BOOL)removeModelWithBookId:(long long)bookId andDataBase:(FMDatabase *)db;

+ (NSArray<BookTranslator *> *)queryModelsWithBookId:(long long)bookId withDataBase:(FMDatabase *)db;

@end
