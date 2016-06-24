//
//  EssenceViewController.m
//  MyApp
//
//  Created by DengTianran on 16/6/8.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "EssenceViewController.h"
#import "TopicViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "AllTableViewController.h"
#import "VideoTableViewController.h"
#import "SoundTableViewController.h"
#import "PictureTableViewController.h"
#import "WordTableViewController.h"

@interface EssenceViewController ()<UIScrollViewDelegate>

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

#pragma mark -load lazy


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置当行栏
    [self setupNavigationBar];
    
    //初始化控制器
    [self setupChildViewControllers];
    
    //设置顶部标签栏
    [self setupTitlesView];
    
    //设置底部scrollView
    [self setupContentView];
    
}

#pragma mark - custom action
- (void)setupNavigationBar
{
    //设置导航栏
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle_107x19_"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon_18x15_" target:self highImage:@"MainTagSubIconClick_18x15_" action:@selector(EssenceClick)];
    
     self.view.backgroundColor = GlobalBg;
    
}

- (void)setupChildViewControllers
{
    NSArray *controllers = @[@"AllTableViewController",
                             @"VideoTableViewController",
                             @"SoundTableViewController",
                             @"PictureTableViewController",
                             @"WordTableViewController"];
    for (NSString *controllerName in controllers)
    {
        UITableViewController *VC = [[NSClassFromString(controllerName) alloc] init];
        [self addChildViewController:VC];
    }
    
}

- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.width = self.view.width;
    titlesView.height = TitlesViewH;
    titlesView.y = TitlesViewY;
    [self.view addSubview:titlesView];
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    NSArray * titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton * button = [[UIButton alloc]init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(tilteClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectButton = button;
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    self.titleView = titlesView;
    [titlesView addSubview:indicatorView];
    
    
}

- (void)setupContentView
{
    //不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    //添加第一个控制器
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}
#pragma  mark - button action

- (void)EssenceClick
{
    DLog(@"点击按钮");
//    RecommendTagsViewController * tag = [[RecommendTagsViewController alloc]init];
//    [self.navigationController pushViewController:tag animated:YES];
}
/**
 *  点击标签栏
 */
- (void)tilteClick:(UIButton *)button
{
    //修改按钮状态
    self.selectButton.enabled = YES;
    button.enabled = NO;
    self.selectButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //去除子控制器
    UITableViewController *VC = self.childViewControllers[index];
    VC.view.x = scrollView.contentOffset.x;
    VC.view.y = 0;
    VC.view.height = scrollView.height;
    
    [scrollView addSubview:VC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self tilteClick:self.titleView.subviews[index]];
}


@end
