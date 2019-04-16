//
//  CoreDataHelper.h
//  NewsService
//
//  Created by Oxana Lobysheva on 03/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FavoriteNews+CoreDataClass.h"
#import "News.h"

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavorite:(News *)news;
- (NSMutableArray *)favorites;
- (void)addToFavorite:(News *)news;
- (void)removeFromFavorite:(News *)news;
- (void)deleteFromFavorite:(FavoriteNews *)favorite;

@end

