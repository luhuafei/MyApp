//
//  AlertTool.h
//  StoryBoard
//
//  Created by DengTianran on 16/6/23.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^confirmAction)();
typedef void (^cancleAction)();
@interface AlertTool : NSObject
+ (instancetype)shareInstance;

- (void)showAlertView:(UIViewController *)viewController
            withTitle:(NSString *)title
          withMessage:(NSString *)message
      withCancelButtonTitle:(NSString *)cancelButtonTitle
     withConfirmButtonTitle:(NSString *)confirmButtonTitle
     withCancelAction:(cancleAction)cancelAction
    withConfirmAction:(confirmAction)confirmAction;


@end
