//
//  EssenceViewController.m
//  MyApp
//
//  Created by DengTianran on 16/6/8.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "EssenceViewController.h"
#import "TopicViewController.h"

@interface EssenceViewController ()

/**
 标签栏底部红色的指示器
 */
@property (nonatomic,strong)UIView * indicatorView;
/**
 当前选中的按钮
 */
@property (nonatomic,strong)UIButton * selectButton;
/**
 顶部的所有标签
 */
@property (nonatomic,strong)UIView * titleView;
/**
 底部的所有标签
 */
@property (nonatomic,strong)UIScrollView * contentView;

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController pushViewController:[TopicViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
