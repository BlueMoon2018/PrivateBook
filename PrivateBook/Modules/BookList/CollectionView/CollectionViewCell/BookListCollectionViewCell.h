//
//  BookListCollectionViewCell.h
//  PrivateBook
//
//  Created by chenbin on 17/1/18.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseCollectionViewCell.h"

@interface BookListCollectionViewCell : BookBaseCollectionViewCell

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *deleteButton;

@end
