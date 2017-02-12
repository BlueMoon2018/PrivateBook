//
//  BookDetailViewController.m
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookDetailViewController.h"

#import "BookEntity.h"
#import "BookAuthor.h"
#import "BookTranslator.h"
#import "BookTag.h"

#import <UIImageView+WebCache.h>

#import "BookDetailService.h"

//背景高度
#define kBackgroundHeight 270.5f

@interface BookDetailViewController () <UIScrollViewDelegate, UINavigationControllerDelegate>

/**
 *  顶部背景图
 */
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigation];
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)initNavigation
{
    self.navigationItem.title = @"书籍详情";
    
}

- (UIImage *)navigationBarBackgroundImage
{
    return [UIImage new];
}

- (BOOL)shouldShowShadowImage
{
    return NO;
}

- (BOOL)shouldHideBottomBarWhenPushed
{
    return YES;
}

#pragma mark - SubViews

- (void)initSubViews
{
    [self initBackgroundView];
    [self initScrollView];
}

- (void)initBackgroundView
{
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail-topbg"]];
    self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight);
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.backgroundImageView];
}

- (void)initScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64.0f)];
    scrollView.alwaysBounceVertical = YES;
    scrollView.delegate = self;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:scrollView];
    
    //头部
    UIView *headView = [[UIView alloc] init];
    headView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addSubview:headView];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[headView(==206.5)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(headView)]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[headView(==scrollView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headView, scrollView)]];
    
    //封面
    UIImageView *coverImageView = [[UIImageView alloc] init];
    coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    coverImageView.backgroundColor = [UIColor whiteColor];
    [coverImageView sd_setImageWithURL:[NSURL URLWithString:self.bookEntity.image]];
    [headView addSubview:coverImageView];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[coverImageView(115)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView)]];
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[coverImageView(161)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView)]];
    
    //标题
    UILabel *titlelabel = [[UILabel alloc] init];
    titlelabel.translatesAutoresizingMaskIntoConstraints = NO;
    titlelabel.text = self.bookEntity.title;
    titlelabel.font = [UIFont systemFontOfSize:17.0f];
    titlelabel.textColor = [UIColor whiteColor];
    [headView addSubview:titlelabel];
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[coverImageView]-14-[titlelabel]-(>=15)-|" options:NSLayoutFormatAlignAllTop metrics:nil views:NSDictionaryOfVariableBindings(coverImageView, titlelabel)]];
    
    //详细信息
    NSMutableArray *itemsText = [@[] mutableCopy];
    
    if (self.bookEntity.authors) {
        NSString *authorList = @"";
        for (BookAuthor *author in self.bookEntity.authors) {
            authorList = [[authorList stringByAppendingString:author.name] stringByAppendingString:@" "];
        }
        
        [itemsText addObject:[NSString stringWithFormat:@"作者：%@", authorList]];
    }
    
    if (self.bookEntity.translators) {
        NSString *translatorList = @"";
        for (BookTranslator *translator in self.bookEntity.translators) {
            translatorList = [[translatorList stringByAppendingString:translator.name] stringByAppendingString:@" "];
        }
        
        [itemsText addObject:[NSString stringWithFormat:@"译者：%@", translatorList]];
    }
    
    if (self.bookEntity.publisher) {
        [itemsText addObject:[NSString stringWithFormat:@"出版社：%@", self.bookEntity.publisher]];
    }
    
    if (self.bookEntity.pubdate) {
        [itemsText addObject:[NSString stringWithFormat:@"出版年份：%@", self.bookEntity.pubdate]];
    }
    
    if (self.bookEntity.price) {
        [itemsText addObject:[NSString stringWithFormat:@"定价：%@", self.bookEntity.price]];
    }
    
    if (self.bookEntity.isbn13) {
        [itemsText addObject:[NSString stringWithFormat:@"ISBN：%@", self.bookEntity.isbn13]];
    } else if (self.bookEntity.isbn10) {
        [itemsText addObject:[NSString stringWithFormat:@"ISBN：%@", self.bookEntity.isbn10]];
    }
    
    __block UILabel *lastLabel = titlelabel;
    
    [itemsText enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *itemlabel = [[UILabel alloc] init];
        itemlabel.translatesAutoresizingMaskIntoConstraints = NO;
        itemlabel.text = obj;
        itemlabel.font = [UIFont systemFontOfSize:11.0f];
        itemlabel.textColor = [UIColor whiteColor];
        [headView addSubview:itemlabel];
        
        [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[coverImageView]-14-[itemlabel]-(>=15)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(coverImageView, itemlabel)]];
        [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastLabel]-4-[itemlabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLabel, itemlabel)]];
        
        lastLabel = itemlabel;
    }];
    
    //收藏按钮
    UIButton *favButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favButton.translatesAutoresizingMaskIntoConstraints = NO;
    favButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [favButton setBackgroundColor:[UIColor whiteColor]];
    [favButton setTitle:@"收藏" forState:UIControlStateNormal];
    [favButton setTitle:@"已收藏" forState:UIControlStateDisabled];
    [favButton setTitleColor:UIColorFromRGB(0x16984D) forState:UIControlStateNormal];
    [favButton setTitleColor:UIColorFromRGB(0xABABAB) forState:UIControlStateDisabled];
    favButton.layer.cornerRadius = 2.0f;
    [favButton addTarget:self action:@selector(didTapFavButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:favButton];
    
    //检查是否已经收藏过
    BookEntity *bookEntity = [BookDetailService searchFavedBookWithDoubanId:self.bookEntity.doubanId];
    if (bookEntity) {
        favButton.enabled = NO;
    }
    
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[coverImageView]-14-[favButton(==70)]" options:NSLayoutFormatAlignAllBottom metrics:nil views:NSDictionaryOfVariableBindings(coverImageView, favButton)]];
    [headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[favButton(==27)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(favButton)]];
    
    //底部
    UIView *bodyView = [[UIView alloc] init];
    bodyView.translatesAutoresizingMaskIntoConstraints = NO;
    bodyView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:bodyView];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bodyView(==scrollView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bodyView, scrollView)]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headView]-0-[bodyView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bodyView, headView)]];
    
    //内容简介
    UILabel *summarylabel = [[UILabel alloc] init];
    summarylabel.translatesAutoresizingMaskIntoConstraints = NO;
    summarylabel.text = @"内容简介";
    summarylabel.font = [UIFont systemFontOfSize:16.0f];
    summarylabel.textColor = UIColorFromRGB(0x555555);
    [bodyView addSubview:summarylabel];
    
    //内容简介详情
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    detailLabel.text = [self.bookEntity.summary stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    detailLabel.numberOfLines = 0;
    detailLabel.font = [UIFont systemFontOfSize:15.0f];
    detailLabel.textColor = UIColorFromRGB(0x999999);
    [bodyView addSubview:detailLabel];
    
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[summarylabel]-6.5-[detailLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(summarylabel, detailLabel)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[summarylabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(summarylabel)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[detailLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailLabel)]];
}




#pragma mark - scroll response

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //滑动修改头部
    if (scrollView.contentOffset.y != 0) {
        self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight - scrollView.contentOffset.y);
    } else {
        self.backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kBackgroundHeight);
    }

}

#pragma mark - actions

- (void)didTapFavButton:(UIButton *)button
{
    long long bookId = [BookDetailService favBook:self.bookEntity];
    if (bookId > 0) {
        [button setEnabled:NO];
    }
}

@end
