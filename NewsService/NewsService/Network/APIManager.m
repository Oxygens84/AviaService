//
//  APIManager.m
//  NewsService
//
//  Created by Oxana Lobysheva on 22/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "APIManager.h"
#import "News.h"

#define API_URL_PART1 @"https://newsapi.org/v2/everything?q=bitcoin&from="
#define API_URL_PART2 @"&sortBy=publishedAt&apiKey=8be4c556b57b46c5843198a10be0239b"

@implementation APIManager

+ (NSString*) getCurrentDate {
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"dd-MM-yyyy"];
    return [objDateformat stringFromDate:[NSDate date]];
};

+ (instancetype)sharedInstance {
    static APIManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIManager alloc] init];
    });
    return instance;
}

- (void)newsWithCompletion:(void (^)(NSMutableArray *articles))completion {
    NSString *url = [NSString stringWithFormat:@"%@/%@%@", API_URL_PART1, [APIManager getCurrentDate], API_URL_PART2];
    [self load: url withCompletion:^(id  _Nullable result) {
        NSDictionary *response = result;
        NSLog(@"%@", response);
        if (response) {
            NSDictionary *json = [response valueForKey:@"articles"];
            NSMutableArray *value = [[NSMutableArray alloc] init];
            for (int i=0; i<20; i++) {
                News *element = [[News alloc] initWith:[json valueForKey: @"title"][i]
                                               content:[json valueForKey: @"content"][i]
                                                 image:[json valueForKey: @"urlToImage"][i]
                                                source:[[json valueForKey: @"source"] valueForKey: @"name"][i]
                                                   url:[json valueForKey: @"url"][i]];
                [value addObject:element];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(value);
            });
        }
    }];
}

- (void)load:(NSString *)urlString withCompletion:(void (^)(id _Nullable result))completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:[NSURL URLWithString:urlString]
                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                        id serializaion = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                        completion(serializaion);
                                    }
                              ];
    [task resume];
}

@end
