//
//  BookListCollectionViewCell+BookEntity.m
//  PrivateBook
//
//  Created by chenbin on 17/1/18.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookListCollectionViewCell+BookEntity.h"

#import "BookEntity.h"

#import <UIImageView+WebCache.h>

@implementation BookListCollectionViewCell (BookEntity)

- (void)configureWithBookEntity:(BookEntity *)bookEntity
{
    self.titleLabel.text = bookEntity.title;

    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:bookEntity.image]];
    
}

@end
