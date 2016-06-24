//
//  User.h
//  MyApp
//
//  Created by DengTianran on 16/5/27.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "User.h"

@interface User ()

@end

@implementation User

- (NSString *)username
{
    if (_username == nil) {
        self.username = @"qwwqeq";
    }
    return _username;
}


@end
