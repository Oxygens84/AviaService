//
//  News.m
//  NewsService
//
//  Created by Oxana Lobysheva on 02/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "News.h"

@implementation News

- (instancetype)initWith: (NSString *)title
                 content: (NSString *)content
                   image: (NSString *)image
                  source: (NSString *)source
                     url: (NSString *)url{
    self = [super init];
    if (self)
    {
        self.news_title = title;
        self.news_content = [NSString stringWithFormat:@"%@\n\n%@", content, url] ;
        self.news_urlToImage = image;
        self.news_source = source;
    }
    return self;
}

@end
