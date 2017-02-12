//
//  BookTag.h
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseModel.h"

#import <FMDB.h>

@interface BookTag : BookBaseModel

/**
 *  图书本地id
 */
@property (nonatomic, assign) long long bookId;

/**
 *  标签名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  标签次数
 */
@property (nonatomic, assign) long count;

- (BookTag *)initWithFMResultSet:(FMResultSet *)resultSet;

@end
