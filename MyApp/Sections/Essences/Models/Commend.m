//
//  Commend.h
//  MyApp
//
//  Created by DengTianran on 16/5/27.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "Commend.h"
#import <MJExtension.h>

@interface Commend ()

@end

@implementation Commend
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             };
}




@end
