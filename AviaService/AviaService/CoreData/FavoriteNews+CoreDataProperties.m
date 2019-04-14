//
//  FavoriteNews+CoreDataProperties.m
//  AviaService
//
//  Created by Oxana Lobysheva on 03/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//
//

#import "FavoriteNews+CoreDataProperties.h"

@implementation FavoriteNews (CoreDataProperties)

+ (NSFetchRequest<FavoriteNews *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavoriteNews"];
}

@dynamic title;
@dynamic content;
@dynamic urlToImage;
@dynamic source;

@end
