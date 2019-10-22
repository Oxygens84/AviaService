//
//  AppDelegate.m
//  NewsService
//
//  Created by Oxana Lobysheva on 17/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "TabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect frame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame: frame];
    
    TabBarController *tabBarController = [[TabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    NSURL *ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        NSLog(@"AppDelegate: iCloud access");
    } else {
        NSLog(@"AppDelegate: No iCloud access (either you are using simulator or, if you are on your phone, you should check settings");
    }
    
    return YES;
}

@end
