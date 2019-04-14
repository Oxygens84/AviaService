//
//  News.h
//  NewsService
//
//  Created by Oxana Lobysheva on 02/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, strong) NSString *news_title;
@property (nonatomic, strong) NSString *news_content;
@property (nonatomic, strong) NSString *news_urlToImage;
@property (nonatomic, strong) NSString *news_source;

- (instancetype)initWith: (NSString *)title
                 content: (NSString *)content
                   image: (NSString *)image
                  source: (NSString *)source;

//content urlToImage  url  source.name publishedAt
@end
