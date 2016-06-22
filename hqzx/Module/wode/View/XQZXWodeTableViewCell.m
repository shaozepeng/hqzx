//
//  JHWodeTableViewController.m
//  jht
//
//  Created by 邵泽鹏 on 15/7/8.
//  Copyright (c) 2015年 zthz. All rights reserved.
//
#define imgHeightOfWidth 0.8
#define img_marginTB 13
#import "XQZXWodeTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface XQZXWodeTableViewCell() {
    UIImageView *imageView;
    UIView *infoView;
    UILabel *lblTitle1;
    UILabel *lblTitle2;
    UILabel *tishi;
    UIImageView *shipimageView;
    UIImageView *ownerimageView;
    UIView *cell;
}
@end

@implementation XQZXWodeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.rowNum = -1;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = TableBgColor;
        cell = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, WOCELLHEIGHT)];
        cell.backgroundColor = UIColorFromRGB(0x0E151B);
        
//        UIImage *myIcon = [UIImage imageNamed:@"icon_th"];
        infoView = [[UIView alloc] initWithFrame: CGRectMake(COMMON_H_MARGIN, 5, cell.width - COMMON_H_MARGIN*2, cell.height*0.9 - 1)];
        [cell addSubview: infoView];
//        imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, myIcon.size.width*WOCELLPROPO, myIcon.size.width*WOCELLPROPO)];
//        [imageView setImage:myIcon];
//        imageView.layer.masksToBounds = YES;
//        imageView.layer.cornerRadius = imageView.width/2;
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        [infoView addSubview: imageView];
        
        lblTitle1 = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/30, cell.height/4, 1, 1)];
        lblTitle1.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
        [infoView addSubview: lblTitle1];
        lblTitle1.font = [UIFont systemFontOfSize: WOCELLFONT];
        lblTitle1.textColor = [UIColor whiteColor];
        [lblTitle1 sizeToFit];
        [infoView addSubview: lblTitle1];
        
        lblTitle2 = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/30, cell.height/2+8, 1, 1)];
        lblTitle2.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
        lblTitle2.textColor = [UIColor whiteColor];
        [infoView addSubview: lblTitle2];
        lblTitle2.font = [UIFont systemFontOfSize: WOCELLFONT];
        [lblTitle2 sizeToFit];
        
//        UILabel *tishilab = [[UILabel alloc] initWithFrame: CGRectMake(imageView.x, imageView.maxY+imageView.height/6, 1, 1)];
//        
//        tishilab.text = [NSString stringWithFormat:@"%@：",LocatizedStirngForkey(@"TUIGUANGLIANJIE")];
//        tishilab.textColor = [UIColor whiteColor];
//        [infoView addSubview: tishilab];
//        tishilab.font = [UIFont systemFontOfSize: WOCELLFONT];
//        [tishilab sizeToFit];
        
        tishi = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/30, cell.height/2+16, 1, 1)];
        tishi.text = LocatizedStirngForkey(@"JIAZAIZHONGQ");
        tishi.textColor = UIColorFromRGB(0x244E8E);
        [infoView addSubview: tishi];
        tishi.font = [UIFont systemFontOfSize: WOCELLFONT];
        [tishi sizeToFit];

        [infoView addSubview: lblTitle2];
        
        [cell addSubview:infoView];
        [self addSubview: cell];
    }
    return self;
}
- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    if ([imageUrl startsWith:@"http:"] || [imageUrl startsWith:@"https:"]) {
        [imageView sd_setImageWithURL: [NSURL URLWithString:imageUrl]];
    } else {
        [imageView setImage:[UIImage imageNamed:imageUrl]];
    }
   
}

- (void)setTitle1:(NSString *)value {
    _title1 = value;
    lblTitle1.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"DELUMING"),_title1];
    [lblTitle1 sizeToFit];
    [lblTitle1 setX: SCREEN_WIDTH/30];
    [lblTitle1 setY:cell.height/15];
}
-(void)setChuanname:(NSString *)value{
    _chuanname = value;
}
-(void)setChuanstatus:(NSString *)value{
    _chuanstatus = value;
    UIImage *shipimg=[UIImage imageNamed:@""];
    [shipimageView setImage:shipimg];
    if([_chuanstatus isEqualToString:@"2"]==YES){
        UIImage *shipimg=[UIImage imageNamed:@"shipwode"];
        [shipimageView setImage:shipimg];
    }
}
- (void)setTitle2:(NSString *)value {
    _title2 = value;
    lblTitle2.text = [NSString stringWithFormat:@"%@：%@",LocatizedStirngForkey(@"NICHENG"),_title2];
    [lblTitle2 sizeToFit];
    [lblTitle2 setX: SCREEN_WIDTH/30];
    [lblTitle2 setY:lblTitle1.maxY+cell.height/15];
}
- (void)setState:(NSString *)value {
    _state = value;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:_state];
        [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WOCELLFONT] range:NSMakeRange(0, 4)];
        [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WOCELLFONT] range:NSMakeRange(4, _state.length-4)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 4)];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x439AFE) range:NSMakeRange(4, _state.length-4)];
    tishi.attributedText = attributedStr;
    [tishi sizeToFit];
    [tishi setX: SCREEN_WIDTH/30];
    [tishi setY:lblTitle2.maxY+cell.height/15];
}
- (void)awakeFromNib {
}

-(IBAction)cellToubiao:(id)sender {
    if (_delegate && [_delegate respondsToSelector: @selector(toubiao:)]) {
        [_delegate toubiao: self.rowNum];
    }
}
-(IBAction)cellXiangqing:(id)sender {
    if (_delegate && [_delegate respondsToSelector: @selector(xiangqing:)]) {
        [_delegate xiangqing: self.rowNum];
    }
}

-(IBAction)cellJishilianxi:(id)sender {
    if (_delegate && [_delegate respondsToSelector: @selector(jishilianxi:)]) {
        [_delegate jishilianxi: self.rowNum];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
