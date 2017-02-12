//
//  BookTranslator.h
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookAuthor.h"

#import <FMDB.h>

@interface BookTranslator : BookAuthor

- (BookTranslator *)initWithFMResultSet:(FMResultSet *)resultSet;

@end
