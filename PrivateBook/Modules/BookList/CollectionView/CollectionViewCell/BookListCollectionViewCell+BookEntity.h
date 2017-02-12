//
//  BookListCollectionViewCell+BookEntity.h
//  PrivateBook
//
//  Created by chenbin on 17/1/18.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookListCollectionViewCell.h"

@class BookEntity;

@interface BookListCollectionViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity;

@end
