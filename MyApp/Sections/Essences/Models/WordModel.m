//
//  WordModel.h
//  MyApp
//
//  Created by DengTianran on 16/5/27.
//  Copyright © 2016年 DengTianran. All rights reserved.
//

#import "WordModel.h"
#import <MJExtension.h>
#import "User.h"
#import "Commend.h"
@implementation WordModel
//.h中设置了readonly 因此这边要设置
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"top_cmt":@"top_cmt[0]",
             @"ctime" :@"top_cmt[0]"};
}
- (NSString *)create_time
{
    //日期格式化类
    //NSString ->> NSDate
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //帖子创建时间
    NSDate * create = [fmt dateFromString:_create_time];
    if (create.isThisYear) {//今年
        
        if (create.isToday) {//今天
            NSDateComponents * cmps = [[NSDate date]deltaFrom:create];
            
            if (cmps.hour>= 1) {//时间差距 >= 1小时
                return  [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){ //1小时 > 时间差距 >= 1分钟
                return  [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{//一分钟 > 时间差距
                return @"刚刚";
            }
        }else if (create.isYesterday){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
           return   [fmt stringFromDate:create];
        }else{//其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }else{//非今年
        return _create_time;
    }
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt":@"Commend"};
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _top_cmt];
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
    
    //文字的Y值
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 *TopicCellMargin, MAXFLOAT);
    //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        //计算文字高度
    CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    //文字部分高度
    _cellHeight = TopicCellTextY + textH  +  TopicCellMargin ;
        //根据段子的类型计算cell的高度
        if ([self.type isEqualToString:@"10"])
        {//图片
           //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= TopicCellPicMaxH) {//图片高度过长
                pictureH = TopicCellPicBreakH;
                self.bigImage = YES;
            }
            //        计算图片的fame
            CGFloat pictureX = TopicCellMargin;
            CGFloat pictureY = TopicCellTextY + textH + TopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + TopicCellMargin;
        }else if ([self.type isEqualToString:@"31"])//声音帖子
        {
            CGFloat voiceX = TopicCellMargin;
            CGFloat voiceY = TopicCellTextY + textH + TopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW,voiceH);
            _cellHeight += voiceH + TopicCellMargin;
        //底部工具条高度
        _cellHeight += TopicCellBottomBarH + TopicCellMargin;
         }else if ([self.type isEqualToString:@"41"])//视频帖子
         {
             CGFloat videoX = TopicCellMargin;
             CGFloat videoY = TopicCellTextY + textH + TopicCellMargin;
             CGFloat videoW = maxSize.width;
             CGFloat videoH = videoW * self.height / self.width;;
             _videoF = CGRectMake(videoX, videoY, videoW,videoH);
             _cellHeight += videoH + TopicCellMargin;
             
         }
//        Commend * cmt = [self.top_cmt firstObject];
        NSInteger count = arc4random() % 100;
        self.count = count;
        if (count % 2) {
//            NSString * content = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
             CGFloat contentH = [self.commend boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += TopicCellTopCmtTitleH + TopicCellMargin  + contentH ;
        }
        //底部工具条高度
        _cellHeight += TopicCellBottomBarH + TopicCellMargin;
 }
    return _cellHeight;

}


- (NSString *)commend
{
    if (_commend == nil)
    {
        NSInteger count = arc4random() % self.commentArray.count;
        self.commend = self.commentArray[count];
    }
    return  _commend;
    
}

- (NSArray *)commentArray
{
    if (_commentArray == nil)
    {
        self.commentArray = @[@"是大大发发发asdfghjyukuigsdhffjkshjdkul有时候我们需要在程序中生成随机数，但是在Objective-c中并没有提供相应的函数，好在C中提供了", @"奥法弗有时候我们需要在程序中生成随机数，但是在Objective-c中并没有提供相应的函数，好在C中提供了拉明才;啊苏东坡老婆全武器都欺负欺负欺负哭几天清风过热或突然有距离后", @"撒有时候我们需要在程序中生成随机数，但是在Objective-c中并没有提供相应的函数，好在C中提供了娇高考;温热突然有脱皮老板vcvcl马兰拉面;老杜v'pqkogjqrglff有时候我们需要在程序中生成随机数，但是在Objective-c中并没有提供相应的函数，好在C中提供了q'gewjkqgewk", @"扫减肥有时候我们需要在程序中生成随机数，但是在Objective-c中并没有提供相应的函数，好在C中提供了快赔钱哦高科技和我去过陪我看物流区分开法规和人员同拘役;头突然放大;婆婆以具有和托管费 ;;如同归于好几口", @"哦啊看看有时候我们需要在程序中生成随机数，但是在Objective-c中并没有提供相应的函数，好在C中提供了书来打牌不麻烦;,ska啪啪啪", @"安分开始的的人防图关于加快了;.干活那有时候我们需要在程序中生成随机数，但是在Objective-c中并没有提供相应的函数，好在C中提供了;发个混迹没看了;合计;'弩机没空了;回家考虑"];
    }
    return _commentArray;
    
}

@end
