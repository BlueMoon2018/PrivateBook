//
//  BookListTableViewController.m
//  PrivateBook
//
//  Created by chenbin on 17/1/17.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookListTableViewController.h"

#import "BookListTableViewCell.h"
#import "BookListTableViewCell+BookEntity.h"

#import "BookDetailViewController.h"

#import "BookListService.h"
#import "BookDetailService.h"

@interface BookListTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<BookEntity *> *bookEntities;

@end

@implementation BookListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getData];
}

#pragma mark - data

- (void)getData
{
    self.bookEntities = [[BookListService getAllBookEntities] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - SubViews

- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    
    [self.view addSubview:tableView];

}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bookEntities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"BookListTableViewCell";
    
    BookListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BookListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
    [cell configureWithBookEntity:entity];
    
    return cell;
}

#pragma mark - TableView Delegate

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消收藏";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
        
        if ([BookDetailService unFavBookWithId:entity.id]) {
            
            [self.bookEntities removeObject:entity];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookEntity *entity = [self.bookEntities objectAtIndex:indexPath.row];
    
    BookDetailViewController *detailController = [[BookDetailViewController alloc] init];
    [detailController setBookEntity:entity];
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
