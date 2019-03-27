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
#define OFFSET 10.0

@interface SecondViewController ()

//@property (nonatomic, strong) UIImageView *backgroundImage;
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
    self.someText = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET, OFFSET, SCREEN_WIDTH-OFFSET, SCREEN_HEIGHT-OFFSET-150)];
    [self.someText setTextAlignment: NSTextAlignmentLeft];
    self.someText.numberOfLines = 10;
    [self.someText setText: self.news];
    [self.someText setTextColor: [UIColor whiteColor]];
    [self.view addSubview: self.someText];
}

- (void) configBackButtom {
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(OFFSET, SCREEN_HEIGHT-100, SCREEN_WIDTH-OFFSET, 50)];
    [self.backButton setTitle: @"CLICK ME" forState: UIControlStateNormal];
    [self.backButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [self.backButton setBackgroundColor:[UIColor whiteColor]];
    [self.backButton.layer setCornerRadius:5];
    [self.backButton addTarget: self action: @selector(clickButtonTap) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: self.backButton];
}

- (void)displayMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Details" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) clickButtonTap {
    [self displayMessage: @"Thanks for watching. ありがとう"];
}

- (void)openMainViewController
{
    MainViewController *anotherViewController = [[MainViewController alloc] init];
    [self.navigationController showViewController:anotherViewController sender:self];
    [self.navigationController pushViewController:anotherViewController animated:YES];
    [self presentViewController:anotherViewController animated:YES completion:nil];
}

@end
