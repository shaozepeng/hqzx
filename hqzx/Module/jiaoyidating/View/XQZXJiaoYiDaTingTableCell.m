//
//  XQZXJiaoYiDaTingTableCell.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/23.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#define imgHeightOfWidth 0.8
#define img_marginTB 8
#import "XQZXJiaoYiDaTingTableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface XQZXJiaoYiDaTingTableCell() {
    UIImageView *imageView;
    UIView *infoView;
    UILabel *lblTitle1;
    UILabel *lblTitle2;
    UILabel *lblTitle3;
    UILabel *lblTitle4;
    UILabel *lblTitle5;
    UILabel *lblZhuangzaigang;
    UILabel *lblXiezaigang;
    UILabel *lblKaibiaohaisheng;
    UIImageView *statusImg;
    UIImage *imageStatus;
    UILabel *lbltoubiaozhuangtai;
    UIImage *serviceimg;
    UIButton *btnContact;
    UIButton *btnContactText;
    
    UILabel *lblTitle31;
    UILabel *lblTitle21;
    UILabel *lblTitle51;
    UILabel *lblZhuangzaigang1;
    UIView *toolView;
}
@end

@implementation XQZXJiaoYiDaTingTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.rowNum = -1;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = TableBgColor;
        UIView *cell = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, FIRSTHEIGHTONE)];
        cell.backgroundColor = UIColorFromRGB(0x0D161C);
        
        infoView = [[UIView alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, 0, cell.width - COMMON_H_MARGIN*2, cell.height*0.45 - 2)];
        [cell addSubview: infoView];
        
        UIImage *biIcon = [UIImage imageNamed:@"icon_bibi_1"];
        imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, img_marginTB, biIcon.size.width*FIRSTHEIGHTTWO, biIcon.size.height*FIRSTHEIGHTTWO)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = biIcon;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 1;
        [infoView addSubview: imageView];
        
        lblTitle1 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle1.text = @"加载中...";
        [infoView addSubview: lblTitle1];
        lblTitle1.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        lblTitle1.textColor = UIColorFromRGB(0xFBFFFF);
        [lblTitle1 sizeToFit];
        [lblTitle1 setX:imageView.maxX + SCREEN_WIDTH/50];
        [lblTitle1 setY:imageView.y+(imageView.height-lblTitle1.height)/2];
        
        lblTitle4 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle4.text = @"加载中...";
        [infoView addSubview: lblTitle4];
        lblTitle4.font = [UIFont boldSystemFontOfSize: FIRSTFONTTWO];
        lblTitle4.textColor = [UIColor whiteColor];
        [lblTitle4 sizeToFit];
        [lblTitle4 setX:SCREEN_WIDTH*0.55];
        [lblTitle4 setY:lblTitle1.y];
        
        btnContactText = [[UIButton alloc] init];
        [btnContactText setTitle: @"加载中..." forState: UIControlStateNormal];
        btnContactText.titleLabel.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        btnContactText.titleLabel.textColor = [UIColor whiteColor];
        [btnContactText setBackgroundColor:[UIColor redColor]];
        [btnContactText sizeToFit];
        [btnContactText setX:lblTitle4.maxX+SCREEN_WIDTH/20];
        [btnContactText setY:imageView.y];
        [btnContactText setW:SCREEN_WIDTH-lblTitle4.maxX-SCREEN_WIDTH/10];
        [btnContactText setH:imageView.height];
        
        [btnContactText setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [infoView addSubview: btnContactText];
        
        UIView *line = [[UIView alloc] initWithFrame: CGRectMake(COMMON_H_MARGIN, infoView.maxY, cell.width , 1)];
        [line setBackgroundColor:UIColorFromRGB(0x141A21)];
        [cell addSubview: line];
        
        UIView *linetwo = [[UIView alloc] initWithFrame: CGRectMake(COMMON_H_MARGIN, line.maxY, cell.width, 1)];
        [linetwo setBackgroundColor:UIColorFromRGB(0x0B1219)];
        [cell addSubview: linetwo];
        
        toolView = [[UIView alloc] initWithFrame: CGRectMake(COMMON_H_MARGIN, linetwo.maxY, cell.width, cell.height - linetwo.maxY)];
        [cell addSubview:toolView];
        //        #7D8285
        lblTitle31 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle31.text = LocatizedStirngForkey(@"CHENGJIAOE");
        [toolView addSubview: lblTitle31];
        lblTitle31.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
        lblTitle31.textColor = UIColorFromRGB(0x7D8285);
        [lblTitle31 sizeToFit];
        [lblTitle31 setX:imageView.x+imageView.width/IMAGELEFT];
        [lblTitle31 setY:toolView.height/5];
        
        lblTitle3 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle3.text = @"加载中...";
        lblTitle3.textColor = UIColorFromRGB(0x7D8285);
        [toolView addSubview: lblTitle3];
        lblTitle3.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
        [lblTitle3 sizeToFit];
        [lblTitle3 setX:lblTitle31.x];
        [lblTitle3 setY:lblTitle31.maxY+toolView.height/10];
        
        lblTitle21 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle21.text = LocatizedStirngForkey(@"CHENGJIAOLIANG");
        lblTitle21.textColor = UIColorFromRGB(0x7D8285);
        lblTitle21.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
        [toolView addSubview: lblTitle21];
        [lblTitle21 sizeToFit];
        [lblTitle21 setX:SCREEN_WIDTH*0.3];
        [lblTitle21 setY:toolView.height/5];
        
        lblTitle2 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle2.text = @"加载中...";
        lblTitle2.textColor = UIColorFromRGB(0x7D8285);
        lblTitle2.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
        [toolView addSubview: lblTitle2];
        [lblTitle2 sizeToFit];
        [lblTitle2 setX:SCREEN_WIDTH*0.3];
        [lblTitle2 setY:lblTitle21.maxY+toolView.height/10];
        
        lblTitle51 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle51.text = LocatizedStirngForkey(@"ZUIDIJIA");
        lblTitle51.textColor = UIColorFromRGB(0x7D8285);
        lblTitle51.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
        [toolView addSubview: lblTitle51];
        [lblTitle51 sizeToFit];
        [lblTitle51 setX:SCREEN_WIDTH*IMAGELEFTTWO];
        [lblTitle51 setY:toolView.height/5];
        
        lblTitle5 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle5.text = @"加载中...";
        lblTitle5.textColor = UIColorFromRGB(0x7D8285);
        lblTitle5.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
        [toolView addSubview: lblTitle5];
        [lblTitle5 sizeToFit];
        [lblTitle5 setX:SCREEN_WIDTH*0.5];
        [lblTitle5 setY:lblTitle51.maxY+toolView.height/10];
        
        lblZhuangzaigang1 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblZhuangzaigang1.text = LocatizedStirngForkey(@"ZUIGAOJIA");
        lblZhuangzaigang1.textColor = UIColorFromRGB(0x7D8285);
        lblZhuangzaigang1.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
        [toolView addSubview: lblZhuangzaigang1];
        [lblZhuangzaigang1 sizeToFit];
        [lblZhuangzaigang1 setX:SCREEN_WIDTH*IMAGELEFTTHREE];
        [lblZhuangzaigang1 setY:toolView.height/5];
        
        lblZhuangzaigang = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblZhuangzaigang.text = @"加载中...";
        lblZhuangzaigang.font = [UIFont systemFontOfSize: FIRSTFONTTHREE];
        lblZhuangzaigang.textColor = UIColorFromRGB(0x7D8285);
        [toolView addSubview: lblZhuangzaigang];
        [lblZhuangzaigang sizeToFit];
        [lblZhuangzaigang setX:SCREEN_WIDTH*0.75];
        [lblZhuangzaigang setY:lblZhuangzaigang1.maxY+toolView.height/10];
        
        [self addSubview: cell];
    }
    return self;
}
- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [imageView sd_setImageWithURL: [NSURL URLWithString: imageUrl]];
}

- (void)setTitle1:(NSString *)value {
    _title1 = NilToEmpty(value);
    lblTitle1.text = _title1;
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"比特币(BTC)", FIRSTFONTONE);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(_title1, FIRSTFONTONE);
    [lblTitle1 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle1 sizeToFit];
    if(textSize2.width>textSize.width){
        [lblTitle1 setW:textSize.width];
        [lblTitle1 setH:textSize.height];
    }else{
        [lblTitle1 setW:lblTitle1.width];
        [lblTitle1 setH:lblTitle1.height];
    }
    [lblTitle1 setX:imageView.maxX + SCREEN_WIDTH/50];
    [lblTitle1 setY:imageView.y+(imageView.height-lblTitle1.height)/2];
}
- (void)setTitle3:(NSString *)value {
    _title3 = NilToEmpty(value);
    lblTitle4.text = _title3;
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"￥0.888", FIRSTFONTTWO);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(_title3, FIRSTFONTTWO);
    [lblTitle4 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle4 sizeToFit];
    if(textSize2.width>textSize.width){
        [lblTitle4 setW:textSize.width];
        [lblTitle4 setH:textSize.height];
    }else{
        [lblTitle4 setW:lblTitle4.width];
        [lblTitle4 setH:lblTitle4.height];
    }
    [lblTitle4 setX:SCREEN_WIDTH*0.55];
    [lblTitle4 setY:lblTitle1.y];
    
    [btnContactText setX:lblTitle4.maxX+SCREEN_WIDTH/20];
    [btnContactText setY:imageView.y];
    [btnContactText setW:SCREEN_WIDTH-lblTitle4.maxX-SCREEN_WIDTH/10];
    [btnContactText setH:imageView.height];
}
- (void)setTitle2:(NSString *)value {
    _title2 = NilToEmpty(value);
    [btnContactText setTitle: _title2 forState: UIControlStateNormal];
    //    btnContactText.titleLabel.text = _title2;
    //    [btnContactText sizeToFit];
}

-(void)setToubiaozhuangtai:(NSString *)value{
    _toubiaozhuangtai = NilToEmpty(value);
    lblTitle3.text=_toubiaozhuangtai;
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"1888.88万", FIRSTFONTTHREE);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(_toubiaozhuangtai, FIRSTFONTTHREE);
    [lblTitle3 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle3 sizeToFit];
    if(textSize2.width>textSize.width){
        [lblTitle3 setW:textSize.width];
        [lblTitle3 setH:textSize.height];
    }else{
        [lblTitle3 setW:lblTitle3.width];
        [lblTitle3 setH:lblTitle3.height];
    }
    [lblTitle3 setX:lblTitle31.x];
    [lblTitle3 setY:lblTitle31.maxY+toolView.height/10];
}
-(void)setKaibiaohaisheng:(NSString *)value {
    _kaibiaohaisheng = NilToEmpty(value);
    lblTitle2.text=_kaibiaohaisheng;
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"9999万", FIRSTFONTTHREE);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(_kaibiaohaisheng, FIRSTFONTTHREE);
    [lblTitle2 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle2 sizeToFit];
    if(textSize2.width>textSize.width){
        [lblTitle2 setW:textSize.width];
        [lblTitle2 setH:textSize.height];
    }else{
        [lblTitle2 setW:lblTitle2.width];
        [lblTitle2 setH:lblTitle2.height];
    }
    [lblTitle2 setX:lblTitle21.x];
    [lblTitle2 setY:lblTitle21.maxY+toolView.height/10];
}
- (void)setToubiaoshu:(NSString *)value {
    _toubiaoshu = NilToEmpty(value);
    lblTitle5.text=_toubiaoshu;
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"￥0.666", FIRSTFONTTHREE);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(_toubiaoshu, FIRSTFONTTHREE);
    [lblTitle5 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle5 sizeToFit];
    if(textSize2.width>textSize.width){
        [lblTitle5 setW:textSize.width];
        [lblTitle5 setH:textSize.height];
    }else{
        [lblTitle5 setW:lblTitle5.width];
        [lblTitle5 setH:lblTitle5.height];
    }
    [lblTitle5 setX:lblTitle51.x];
    [lblTitle5 setY:lblTitle51.maxY+toolView.height/10];
}

- (void) setZhuangzaigang:(NSString *)value {
    _zhuangzaigang = NilToEmpty(value);
    lblZhuangzaigang.text=_zhuangzaigang;
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"￥0.666", FIRSTFONTTHREE);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(_zhuangzaigang, FIRSTFONTTHREE);
    [lblZhuangzaigang setAdjustsFontSizeToFitWidth:YES];
    [lblZhuangzaigang sizeToFit];
    if(textSize2.width>textSize.width){
        [lblZhuangzaigang setW:textSize.width];
        [lblZhuangzaigang setH:textSize.height];
    }else{
        [lblZhuangzaigang setW:lblZhuangzaigang.width];
        [lblZhuangzaigang setH:lblZhuangzaigang.height];
    }
    [lblZhuangzaigang setX:lblZhuangzaigang1.x];
    [lblZhuangzaigang setY:lblZhuangzaigang1.maxY+toolView.height/10];
}

- (void)awakeFromNib {
}

-(IBAction)cellXiangqing:(id)sender {
    WEAK_SELF
    if (weakself.wocanyudehuopanxiangqingBlock) {
        weakself.wocanyudehuopanxiangqingBlock();
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
