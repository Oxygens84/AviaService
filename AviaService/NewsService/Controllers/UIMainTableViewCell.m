//
//  UIMainTableViewCell.m
//  NewsService
//
//  Created by Oxana Lobysheva on 20/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//


#import "UIMainTableViewCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define OFFSET 20.0

@interface UIMainTableViewCell()

@end

@implementation UIMainTableViewCell

- (instancetype)initWithStyle: (UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configTitle];
        [self configImage];
    }
    return self;
}

- (void) configTitle {
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET, OFFSET, SCREEN_WIDTH - (OFFSET*2), OFFSET*2)];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.textColor = [UIColor blackColor];
    [self.contentView addSubview: self.title];
}

- (void) configImage {
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(OFFSET, 60.0 + OFFSET , SCREEN_WIDTH - (OFFSET*2), SCREEN_WIDTH - (OFFSET*2))];
    [self.contentView addSubview: self.image];
}

- (void) configEnterButtom {
    self.enterButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3.0 * 2, 0, SCREEN_WIDTH / 3.0 - OFFSET, OFFSET*2)];
    [self.enterButton setTitle: @"Details" forState: UIControlStateNormal];
    [self.enterButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [self.enterButton setBackgroundColor:[UIColor colorWithRed:100.0/255.0 green:135.0/255.0 blue:191.0/255.0 alpha:1.0]];
    [self.enterButton.layer setCornerRadius:5];
    [self.contentView addSubview: self.enterButton];
}

- (void)setFavoriteNews:(FavoriteNews *)favoriteNews {
    //self.favoriteNews = favoriteNews;
    self.title.text = [NSString stringWithFormat:@"♥ %@", favoriteNews.title];
    [self.image setAlpha:0];
}

@end


