//
//  BookScannerViewController.m
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "BookScannerViewController.h"
#import "BookDetailViewController.h"

#import "BookScannerView.h"

#import "BookEntity.h"

#import <AVFoundation/AVFoundation.h>
#import <AFNetworking.h>

#import "BookDetailService.h"

@interface BookScannerViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) BookScannerView *scannerView;

@property (nonatomic, strong) AVCaptureSession *captureSession;

@end

@implementation BookScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigation];
    [self initSubviews];

    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma makr - Navigation

- (void)initNavigation
{
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
    [backButton sizeToFit];
    
    [backButton addTarget:self action:@selector(didTapBackButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //手电筒
    UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashButton setImage:[UIImage imageNamed:@"light-off"] forState:UIControlStateNormal];
    [flashButton setImage:[UIImage imageNamed:@"light-on"] forState:UIControlStateSelected];
    [flashButton sizeToFit];
    
    [flashButton addTarget:self action:@selector(didTapFlashButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:flashButton];
}

- (BOOL)shouldShowShadowImage
{
    return NO;
}

- (UIImage *)navigationBarBackgroundImage
{
    return [UIImage new];
}

- (void)didTapBackButton:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapFlashButton:(UIButton *)button
{
    button.selected = !button.selected;
    
    //开启关闭手电筒
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device hasTorch]) {
        AVCaptureTorchMode mode = button.selected ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
        
        [device lockForConfiguration:nil];
        
        [device setTorchMode:mode];
        
        [device unlockForConfiguration];
    }
}

#pragma mark - Subviews

- (void)initSubviews
{
    [self initScannerView];
    [self initCamera];
    [self initTip];
}

- (void)initCamera
{
    self.captureSession = [[AVCaptureSession alloc] init];
    
    [self.captureSession beginConfiguration];
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //输入
    NSError *error = nil;
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (error == nil) {
        if ([self.captureSession canAddInput:captureInput]) {
            [self.captureSession addInput:captureInput];
        }
    } else {
        NSLog(@"Input Error : %@", error);
    }
    
    //输出
    AVCaptureMetadataOutput *captureOutput = [[AVCaptureMetadataOutput alloc] init];
    [captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if ([self.captureSession canAddOutput:captureOutput]) {
        [self.captureSession addOutput:captureOutput];
        [captureOutput setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code]];
    }
    
    //添加预览画面
    CALayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    [self.captureSession commitConfiguration];
    
    [self.captureSession startRunning];
    [self.scannerView startAnimation];
}

- (void)initScannerView
{
    self.scannerView = [[BookScannerView alloc] initWithFrame:self.view.bounds rectSize:CGSizeMake(230.0f, 230.0f) offsetY:-43.0f];
    self.scannerView.backgroundColor = [UIColor clearColor];
    self.scannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scannerView];
}

- (void)initTip
{
    
}

#pragma mark - ISBN 识别

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *ISBN = nil;
    
    for (AVMetadataObject *metaData in metadataObjects) {
        ISBN = [(AVMetadataMachineReadableCodeObject *)metaData stringValue];
        break;
    }
    
    if (ISBN != nil) {
        NSLog(@"ISBN : %@", ISBN);
        
        [self fetchBookWithISBN:ISBN];
        
        [self.captureSession stopRunning];
        [self.scannerView stopAnimation];
    }
}

- (void)fetchBookWithISBN:(NSString *)ISBN
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@", ISBN]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"Error : %@", error);
        } else {
//            NSLog(@"%@, %@", response, responseObject);
            
            NSString *title = [responseObject objectForKey:@"title"];
            NSArray *authorArray = [responseObject objectForKey:@"author"];
            
            NSString *author = nil;
            if (authorArray.count > 0) {
                author = authorArray[0];
            }
            
            BookEntity *bookEntity = [[BookEntity alloc] initWithDictionary:responseObject];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@\n%@\n%@", title, ISBN, author] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *detailAction = [UIAlertAction actionWithTitle:@"查看详情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                BookDetailViewController *detailController = [[BookDetailViewController alloc] init];
                [detailController setBookEntity:bookEntity];
                
                [self.navigationController pushViewController:detailController animated:YES];
            }];
            [alertController addAction:detailAction];
            
            BookEntity *favedBookEntity = [BookDetailService searchFavedBookWithDoubanId:bookEntity.doubanId];
            if (favedBookEntity == nil) {
                UIAlertAction *nextAction = [UIAlertAction actionWithTitle:@"收藏并继续扫描" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [BookDetailService favBook:bookEntity];
                    [self.captureSession startRunning];
                    [self.scannerView startAnimation];
                }];
                [alertController addAction:nextAction];
            }
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
    [dataTask resume];
}









@end
