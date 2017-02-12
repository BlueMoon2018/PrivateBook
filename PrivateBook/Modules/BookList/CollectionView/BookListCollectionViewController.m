//
//  BookListCollectionViewController.m
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookListCollectionViewController.h"
#import "BookDetailViewController.h"

#import "BookListCollectionViewCell.h"
#import "BookListCollectionViewCell+BookEntity.h"

#import "BookListService.h"
#import "BookDetailService.h"

static NSString *identifier = @"BookListCollectionViewCell";

@interface BookListCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *bookEntities;

@property (nonatomic, strong) NSIndexPath *longPressedIndexPath;

@end

@implementation BookListCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getData];
    
    self.longPressedIndexPath = nil;
}

#pragma mark - data

- (void)getData
{
    self.bookEntities = [[BookListService getAllBookEntities] mutableCopy];
    [self.collectionView reloadData];
}

#pragma mark - SubViews

- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 170);
    layout.minimumInteritemSpacing = 10.0f;
    layout.minimumLineSpacing = 10.0f;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    collectionView.contentInset = UIEdgeInsetsMake(15, 15, 15, 15);
    collectionView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    self.collectionView = collectionView;
    
    [self.view addSubview:collectionView];
    
    [self.collectionView registerClass:[BookListCollectionViewCell class] forCellWithReuseIdentifier:identifier];
}

#pragma mark - CollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bookEntities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
    [cell configureWithBookEntity:entity];
    
    if ([indexPath isEqual:self.longPressedIndexPath]) {
        cell.deleteButton.hidden = NO;
    }
    [cell.deleteButton addTarget:self action:@selector(didTapDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //long Pressed
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedCell:)];
    gesture.minimumPressDuration = 0.5f;
    [cell addGestureRecognizer:gesture];
    
    return cell;
}

#pragma mark - CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
    
    BookDetailViewController *detailController = [[BookDetailViewController alloc] init];
    [detailController setBookEntity:entity];
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


#pragma mark -actions

- (void)longPressedCell:(UILongPressGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.collectionView];
    NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:point];
    if ([selectedIndexPath isEqual:self.longPressedIndexPath]) {
//        self.longPressedIndexPath = nil;
    } else {
        self.longPressedIndexPath = selectedIndexPath;
    }
    [self.collectionView reloadData];
}

- (void)didTapDeleteButton:(UIButton *)button
{
    BookEntity *entity = [self.bookEntities objectAtIndex:self.longPressedIndexPath.row];
    
    if ([BookDetailService unFavBookWithId:entity.id]) {
        
        [self.bookEntities removeObject:entity];
        [self.collectionView deleteItemsAtIndexPaths:@[self.longPressedIndexPath]];
        self.longPressedIndexPath = nil;
    }
}

@end
