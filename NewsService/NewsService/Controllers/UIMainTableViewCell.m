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
        [self configSource];
        [self configImage];
    }
    return self;
}

- (void) configTitle {
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET, OFFSET, SCREEN_WIDTH - (OFFSET*2), OFFSET*2)];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.textColor = [UIColor blackColor];
    self.title.numberOfLines = 2;
    [self.contentView addSubview: self.title];
}

- (void) configSource {
    self.source = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET, OFFSET*3, SCREEN_WIDTH - (OFFSET*2), OFFSET*2)];
    self.source.textAlignment = NSTextAlignmentRight;
    self.source.textColor = [UIColor darkGrayColor];
    self.source.numberOfLines = 1;
    [self.contentView addSubview: self.source];
}

- (void) configImage {
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(OFFSET, 60.0 + OFFSET*3 , SCREEN_WIDTH - (OFFSET*2), SCREEN_WIDTH - (OFFSET*4))];
    [self.contentView addSubview: self.image];
}

- (void)setFavoriteNews:(FavoriteNews *)favoriteNews {
    self.title.text = [NSString stringWithFormat:@"♥ %@", favoriteNews.title];
    [self.image setAlpha:0];
}

@end


