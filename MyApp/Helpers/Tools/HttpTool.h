//
//  HttpTool.h
//  MyApp
//
//  Created by DengTianran on 16/5/31.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ Success)(id responseObject);/**<成功回调*/
typedef void (^ Failure)(NSError *error);/**<失败回调*/

@interface HttpTool : NSObject
/**
 *  超时时间(默认20秒)
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 *  可接受的响应内容类型
 */
@property (nonatomic, copy) NSSet <NSString *> *acceptableContentTypes;

+ (HttpTool *)shareInstance;


- (void)GetUrlString:(NSString *)urlString WithParameters:(NSDictionary *)patameters success:(Success)success failure:(Failure)failure;



@end
