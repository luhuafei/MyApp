//
//  TabBarController.m
//  MyApp
//
//  Created by DengTianran on 16/6/8.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "TabBarController.h"
#import "EssenceViewController.h"
#import "NewViewController.h"
#import "FriendTrendViewController.h"
#import "MeViewController.h"
#import "NavigationController.h"

@interface TabBarController ()

@end

@implementation TabBarController
+ (void)initialize
{
    //通过appearance统一设置所以UITabBarItem得文字属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary * selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem * item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    
    [self setupChildVc:[[EssenceViewController alloc]init]title:@"精华" image:@"tabBar_essence_click_icon_37x37_" selectedImage:@"tabBar_essence_click_iconN_37x37_"];
    [self setupChildVc:[[NewViewController alloc]init]title:@"新帖" image:@"tabBar_friendTrends_click_icon_37x37_" selectedImage:@"tabBar_friendTrends_click_iconN_37x37_"];
    [self setupChildVc:[[FriendTrendViewController alloc]init]title:@"关注" image:@"tabBar_me_click_icon_37x37_" selectedImage:@"tabBar_me_click_iconN_37x37_"];
    [self setupChildVc:[[MeViewController alloc]initWithStyle:UITableViewStyleGrouped]title:@"我" image:@"tabBar_new_click_icon_37x37_" selectedImage:@"tabBar_new_click_iconN_37x37_"];
}

/**
 *  初始化子控件
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    NavigationController *navc = [[NavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navc];
    
}
@end
