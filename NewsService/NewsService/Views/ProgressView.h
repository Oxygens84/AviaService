//
//  ProgressView.h
//  NewsService
//
//  Created by Oxana Lobysheva on 11/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

- (void)show:(void (^)(void))completion;
- (void)dismiss:(void (^)(void))completion;

@end
