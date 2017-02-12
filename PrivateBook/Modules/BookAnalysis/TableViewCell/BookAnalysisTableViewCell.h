//
//  BookAnalysisTableViewCell.h
//  PrivateBook
//
//  Created by chenbin on 17/1/22.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseTableViewCell.h"

@interface BookAnalysisTableViewCell : BookBaseTableViewCell

@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) UILabel *percentLabel;

@end
