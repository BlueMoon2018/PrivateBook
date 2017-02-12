//
//  BookListCollectionViewCell.m
//  PrivateBook
//
//  Created by chenbin on 17/1/18.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookListCollectionViewCell.h"

@implementation BookListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.contentView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.backgroundColor = [UIColor whiteColor];
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.coverImageView];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    self.titleLabel.textColor = UIColorFromRGB(0x555555);
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.deleteButton.hidden = YES;
    [self.deleteButton sizeToFit];
    [self.contentView addSubview:self.deleteButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_coverImageView, _titleLabel);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_coverImageView(==100)]-0-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_coverImageView(==140)]-0-[_titleLabel]-0-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=5)-[_titleLabel]-(>=5)-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:views]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_deleteButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0f constant:8.0f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_deleteButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:-8.0f]];
}

- (void)prepareForReuse
{
    self.coverImageView.image = nil;
    self.titleLabel.text = nil;
    self.deleteButton.hidden = YES;
}

@end
