//
//  TopicsCell.m
//  MyApp
//
//  Created by DengTianran on 16/6/23.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "TopicsCell.h"
#import "WordModel.h"
#import "UIImageView+WebCache.h"

@interface TopicsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation TopicsCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor redColor];
    UIImageView * bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground_50x50_"];
    self.backgroundView =bgView;
}



+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTopic:(WordModel *)topic
{
    _topic = topic;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_topic.profile_image]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
