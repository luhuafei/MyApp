//
//  NSString+Extension.h
//  MyApp
//
//  Created by DengTianran on 16/7/11.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  把汉字转换成拼音
 *
 *  @param chinese 汉字
 *
 *  @return 拼音
 */
+(NSString *)ConvertPinyinWithChineseCharacters:(NSString *)chinese;
@end
