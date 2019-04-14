//
//  FavoriteNews+CoreDataProperties.h
//  NewsService
//
//  Created by Oxana Lobysheva on 03/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//
//

#import "FavoriteNews+CoreDataClass.h"

@interface FavoriteNews (CoreDataProperties)

+ (NSFetchRequest<FavoriteNews *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *urlToImage;
@property (nullable, nonatomic, copy) NSString *source;

@end
