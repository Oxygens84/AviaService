//
//  MainViewController.h
//  NewsService
//
//  Created by Oxana Lobysheva on 17/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController: UIViewController <UITableViewDataSource,UITableViewDelegate>

- (instancetype)initWithNews:(NSMutableArray *)news;
- (instancetype)initFavoriteNewsController;

@end

