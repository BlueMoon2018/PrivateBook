//
//  BookAnalysisViewController.m
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookAnalysisViewController.h"

#import "BookAnalysisService.h"

#import "BookAnalysisTableViewCell.h"
#import "BookAnalysisTableViewCell+PieChartItem.h"

#import "BookPieChartItem.h"
#import "BookPieChartView.h"

//背景高度
#define kBackgroundHeight 300.5f

@interface BookAnalysisViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIView *tableHeaderView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) BookPieChartView *pieChart;

@property (nonatomic, strong) NSArray<BookPieChartItem *> *allItems;

@property (nonatomic, assign) NSInteger totalValue;

@end

@implementation BookAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initNavigation];
    [self initSubViews];
    [self getData];
    

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop;
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

#pragma mark - Data

- (void)getData
{
    self.allItems = [BookAnalysisService getAllBookPieChartItems];
    self.pieChart.itemList = self.allItems;
    
    self.totalValue = 0;
    for (BookPieChartItem *item in self.allItems) {
        self.totalValue += item.value;
    }
    
    
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void)initNavigation
{
    self.navigationItem.title = @"最爱作者";
}

- (UIImage *)navigationBarBackgroundImage
{
    return [UIImage new];
}

- (BOOL)shouldShowShadowImage
{
    return NO;
}

#pragma mark - StatusBar

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - SubViews

- (void)initSubViews
{
    [self initBackgroundView];
    [self initTableView];
    [self initPieChart];
}

- (void)initBackgroundView
{
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight);
    self.backgroundView.backgroundColor = UIColorFromRGB(0x009D82);
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.backgroundView];
}
- (void)initTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64.0f) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), kBackgroundHeight - 64.0f)];
    headerView.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = headerView;
    self.tableHeaderView = headerView;
    
    tableView.tableFooterView = [UIView new];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (void)initPieChart {
    CGRect rect = self.tableHeaderView.frame;
    
    self.pieChart = [[BookPieChartView alloc] initWithFrame:rect];
    self.pieChart.radius = 90;
    self.pieChart.innerRadius = 60;
    self.pieChart.outterRadius = 96;
    self.pieChart.backgroundColor = [UIColor clearColor];
    [self.tableHeaderView addSubview:self.pieChart];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"BookAnalysisViewControllerCell";
    
    BookAnalysisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[BookAnalysisTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    BookPieChartItem *item = self.allItems[indexPath.row];
    [cell configureWithBookPieChartItem:item with:_totalValue];
    
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //滑动修改头部
    if (scrollView.contentOffset.y != 0) {
        self.backgroundView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight - scrollView.contentOffset.y);
    } else {
        self.backgroundView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight);
    }
}

@end
