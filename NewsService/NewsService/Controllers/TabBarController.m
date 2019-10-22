//
//  TabBarController.m
//  NewsService
//
//  Created by Oxana Lobysheva on 01/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "TabBarController.h"

#import "MainViewController.h"
#import "MapViewController.h"

@implementation TabBarController

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.viewControllers = [self createViewControllers];
        self.tabBar.tintColor = [UIColor blackColor];
    }
    return self;
}

- (NSArray<UIViewController*> *)createViewControllers {
    NSMutableArray<UIViewController*> *controllers = [NSMutableArray new];
    
    MainViewController *mainViewController = [[MainViewController alloc] init];
    mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"TITLE_NEWS", @"") image:[UIImage imageNamed:@"news"] selectedImage:[UIImage imageNamed:@"news"]];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [controllers addObject:mainNavigationController];
    
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"TITLE_MAP", @"") image:[UIImage imageNamed:@"map"] selectedImage:[UIImage imageNamed:@"map"]];
    UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    [controllers addObject:mapNavigationController];
    
    MainViewController *favoriteViewController = [[MainViewController alloc] initFavoriteNewsController];
    favoriteViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"TITLE_FAVORITES", @"") image:[UIImage imageNamed:@"favorite"] selectedImage:[UIImage imageNamed:@"favorite"]];
    UINavigationController *favoriteNavigationController = [[UINavigationController alloc] initWithRootViewController:favoriteViewController];
    [controllers addObject:favoriteNavigationController];
    
    return controllers;
}

@end
