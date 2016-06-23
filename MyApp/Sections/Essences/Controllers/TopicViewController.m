//
//  TopicViewController.m
//  MyApp
//
//  Created by DengTianran on 16/6/8.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "TopicViewController.h"
#import "MJRefresh.h"
#import "NewViewController.h"
#import "TopicsCell.h"
#import "WordModel.h"
#import <MJExtension.h>
@interface TopicViewController ()
/**帖子数据 */
@property (nonatomic,strong)NSMutableArray * topics;

/**页码 */
@property (nonatomic,assign)NSInteger page;

/**当加载下一页数据是需要这个参数 */
@property (nonatomic,strong)NSString * maxtime;

/**上一次的请求参数 */
@property (nonatomic,strong)NSDictionary * parms;
//上次选中的索引 或控制器
@property (nonatomic,assign)NSInteger lastSelectedIndex;
@end
static NSString *const TopicCellIdentifier = @"topic";
static NSString *const BaseUrl = @"https://api.budejie.com/api/api_open.php";

@implementation TopicViewController
- (NSString *)type
{
    return nil;
}
#pragma mark -load lazy


#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化表格
    [self setupTableView];
    
    //刷新
    [self setupRefresh];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicsCell class]) bundle:nil] forCellReuseIdentifier:TopicCellIdentifier];
    
}

#pragma mark - custom action

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    //自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //一进入就刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

- (void)setupTableView
{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    //    CGFloat bottom = 49;
    CGFloat top = TitlesViewY + TitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;//取消分割线
    self.tableView.backgroundColor = [UIColor clearColor];
}
- (NSString *)a
{
    return [self.parentViewController isKindOfClass:[NewViewController class]] ? @"newlist" : @"list";
    
}

/**
 *  请求参数
 *
 *  @return 字典
 */
- (NSDictionary *)requstParamete
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = self.type;
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    return params;
}

/**
 *  刷新数据
 */
- (void)loadNewTopics
{
   
    self.parms  = [self requstParamete];;
   
    [HttpManager GetUrlString:BaseUrl WithParameters:self.parms success:^(id responseObject)
     {
         NSLog(@"responseObject = %@", responseObject);
        
         //存储maxtime
         self.maxtime = responseObject[@"info"][@"maxtime"];
         
         //字典转模型
         self.topics = [WordModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
         
         //刷新表格
         [self.tableView reloadData];
         
         //结束刷新
         [self.tableView.mj_header endRefreshing];
         //清空页码
         self.page = 0;
         
     } failure:^(NSError *error)
     {
         NSLog(@"error == %@", error);
         //结束刷新
         [self.tableView.mj_header endRefreshing];
     }];
    
   
}
- (void)loadMoreTopics
{
    self.page ++;
    
    [HttpManager GetUrlString:BaseUrl WithParameters:self.parms success:^(id responseObject)
     {
         NSLog(@"responseObject = %@", responseObject);
     } failure:^(NSError *error)
     {
         NSLog(@"error == %@", error);
     }];
    
    //结束刷新
    [self.tableView.mj_footer endRefreshing];
    
}
#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    NSLog(@"%ld", self.topics.count);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopicsCell *topicCell = [tableView dequeueReusableCellWithIdentifier:TopicCellIdentifier];
    topicCell.topic = self.topics[indexPath.row];
    return topicCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}
@end
