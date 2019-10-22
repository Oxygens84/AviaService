//
//  MainViewController.m
//  NewsService
//
//  Created by Oxana Lobysheva on 17/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "MainViewController.h"
#import "SearchViewController.h"
#import "NewsDetailsViewController.h"
#import "UIMainTableViewCell.h"
#import "APIManager.h"
#import "CoreDataHelper.h"
#import "News.h"
#import "ProgressView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define CELL_ID @"CellIdentifier"

@interface MainViewController() <UISearchResultsUpdating>

@property (nonatomic, strong) UIButton *enterButton;
@property (strong, nonnull) UITableView *tableView;
@property (strong, nonnull) NSMutableArray *elements;
@property (strong, nonnull) UIImageView* twitter;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchViewController *resultsController;

@end


@implementation MainViewController {
    BOOL isFavorites;
}

- (instancetype)initFavoriteNewsController {
    self = [super init];
    if (self) {
        isFavorites = YES;
        self.elements = [NSMutableArray new];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[UIMainTableViewCell class] forCellReuseIdentifier:CELL_ID];
    }
    return self;
}

- (instancetype)initWithNews:(NSMutableArray *)news {
    self = [super init];
    if (self)
    {
        self.elements = news;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[UIMainTableViewCell class] forCellReuseIdentifier:CELL_ID];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame: self.view.bounds style: UITableViewStylePlain];
    
    if (isFavorites) {
        self.title = NSLocalizedString(@"TITLE_FAVORITES", @"");
    } else {
        self.title = [NSString stringWithFormat:@"%@ %@",  NSLocalizedString(@"TITLE_NEWS", @""), [APIManager getCurrentDate]];
    }
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    if (!isFavorites) {
        [[APIManager sharedInstance] newsWithCompletion:^(NSMutableArray *articles){
            if (articles) {
                self.elements = articles;
                [self.tableView reloadData];
            }
        }];
        self.resultsController = [[SearchViewController alloc] init];
        self.searchController = [[UISearchController alloc] initWithSearchResultsController: self.resultsController];
        self.searchController.searchResultsUpdater = self;
        self.tableView.tableHeaderView = self.searchController.searchBar;
    }
    [self.view addSubview: self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (isFavorites) {
        self.elements = [[CoreDataHelper sharedInstance] favorites];
        [self.tableView reloadData];
        [UIView transitionWithView:self.view duration:2
                           options:UIViewAnimationOptionTransitionCurlDown
                        animations:^ {}
                        completion:^(BOOL finished){
                            NSLog(@"Animations completed.");
                        }];
    } else {
        [[APIManager sharedInstance] newsWithCompletion:^(NSMutableArray *articles){
            if (articles) {
                self.elements = articles;
                [self.tableView reloadData];
            }
        }];
    }
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSMutableArray *tempArr=[[NSMutableArray alloc] init];
        for (int i=0; i < self.elements.count; i++) {
            News *element = [self.elements objectAtIndex:i];
            if ([[element.news_title uppercaseString] containsString: [searchController.searchBar.text uppercaseString]]) {
                [tempArr addObject:element];
            }
        }
        self.resultsController.results = tempArr;
        [self.resultsController update];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.elements.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIMainTableViewCell *cell;
    if (!cell) {
        cell = [[UIMainTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CELL_ID];
    }
    if (isFavorites) {
        cell.favoriteNews = self.elements[indexPath.row];
    } else {
        News *element = self.elements[indexPath.row];
        cell.title.text = [NSString stringWithFormat:@"%@", element.news_title];
        cell.source.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"LABEL_SOURCE", @""), element.news_source];
        if (![element.news_urlToImage isEqual:[NSNull null]]) {
            NSURL *url = [NSURL URLWithString:element.news_urlToImage];
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
            if (imageData != nil) {
                cell.image.image = [[UIImage alloc] initWithData:imageData];
            }  else {
                [cell.image setAlpha:0];
            }
        } else {
            [cell.image setAlpha:0];
        }
    }
    [cell.title sizeToFit];
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMainTableViewCell *cell;
    if (isFavorites){
        return 60 + 20;
    }
    News *element = [self.elements objectAtIndex:indexPath.row];
    if (![element.news_urlToImage isEqual:[NSNull null]] || cell.image != nil) {
        return 60 + SCREEN_WIDTH - (20);
    }
    return 60 + 20 + 20;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!isFavorites) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"TITLE_FOR_ACTIONS", @"") message:NSLocalizedString(@"MSG_FOR_ACTIONS", @"") preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *favoriteAction;
        
        if ([[CoreDataHelper sharedInstance] isFavorite: [self.elements objectAtIndex:indexPath.row]]) {
            favoriteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ACTION_DEL_FROM_FAVORITES", @"") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [[CoreDataHelper sharedInstance] removeFromFavorite:[self.elements objectAtIndex:indexPath.row]];
            }];
        } else {
            favoriteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ACTION_ADD_TO_FAVORITES", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[CoreDataHelper sharedInstance] addToFavorite:[self.elements objectAtIndex:indexPath.row]];
            }];
            
            
        }
        
        UIAlertAction *detailAction;
        detailAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ACTION_DETAILS", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NewsDetailsViewController *anotherViewController = [[NewsDetailsViewController alloc] init];
            [self.navigationController pushViewController:anotherViewController animated:YES];
            [anotherViewController setTitle: NSLocalizedString(@"TITLE_NEWS_DETAIL", @"")];
            News *someNews = [self.elements objectAtIndex:indexPath.row];
            anotherViewController.someNews = someNews;
            [UIView transitionFromView:self.view
                                toView:anotherViewController.view
                              duration:1.50f
                               options:UIViewAnimationOptionTransitionCurlDown
                            completion:nil];
        }];
        
        UIAlertAction *cancelAction =
            [UIAlertAction actionWithTitle: NSLocalizedString(@"BTN_CANCEL", @"") style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:detailAction];
        [alertController addAction:favoriteAction];        
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFavorites) {
        [[CoreDataHelper sharedInstance] deleteFromFavorite:[self.elements objectAtIndex:indexPath.row]];
        
        NSMutableArray *copy= [self.elements mutableCopy];
        [copy removeObjectAtIndex:indexPath.row];
        self.elements=[copy mutableCopy];
        [self.tableView reloadData];
    }
}

@end
