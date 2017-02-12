//
//  BookAnalysisTableViewCell.m
//  PrivateBook
//
//  Created by chenbin on 17/1/22.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookAnalysisTableViewCell.h"

@implementation BookAnalysisTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.contentView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.layer.cornerRadius = 5.0f;
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.indicatorView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:16.0f];
    self.nameLabel.textColor = UIColorFromRGB(0x9434343);
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.nameLabel];
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.font = [UIFont systemFontOfSize:13.0f];
    self.countLabel.textColor = UIColorFromRGB(0xB0B0B0);
    self.countLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.countLabel];
    
    self.percentLabel = [[UILabel alloc] init];
    self.percentLabel.font = [UIFont systemFontOfSize:16.0f];
    self.percentLabel.textColor = UIColorFromRGB(0x434343);
    self.percentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.percentLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_indicatorView, _nameLabel, _countLabel, _percentLabel);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_indicatorView(==10)]-5-[_nameLabel]-10-[_countLabel]-(>=15)-[_percentLabel]-15-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_indicatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

- (void)prepareForReuse
{
    self.nameLabel.text = nil;
    self.countLabel.text = nil;
    self.percentLabel.text = nil;
    
}

@end
