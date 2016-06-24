//
// Commend.h
//  MyApp
//
//  Created by DengTianran on 16/5/27.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface Commend : NSObject
/**id */
@property (nonatomic,strong)NSString * ID;
/**评论的用户 */
@property (nonatomic,assign)NSInteger like_count;

/**评论的内容 */
@property (nonatomic,strong)NSString * content;

/**音频时间 */
@property (nonatomic,assign)NSInteger voicetime;

/**音频文件路径 */
@property (nonatomic,strong)NSString * voiceuri;

@property (nonatomic,strong)User * user;
@end
