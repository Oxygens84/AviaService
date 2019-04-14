//
//  APIManager.h
//  NewsService
//
//  Created by Oxana Lobysheva on 22/03/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIManager : NSObject

+ (instancetype)sharedInstance;
- (void)newsWithCompletion:(void (^)(NSMutableArray *articles))completion;
+ (NSString*) getCurrentDate;

@end
