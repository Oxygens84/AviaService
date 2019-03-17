//
//  MainViewController.m
//  AviaService
//
//  Created by Oxana Lobysheva on 17/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "MainViewController.h"
#import "SecondViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()

@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UILabel *greetingLabel;
@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) UITextField *userName;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self configBackground];
    [self configGreetingLabel];
    [self configEnterButtom];
    [self configUser];
    
}

- (void) configBackground {
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundImage = [[UIImageView alloc] initWithFrame: frame];
    self.backgroundImage.image = [UIImage imageNamed:@"background"];
    self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImage.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.backgroundImage];
}

- (void) configGreetingLabel {
    self.greetingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-150, SCREEN_WIDTH, 50)];
    [self.greetingLabel setText: @"Hello, dear guest!"];
    [self.greetingLabel setTextColor: [UIColor blueColor]];
    [self.greetingLabel setTextAlignment: NSTextAlignmentCenter];
    [self.view addSubview: self.greetingLabel];
}

- (void) configUser {
    self.userName = [[UITextField alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-100, SCREEN_WIDTH, 50)];
    [self.userName setPlaceholder: @"INTER your name"];
    [self.userName setTextColor:[UIColor redColor]];
    [self.userName setTextAlignment: NSTextAlignmentCenter];
    [self.view addSubview: self.userName];
}


- (void) configEnterButtom {
    self.enterButton = [[UIButton alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT/2+50, SCREEN_WIDTH-20, 50)];
    [self.enterButton setTitle: @"ENTER" forState: UIControlStateNormal];
    [self.enterButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [self.enterButton setBackgroundColor:[UIColor colorWithRed:100.0/255.0 green:135.0/255.0 blue:191.0/255.0 alpha:1.0]];
    [self.enterButton.layer setCornerRadius:5];
    [self.enterButton addTarget: self action: @selector(enterButtonTap) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: self.enterButton];
}

- (void) enterButtonTap {
    [self.enterButton setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:35.0/255.0 blue:10.0/255.0 alpha:1.0]];
    if (self.userName.text != nil) {
        NSString *personGreeting = [NSString stringWithFormat:@"Hello, dear %@", self.userName.text];
        [self.greetingLabel setText: personGreeting];
    }
    [self openSecondViewController];
}


- (void)openSecondViewController
{
    SecondViewController *anotherViewController = [[SecondViewController alloc] init];
    [self.navigationController showViewController:anotherViewController sender:self];
    [self.navigationController pushViewController:anotherViewController animated:YES];
    [self presentViewController:anotherViewController animated:YES completion:nil];
}

@end
