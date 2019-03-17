//
//  AppDelegate.m
//  AviaService
//
//  Created by Oxana Lobysheva on 17/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame: frame];
    
    MainViewController *firstViewController = [[MainViewController alloc] init];
    
    //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: mainViewController];
    //self.window.rootViewController = navigationController;
    
    self.window.rootViewController = firstViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
