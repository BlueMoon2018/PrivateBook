//
//  BookListViewController.m
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookListViewController.h"
#import "BookListTableViewController.h"
#import "BookListCollectionViewController.h"

typedef NS_ENUM(NSUInteger, BookListMode) {
    BookListModeTableView,
    BookListModeCollectionView
};

@interface BookListViewController ()

@property (nonatomic, assign) BookListMode mode;

@end

@implementation BookListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    
    self.mode = BookListModeTableView;
    [self switchToMode:self.mode];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)initNavigation
{
    self.navigationItem.title = @"我的藏书";
    
    //切换模式
    UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchButton setImage:[UIImage imageNamed:@"list-switch-collection"] forState:UIControlStateNormal];
    [switchButton setImage:[UIImage imageNamed:@"list-switch-table"] forState:UIControlStateSelected];
    [switchButton sizeToFit];
    
    [switchButton addTarget:self action:@selector(didTapSwitchButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:switchButton];
}

- (void)didTapSwitchButton:(UIButton *)button
{
    [self.childViewControllers makeObjectsPerformSelector:@selector(willMoveToParentViewController:) withObject:nil];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.childViewControllers makeObjectsPerformSelector:@selector(didMoveToParentViewController:) withObject:nil];
    
    if (self.mode == BookListModeTableView) {
        self.mode = BookListModeCollectionView;
        button.selected = YES;
    } else {
        self.mode = BookListModeTableView;
        button.selected = NO;
    }
    
    [self switchToMode:self.mode];
}

- (void)switchToMode:(BookListMode)mode
{
    if (mode == BookListModeTableView) {
        BookListTableViewController *tableController = [[BookListTableViewController alloc] init];
        [tableController willMoveToParentViewController:self];
        [self addChildViewController:tableController];
        [self.view addSubview:tableController.view];
        tableController.view.frame = self.view.bounds;
        [tableController didMoveToParentViewController:self];
    } else {
        BookListCollectionViewController *collectionController = [[BookListCollectionViewController alloc] init];
        [collectionController willMoveToParentViewController:self];
        [self addChildViewController:collectionController];
        [self.view addSubview:collectionController.view];
        collectionController.view.frame = self.view.bounds;
        [collectionController didMoveToParentViewController:self];
    }
}

@end
