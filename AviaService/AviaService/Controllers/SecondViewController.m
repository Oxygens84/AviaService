//
//  SecondViewController.m
//  AviaService
//
//  Created by Oxana Lobysheva on 17/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "SecondViewController.h"
#import "MainViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface SecondViewController ()

@property (nonatomic, strong) UILabel *someText;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBackground];
    [self configText];
    [self configBackButtom];
    
}

- (void) configBackground {
    [self.view setBackgroundColor: [UIColor colorWithRed:100.0/255.0 green:135.0/255.0 blue:191.0/255.0 alpha:1.0]];
}

- (void) configText {
    self.someText = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-150, SCREEN_WIDTH, 50)];
    [self.someText setText: @"It's the second screen"];
    [self.someText setTextColor: [UIColor whiteColor]];
    [self.someText setTextAlignment: NSTextAlignmentCenter];
    [self.view addSubview: self.someText];
}

- (void) configBackButtom {
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT/2+50, SCREEN_WIDTH-20, 50)];
    [self.backButton setTitle: @"BACK TO LOGIN" forState: UIControlStateNormal];
    [self.backButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [self.backButton setBackgroundColor:[UIColor whiteColor]];
    [self.backButton.layer setCornerRadius:5];
    [self.backButton addTarget: self action: @selector(backButtonTap) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: self.backButton];
}

- (void) backButtonTap {
    [self.backButton setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:35.0/255.0 blue:10.0/255.0 alpha:1.0]];
    [self openMainViewController];
}

- (void)openMainViewController
{
    MainViewController *anotherViewController = [[MainViewController alloc] init];
    [self.navigationController showViewController:anotherViewController sender:self];
    [self.navigationController pushViewController:anotherViewController animated:YES];
    [self presentViewController:anotherViewController animated:YES completion:nil];
}


@end
