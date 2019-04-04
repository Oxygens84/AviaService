//
//  CoreDataHelper.h
//  AviaService
//
//  Created by Oxana Lobysheva on 03/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FavoriteNews+CoreDataClass.h"

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavorite:(NSString *)news_title;
- (NSMutableArray *)favorites;
- (void)addToFavorite:(NSString *)news_title;
- (void)removeFromFavorite:(NSString *)news_title;

@end

