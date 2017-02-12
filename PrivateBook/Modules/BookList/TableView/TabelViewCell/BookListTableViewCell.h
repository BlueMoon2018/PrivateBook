//
//  BookListTableViewCell.h
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseTableViewCell.h"

@interface BookListTableViewCell : BookBaseTableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *tagsView;

@end
