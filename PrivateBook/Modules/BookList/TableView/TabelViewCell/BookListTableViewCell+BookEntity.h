//
//  BookListTableViewCell+BookEntity.h
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookListTableViewCell.h"

@class BookEntity;

@interface BookListTableViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity;

@end
