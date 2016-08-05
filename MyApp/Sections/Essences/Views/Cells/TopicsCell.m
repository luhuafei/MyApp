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
#import "PicView.h"
#import "TopicVoiceView.h"
#import "TopicVideo.h"
#import "Commend.h"
#import "User.h"
@interface TopicsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

//顶
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
//踩
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
//分享
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
//评论
@property (weak, nonatomic) IBOutlet UIButton *commentButton;



/**图片帖子中间的内容 */
@property (nonatomic,strong)PicView * pictureView;

/**声音帖子的内容 */
@property (nonatomic,strong)TopicVoiceView * voiceView;
/**视频帖子的内容 */
@property (nonatomic,strong)TopicVideo * videoView;
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
- (PicView *)pictureView
{
    if (!_pictureView) {
        PicView * pictureView = [PicView PicView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
- (TopicVoiceView *)voiceView
{
    if (!_voiceView) {
        TopicVoiceView * voiceView = [TopicVoiceView VoiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
- (TopicVideo *)videoView
{
    if (!_videoView) {
        TopicVideo * videoView = [TopicVideo videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)setTopic:(WordModel *)topic
{
    _topic = topic;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_topic.profile_image]];
    self.nameLabel.text = _topic.name;
    self.timeLabel.text = _topic.create_time;
    self.contentLabel.text = _topic.text;
    //设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    
    
    
    
    //根据帖子类型 添加对应的内容到cell中间
    if ([topic.type isEqualToString:@"10"]) {//图片帖子
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    }else if ([topic.type isEqualToString:@"31"]){//声音帖子
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
    }else if ([topic.type isEqualToString:@"41"]){//视频帖子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
    }else{
        //段子帖子
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    //处理最热评论
    if (_topic.count % 2)
    {
           self.commentView.hidden = NO;
//           self.commentLabel.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username,topic.top_cmt.content];
        self.commentLabel.text = [NSString stringWithFormat:@"qq:%@", _topic.commend];
    }else{
        self.commentView.hidden = YES;
   
    }
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = TopicCellMargin;
    frame.size.width -= 2 * TopicCellMargin;
    frame.size.height = self.topic.cellHeight - TopicCellMargin;
    frame.origin.y += TopicCellMargin;
    [super setFrame:frame];
}
//设置底部按钮文字
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString * )placeholder
{
    if (count>10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else{
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}
@end
