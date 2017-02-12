//
//  BookDetailService.h
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BookEntity.h"

@interface BookDetailService : NSObject

/**
 *  收藏图书
 *
 *  @param bookEntity 图书实体
 *
 *  @return 图书本地id
 */
+ (long long)favBook:(BookEntity *)bookEntity;

/**
 *  取消收藏图书
 *
 *  @param id 图书本地id
 *
 *  @return 成功与否
 */
+ (BOOL)unFavBookWithId:(long long)id;

/**
 *  使用豆瓣ID搜索数据库中是否有已经收藏的书籍
 */
+ (BookEntity *)searchFavedBookWithDoubanId:(long long)doubanId;

@end
