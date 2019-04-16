//
//  NewsDetailsViewController.m
//  NewsService
//
//  Created by Oxana Lobysheva on 17/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailsViewController.h"
#import "MainViewController.h"
#import "LocationService.h"
#import "MapViewController.h"
#import "CoreDataHelper.h"
#import "News.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define OFFSET 10.0

@interface NewsDetailsViewController ()

@property (nonatomic, strong) UILabel *newsContent;
@property (nonatomic, strong) UILabel *newsSource;
@property (nonatomic, strong) UIButton *completeReadingButton;

@end

@implementation NewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBackground];
    [self configText];
    [self configSource];
}

- (void) configBackground {
    [self.view setBackgroundColor: [UIColor whiteColor]];
}

- (void) configText {
    self.newsContent = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET, OFFSET, SCREEN_WIDTH-(2*OFFSET), SCREEN_HEIGHT-OFFSET-150)];
    [self.newsContent setTextAlignment: NSTextAlignmentLeft];
    self.newsContent.numberOfLines = 15;
    if (![self.someNews.news_content isEqual:[NSNull null]]) {
        [self.newsContent setText: self.someNews.news_content];
    } else {
        [self.newsContent setText: self.someNews.news_title];
    }
    [self.newsContent setTextColor: [UIColor blackColor]];
    [self.view addSubview: self.newsContent];
}

- (void) configSource {
    self.newsSource = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET, SCREEN_HEIGHT-150, SCREEN_WIDTH-(2*OFFSET), 50)];
    [self.newsSource setTextAlignment: NSTextAlignmentRight];
    self.newsSource.numberOfLines = 1;
    if (![self.someNews.news_source isEqual:[NSNull null]]) {
        [self.newsSource setText: self.someNews.news_source];
    } else {
        [self.newsSource setText: NSLocalizedString(@"DEFAULT_SOURCE", @"")];
    }
    [self.newsSource setTextColor: [UIColor darkGrayColor]];
    [self.view addSubview: self.newsSource];
}

- (void)displayMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ACTION_DETAILS", @"") message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"BTN_OK", @"") style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) clickButtonTap {
    [[CoreDataHelper sharedInstance] removeFromFavorite: self.someNews];
    [_completeReadingButton setAlpha:0];
}

- (void)openMainViewController
{
    MainViewController *anotherViewController = [[MainViewController alloc] init];
    [self.navigationController showViewController:anotherViewController sender:self];
    [self.navigationController pushViewController:anotherViewController animated:YES];
    [self presentViewController:anotherViewController animated:YES completion:nil];
}

- (void)start {
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 500;
    
    [locationManager startUpdatingLocation];
}

@end
