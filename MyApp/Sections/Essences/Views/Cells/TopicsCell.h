//
//  TopicsCell.h
//  MyApp
//
//  Created by DengTianran on 16/6/23.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WordModel;
@interface TopicsCell : UITableViewCell

@property (strong, nonatomic)WordModel *topic;

+ (instancetype)cell;

@end
