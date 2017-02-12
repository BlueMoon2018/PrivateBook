//
//  BookEntity.h
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseModel.h"

#import <FMDB.h>

@interface BookEntity : BookBaseModel

/**
 *  图书本地id
 */
@property (nonatomic, assign) long long id;

/**
 *  豆瓣图书id
 */
@property (nonatomic, assign) long long doubanId;

/**
 *  ISBN10
 */
@property (nonatomic, copy) NSString *isbn10;

/**
 *  ISBN13
 */
@property (nonatomic, copy) NSString *isbn13;

/**
 *  图书名称
 */
@property (nonatomic, copy) NSString *title;

/**
 *  图书豆瓣URL
 */
@property (nonatomic, copy) NSString *doubanUrl;

/**
 *  图书封面URL
 */
@property (nonatomic, copy) NSString *image;

/**
 *  出版社
 */
@property (nonatomic, copy) NSString *publisher;

/**
 *  出版时间
 */
@property (nonatomic, copy) NSString *pubdate;

/**
 *  价格
 */
@property (nonatomic, copy) NSString *price;

/**
 *  书籍简介
 */
@property (nonatomic, copy) NSString *summary;

/**
 *  作者介绍
 */
@property (nonatomic, copy) NSString *author_intro;

/**
 *  作者
 */
@property (nonatomic, strong) NSArray *authors;

/**
 *  译者
 */
@property (nonatomic, strong) NSArray *translators;

/**
 *  标签
 */
@property (nonatomic, strong) NSArray *tags;


- (BookEntity *)initWithFMResultSet:(FMResultSet *)resultSet;



@end
