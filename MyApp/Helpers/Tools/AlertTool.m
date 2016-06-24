//
//  AlertTool.m
//  StoryBoard
//
//  Created by DengTianran on 16/6/23.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "AlertTool.h"

#define IAIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface AlertTool ()
@property (copy, nonatomic)cancleAction cancelAction;
@property (copy, nonatomic)confirmAction confirmAction;
@end

static AlertTool *alertTool = nil;
@implementation AlertTool
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertTool = [[AlertTool alloc] init];
    });
    return alertTool;
}


- (void)showAlertView:(UIViewController *)viewController
            withTitle:(NSString *)title
          withMessage:(NSString *)message
withCancelButtonTitle:(NSString *)cancelButtonTitle
withConfirmButtonTitle:(NSString *)confirmButtonTitle
     withCancelAction:(cancleAction)cancelAction
    withConfirmAction:(confirmAction)confirmAction
{
    self.cancelAction = cancelAction;
    self.confirmAction = confirmAction;
    if (IAIOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
           self.cancelAction();
        }];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.confirmAction();
        }];
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:confirmAction];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIAlertView *TitleAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:confirmButtonTitle,nil];
        [TitleAlert show];
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        self.confirmAction();
    }
    else{
        self.cancelAction();
    }
}
@end
