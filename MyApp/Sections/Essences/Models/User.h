//
//  User.h
//  MyApp
//
//  Created by DengTianran on 16/5/27.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

/**用户名 */
@property (nonatomic,strong)NSString * username;

/**性别 */
@property (nonatomic,strong)NSString * sex;

/**头像 */
@property (nonatomic,strong)NSString * profile_image;
@end
