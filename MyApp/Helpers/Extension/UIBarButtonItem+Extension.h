//UIBarButtonItem+Extension.h
//  MyApp
//
//  Created by DengTianran on 16/5/27.
//  Copyright © 2016年 DengTianran. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image target:(id)target highImage:(NSString *)highImage action:(SEL)action;
@end
