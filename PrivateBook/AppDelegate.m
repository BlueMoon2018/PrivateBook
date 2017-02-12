//
//  AppDelegate.m
//  PrivateBook
//
//  Created by chenbin on 17/1/16.
//  Copyright © 2017年 chenbin. All rights reserved.
//

#import "AppDelegate.h"

#import "BookListViewController.h"
#import "BookScannerViewController.h"
#import "BookAnalysisViewController.h"
#import "BookBaseNavigationController.h"

#import "BookDBHelper.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //sleep(3);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initTabBar];
    [self initDB];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - DB

- (void)initDB
{
    //检查数据库
    NSString *dbPath = [BookDBHelper dbPath];
    
    BOOL dbExist = [[NSFileManager defaultManager] fileExistsAtPath:dbPath isDirectory:nil];
    
    if (!dbExist) {
        [BookDBHelper buildDataBase];
    }
}


#pragma mark - TabBar

- (void)initTabBar
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    tabBarController.delegate = self;
    
    self.window.rootViewController = tabBarController;
    tabBarController.tabBar.barTintColor = UIColorFromRGB(0xF5F5F5);
    tabBarController.tabBar.tintColor = UIColorFromRGB(0x009D82);
    
    BookListViewController *bookListController = [[BookListViewController alloc] init];
    BookBaseNavigationController *bookListNav = [[BookBaseNavigationController alloc] initWithRootViewController:bookListController];
    bookListController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的藏书" image:[[UIImage imageNamed:@"tabbar-icon-collection"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"tabbar-icon-collection"]];
    
    BookScannerViewController *bookScannerController = [[BookScannerViewController alloc] init];
    bookScannerController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"扫码藏书" image:[[UIImage imageNamed:@"tabbar-icon-scan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"tabbar-icon-scan"]];
    
    BookAnalysisViewController *bookAnalysisController = [[BookAnalysisViewController alloc] init];
    BookBaseNavigationController *bookAnalysisNav = [[BookBaseNavigationController alloc] initWithRootViewController:bookAnalysisController];
    bookAnalysisController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[[UIImage imageNamed:@"tabbar-icon-me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"tabbar-icon-me"]];
    
    tabBarController.viewControllers = @[bookListNav, bookScannerController, bookAnalysisNav];
    
    tabBarController.tabBar.itemPositioning = UITabBarItemPositioningCentered;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[BookScannerViewController class]]) {
        BookScannerViewController *bookScannerController = [[BookScannerViewController alloc] init];
        
        BookBaseNavigationController *nav = [[BookBaseNavigationController alloc] initWithRootViewController:bookScannerController];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}


@end
