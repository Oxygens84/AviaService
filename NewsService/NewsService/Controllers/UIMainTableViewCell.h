//
//  UIMainTableViewCell.h
//  NewsService
//
//  Created by Oxana Lobysheva on 20/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"

@interface UIMainTableViewCell: UITableViewCell 

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *source;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) FavoriteNews *favoriteNews;

@end
