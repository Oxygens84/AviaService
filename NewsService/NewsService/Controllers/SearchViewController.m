//
//  SearchViewController.m
//  NewsService
//
//  Created by Oxana Lobysheva on 01/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "SearchViewController.h"
#import "UIMainTableViewCell.h"
#import "NewsDetailsViewController.h"
#import "APIManager.h"
#import "CoreDataHelper.h"
#import "News.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define CELL_ID @"ResultsIdentifier"

@interface SearchViewController () {
    BOOL isFavorites;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)update {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CELL_ID ];
    if (!cell) {
        cell = [[UIMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID ];
    }
    if (isFavorites) {
        cell.favoriteNews = [self.results objectAtIndex:indexPath.row];
    } else {
        News *element = self.results[indexPath.row];
        cell.title.text = [NSString stringWithFormat:@"%@", element.news_title];
        if (![element.news_urlToImage isEqual:[NSNull null]]) {
            NSURL *url = [NSURL URLWithString:element.news_urlToImage];
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
            cell.image.image = [[UIImage alloc] initWithData:imageData];
        } else {
            [cell.image setAlpha:0];
        }        
    }
    cell.title.numberOfLines = 2;
    [cell.title sizeToFit];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailsViewController *anotherViewController = [[NewsDetailsViewController alloc] init];
    [self.navigationController pushViewController:anotherViewController animated:YES];
    //[anotherViewController setTitle:@"NEWS details"];
    anotherViewController.someNews = self.results[indexPath.row];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News *element = [self.results objectAtIndex:indexPath.row];
    if (![element.news_urlToImage isEqual:[NSNull null]]) {
        return 60 + SCREEN_WIDTH - (20*2);
    }
    return 60;
}

@end
