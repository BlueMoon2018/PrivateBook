//
//  BookDetailViewController.h
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookBaseViewController.h"

#import "BookEntity.h"

@interface BookDetailViewController : BookBaseViewController

/**
 *  图书信息
 */
@property (nonatomic, strong) BookEntity *bookEntity;

@end
