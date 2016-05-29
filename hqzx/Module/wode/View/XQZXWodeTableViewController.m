//
//  JHWodeTableViewController.m
//  jht
//
//  Created by 邵泽鹏 on 15/7/8.
//  Copyright (c) 2015年 zthz. All rights reserved.
//
#define imgHeightOfWidth 0.8
#define img_marginTB 13
#import "JHTWodeTableViewController.h"
#import "NSString+NSStringForJava.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface JHTWodeTableViewController() {
    UIImageView *imageView;
    UIView *infoView;
    UILabel *lblTitle1;
    UILabel *lblTitle2;
    UILabel *tishi;
    UIImageView *shipimageView;
    UIImageView *ownerimageView;
}
@end

@implementation JHTWodeTableViewController
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.rowNum = -1;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = TableBgColor;
        UIView *cell = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        cell.backgroundColor = [UIColor whiteColor];
        
        infoView = [[UIView alloc] initWithFrame: CGRectMake(COMMON_H_MARGIN+10, 0, cell.width - COMMON_H_MARGIN*2, cell.height*0.9 - 1)];
        [cell addSubview: infoView];
        float imgHeight = infoView.height - img_marginTB*2;
        imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 10, imgHeight/imgHeightOfWidth, imgHeight/imgHeightOfWidth)];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = imageView.width/2;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [infoView addSubview: imageView];
        
        lblTitle1 = [[UILabel alloc] initWithFrame: CGRectMake(imageView.maxX, cell.height/4+5, 1, 1)];
        lblTitle1.text = @" ";
        [infoView addSubview: lblTitle1];
        lblTitle1.font = [UIFont systemFontOfSize: 18];
        lblTitle1.textColor = UIColorFromRGB(0x262626);
        [lblTitle1 sizeToFit];
        [infoView addSubview: lblTitle1];
        
        ownerimageView = [[UIImageView alloc] initWithFrame: CGRectMake(lblTitle1.maxX, cell.height/4+3, 25, 25)];
        ownerimageView.layer.masksToBounds = YES;
        ownerimageView.layer.cornerRadius = 1;
        
        shipimageView = [[UIImageView alloc] initWithFrame: CGRectMake(ownerimageView.maxX, cell.height/4+3, 25, 25)];
        shipimageView.layer.masksToBounds = YES;
        shipimageView.layer.cornerRadius = 1;
        [infoView addSubview: shipimageView];
        
        
        
        [infoView addSubview: ownerimageView];
        
        lblTitle2 = [[UILabel alloc] initWithFrame: CGRectMake(imageView.maxX, cell.height/2+13, 1, 1)];
        lblTitle2.text = @" ";
        lblTitle2.textColor = UIColorFromRGB(0x6E6E6E);
        [infoView addSubview: lblTitle2];
        lblTitle2.font = [UIFont systemFontOfSize: 16];
        [lblTitle2 sizeToFit];
        
        tishi = [[UILabel alloc] initWithFrame: CGRectMake(imageView.maxX+10, cell.height/2.7, 1, 1)];
        tishi.text = @" ";
        tishi.textColor = UIColorFromRGB(0x6E6E6E);
        [infoView addSubview: tishi];
        tishi.font = [UIFont systemFontOfSize: 22];
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
    lblTitle1.text = value;
    [lblTitle1 sizeToFit];
    [lblTitle1 setX: imageView.maxX + 15];
    [ownerimageView setX:lblTitle1.maxX+5];
    [shipimageView setX:ownerimageView.maxX+5];
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
}
- (void)setState:(NSString *)value {
    _state = value;
    if([_state isEqualToString:@"1"]==YES || [_state isEqualToString:@"2"]==YES || [_state isEqualToString:@"3"]==YES){
        tishi.text=@"";
        [tishi sizeToFit];
        
        lblTitle2.text=_title2;
        [lblTitle2 sizeToFit];
        [lblTitle2 setX: imageView.maxX + 15];
        [lblTitle2 setW:lblTitle2.width];
        [lblTitle2 setH:lblTitle2.height];
        UIImage *ownerimg=[UIImage imageNamed:@""];
        [ownerimageView setImage:ownerimg];
        if([_state isEqualToString:@"1"]==YES){
            [lblTitle2 setTextColor:UIColorFromRGB(0xFFA500)];
        }
        if([_state isEqualToString:@"2"]==YES){
            [lblTitle2 setTextColor:UIColorFromRGB(0x3AC842)];
            UIImage *ownerimg=[UIImage imageNamed:@"wonerwode"];
            [ownerimageView setImage:ownerimg];
        }
        if([_state isEqualToString:@"3"]==YES){
            [lblTitle2 setTextColor:[UIColor redColor]];
        }
    }
    if([_state isEqualToString:@"0"]==YES){
        lblTitle1.text=@"";
        [lblTitle1 sizeToFit];
        lblTitle2.text=@"";
        [lblTitle2 sizeToFit];
        UIImage *ownerimg=[UIImage imageNamed:@""];
        [ownerimageView setImage:ownerimg];
        
        tishi.text=@"请进行实名认证！";
        [tishi sizeToFit];
        [tishi setW:tishi.width];
        [tishi setH:tishi.height];
    }
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
