//
//  HttpTool.m
//  MyApp
//
//  Created by DengTianran on 16/5/31.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

static HttpTool *httpTool = nil;
@implementation HttpTool
+ (HttpTool *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpTool = [HttpTool new];
    });
    
    return httpTool;
}

- (void)GetUrlString:(NSString *)urlString WithParameters:(NSDictionary *)patameters success:(Success)success failure:(Failure)failure;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    [manager GET:urlString parameters:patameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success)
        {
            success(responseObject);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
        {
            failure(error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    }];

}
@end
