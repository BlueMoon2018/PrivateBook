//
//  BookAuthor.h
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseModel.h"

#import <FMDB.h>

@interface BookAuthor : BookBaseModel

/**
 *  图书本地id
 */
@property (nonatomic, assign) long long bookId;

/**
 *  作者名称
 */
@property (nonatomic, copy) NSString *name;

- (BookAuthor *)initWithFMResultSet:(FMResultSet *)resultSet;

@end
