//
//  MainViewController.m
//  AviaService
//
//  Created by Oxana Lobysheva on 17/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "MainViewController.h"
#import "SearchViewController.h"
#import "NewsDetailsViewController.h"
#import "UIMainTableViewCell.h"
#import "APIManager.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define CELL_ID @"CellIdentifier"

@interface MainViewController() <UISearchResultsUpdating>

@property (nonatomic, strong) UIButton *enterButton;
@property (strong, nonnull) UITableView *tableView;
@property (strong, nonnull) NSMutableArray *elements;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchViewController *resultsController;

@end


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    self.title = [NSString stringWithFormat:@"%@ %@", @"BITCOIN NEWS ", [APIManager getCurrentDate]];

    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.elements = [NSMutableArray arrayWithObjects:@"No data found", nil];
    
    self.resultsController = [[SearchViewController alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController: self.resultsController];
    self.searchController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [[APIManager sharedInstance] newsWithCompletion:^(NSMutableArray *articles){
        NSLog(@"%@", articles);
        if (articles) {
            self.elements = articles;
            [self.tableView reloadData];
        }
    }];
    [self.view addSubview: self.tableView];
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text) {
        self.resultsController.results = [self.elements filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchController.searchBar.text]];
        [self.resultsController update];
    }
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
    cell.leftLabel.numberOfLines = 2;
    [cell.leftLabel sizeToFit];
    return cell;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.elements removeObjectAtIndex:indexPath.row];
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//}

//- (CGFloat)heightForText:(NSString *)bodyText
//{
//    UIFont *cellFont = [UIFont systemFontOfSize:17];
//    CGSize constraintSize = CGSizeMake(200, MAXFLOAT);
//    CGSize labelSize = [bodyText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
//    CGFloat height = labelSize.height + 10;
//    return height;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *labelText = [self.elements objectAtIndex:indexPath.row];
    //return [self heightForText:labelText];
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailsViewController *anotherViewController = [[NewsDetailsViewController alloc] init];
    [self.navigationController pushViewController:anotherViewController animated:YES];
    [anotherViewController setTitle:@"NEWS details"];
    anotherViewController.news = self.elements[indexPath.row];
}

@end
