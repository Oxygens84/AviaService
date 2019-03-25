//
//  APIManager.m
//  AviaService
//
//  Created by Oxana Lobysheva on 22/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "APIManager.h"

#define API_URL @"https://newsapi.org/v2/everything?q=bitcoin&from=2019-02-24&sortBy=publishedAt&apiKey=8be4c556b57b46c5843198a10be0239b"

@implementation APIManager

+ (instancetype)sharedInstance {
    static APIManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIManager alloc] init];
    });
    return instance;
}

- (void)newsWithCompletion:(void (^)(NSMutableArray *articles))completion {
    [self load: API_URL withCompletion:^(id  _Nullable result) {
        NSDictionary *response = result;
        if (response) {
            NSDictionary *json = [response valueForKey:@"articles"];
            NSMutableArray *value = [json valueForKey: @"title"];
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
