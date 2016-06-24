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
/**
 *  初始化
 *
 *  @return object
 */
+ (instancetype)shareInstance;
/**
 *  显示Alert
 *
 *  @param viewController     显示对象
 *  @param title              提示title信息
 *  @param message            message信息
 *  @param cancelButtonTitle  取消按钮title
 *  @param confirmButtonTitle 确定按钮title
 *  @param cancelAction       取消block
 *  @param confirmAction      确定block
 */
- (void)showAlertView:(UIViewController *)viewController
            withTitle:(NSString *)title
          withMessage:(NSString *)message
      withCancelButtonTitle:(NSString *)cancelButtonTitle
     withConfirmButtonTitle:(NSString *)confirmButtonTitle
     withCancelAction:(cancleAction)cancelAction
    withConfirmAction:(confirmAction)confirmAction;


@end
