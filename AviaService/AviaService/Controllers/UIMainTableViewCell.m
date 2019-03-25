//
//  UIMainTableViewCell.m
//  AviaService
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
        [self configLeftLabel];
        [self configEnterButtom];
        
    }
    return self;
}

- (void) configLeftLabel {
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET, 0.0, SCREEN_WIDTH / 3.0 * 2 - OFFSET, 44.0)];
    //self.leftLabel.numberOfLines = 2;
    self.leftLabel.textAlignment = NSTextAlignmentLeft;
    self.leftLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview: self.leftLabel];
}

- (void) configEnterButtom {
    self.enterButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3.0 * 2, 0, SCREEN_WIDTH / 3.0 - OFFSET, 44.0)];
    [self.enterButton setTitle: @"Details" forState: UIControlStateNormal];
    [self.enterButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    [self.enterButton setBackgroundColor:[UIColor colorWithRed:100.0/255.0 green:135.0/255.0 blue:191.0/255.0 alpha:1.0]];
    [self.enterButton.layer setCornerRadius:5];
    [self.contentView addSubview: self.enterButton];
}

@end


