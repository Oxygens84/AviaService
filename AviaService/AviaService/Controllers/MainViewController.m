//
//  MainViewController.m
//  AviaService
//
//  Created by Oxana Lobysheva on 17/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "MainViewController.h"
#import "SecondViewController.h"
#import "UIMainTableViewCell.h"
#import "APIManager.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define CELL_ID @"CellIdentifier"

@interface MainViewController()

@property (nonatomic, strong) UIButton *enterButton;
@property (strong, nonnull) UITableView *tableView;
@property (strong, nonnull) NSMutableArray *elements;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.elements = [NSMutableArray arrayWithObjects:@"No data found", nil];
    [[APIManager sharedInstance] newsWithCompletion:^(NSMutableArray *articles){
        NSLog(@"%@", articles);
        if (articles) {
            self.elements = articles;
            [self.tableView reloadData];
        }
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    self.tableView.dataSource = self;

    self.title = @"BITCOIN NEWS";

    [self.view addSubview: self.tableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.elements.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CELL_ID];
    if (!cell) {
        cell = [[UIMainTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CELL_ID];
    }
    cell.leftLabel.text = [NSString stringWithFormat:@"%@", self.elements[indexPath.row]];
    //TODO cell tapped instead of button
    [cell.enterButton addTarget: self action: @selector(enterCellTap) forControlEvents: UIControlEventTouchUpInside];
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *labelText = [self.elements objectAtIndex:indexPath.row];
//    return [self heightForText:labelText];
//}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.elements removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void) enterCellTap{
    SecondViewController *anotherViewController = [[SecondViewController alloc] initWithText: @"More info"];
    [self.navigationController pushViewController:anotherViewController animated:YES];
    [anotherViewController setTitle:@"NEWS details"];
}

@end
