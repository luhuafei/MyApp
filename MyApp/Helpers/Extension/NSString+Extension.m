//
//  NSString+Extension.m
//  MyApp
//
//  Created by DengTianran on 16/7/11.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
+(NSString *)ConvertPinyinWithChineseCharacters:(NSString *)chinese
{
    if ([chinese length])
    {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:chinese];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            return ms;
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            return ms;
        }
        return nil;
    }else
    {
        return nil;
    }
}
@end
