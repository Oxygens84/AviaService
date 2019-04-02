//
//  SearchViewController.h
//  AviaService
//
//  Created by Oxana Lobysheva on 01/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UITableViewController

@property (nonatomic, strong) NSArray *results;

-(void)update;

@end
