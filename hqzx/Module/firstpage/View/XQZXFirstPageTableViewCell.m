//
//  JHWoCanYuDeHuoPanTableViewCell.m
//  jht
//
//  Created by 泽鹏邵 on 15/7/23.
//  Copyright (c) 2015年 zthz. All rights reserved.
//


#define imgHeightOfWidth 0.8
#define img_marginTB 13
#import "JHTWoCanYuDeTouBiaoTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface JHTWoCanYuDeTouBiaoTableViewCell() {
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
}
@end
@implementation JHTWoCanYuDeTouBiaoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.rowNum = -1;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = TableBgColor;
        UIView *cell = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, WodehuojiaCellHeight)];
        cell.backgroundColor = [UIColor whiteColor];
        
        infoView = [[UIView alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/40, 0, cell.width - COMMON_H_MARGIN*2, cell.height*0.67 - 1)];
        [cell addSubview: infoView];
        float imgHeight = infoView.height - img_marginTB*2;
        imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, img_marginTB, SCREEN_WIDTH/4.5, imgHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 1;
        [infoView addSubview: imageView];
        
        lblTitle1 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle1.text = @"";
        [infoView addSubview: lblTitle1];
        lblTitle1.font = [UIFont boldSystemFontOfSize: WodehuojiaFont1];
        [lblTitle1 sizeToFit];
        [lblTitle1 setW:lblTitle1.width];
        [lblTitle1 setH:lblTitle1.height];
        [lblTitle1 setX:imageView.maxX + SCREEN_WIDTH/50];
        [lblTitle1 setY:imageView.y];
        
        lblTitle4 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle4.text = @"-";
        [infoView addSubview: lblTitle4];
        lblTitle4.font = [UIFont boldSystemFontOfSize: WodehuojiaFont1];
        [lblTitle4 sizeToFit];
        [lblTitle4 setW:lblTitle4.width];
        [lblTitle4 setH:lblTitle1.height];
        [lblTitle4 setX:lblTitle1.maxX+SCREEN_WIDTH/80];
        [lblTitle4 setY:imageView.y];
        
        lblTitle3 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle3.text = @"";
        [infoView addSubview: lblTitle3];
        lblTitle3.font = [UIFont boldSystemFontOfSize: WodehuojiaFont1];
        [lblTitle3 sizeToFit];
        [lblTitle3 setW:lblTitle3.width];
        [lblTitle3 setH:lblTitle3.height];
        [lblTitle3 setX:lblTitle4.maxX];
        [lblTitle3 setY:imageView.y];
        
        lblTitle2 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle2.text = @" ";
        lblTitle2.textColor = COL_2B;
        lblTitle2.font = [UIFont systemFontOfSize: WodehuojiaFont2];
        [infoView addSubview: lblTitle2];
        [lblTitle2 sizeToFit];
        
        lblTitle5 = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblTitle5.text = @" ";
        lblTitle5.textColor = UIColorFromRGB(0xFC5300);
        lblTitle5.font = [UIFont systemFontOfSize: WodehuojiaFont2];
        [infoView addSubview: lblTitle5];
        [lblTitle5 sizeToFit];
        
        lblZhuangzaigang = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblZhuangzaigang.text = @" ";
        lblZhuangzaigang.font = [UIFont systemFontOfSize: WodehuojiaFont2];
        lblZhuangzaigang.textColor = COL_2B;
        [infoView addSubview: lblZhuangzaigang];
        [lblZhuangzaigang sizeToFit];
        
        serviceimg=[UIImage imageNamed:@"quotedpriceone"];
        statusImg=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.86, infoView.height*0.6, serviceimg.size.width, serviceimg.size.height)];
        [statusImg setImage:serviceimg];
        [infoView addSubview:statusImg];
        
        lblXiezaigang = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH*0.86, statusImg.maxY, 1, 1)];
        lblXiezaigang.text = @"报价中";
        lblXiezaigang.font = [UIFont systemFontOfSize: 9];
        lblXiezaigang.textColor = UIColorFromRGB(0x24ACEB);
        [infoView addSubview: lblXiezaigang];
        [lblXiezaigang sizeToFit];
        
        lbltoubiaozhuangtai = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lbltoubiaozhuangtai.text = @" ";
        lbltoubiaozhuangtai.font = [UIFont systemFontOfSize: WodehuojiaFont3];
        lbltoubiaozhuangtai.textColor = COL_2B;
        [infoView addSubview: lbltoubiaozhuangtai];
        
        
        lblKaibiaohaisheng = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        lblKaibiaohaisheng.text = @" ";
        lblKaibiaohaisheng.font = [UIFont systemFontOfSize: WodehuojiaFont3];
        lblKaibiaohaisheng.textColor = COL_2B;
        [infoView addSubview:lblKaibiaohaisheng];
        [lblKaibiaohaisheng sizeToFit];
        
        
        [infoView addSubview: lblTitle3];
        
        UIView *line = [[UIView alloc] initWithFrame: CGRectMake(COMMON_H_MARGIN, infoView.maxY, cell.width - COMMON_H_MARGIN*2, 1)];
        [line setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line"]]];
        [cell addSubview: line];
        UIView *toolView = [[UIView alloc] initWithFrame: CGRectMake(COMMON_H_MARGIN, line.maxY, cell.width - COMMON_H_MARGIN*2, cell.height - line.maxY)];
        [cell addSubview:toolView];
        
        UIImage *image = [UIImage imageNamed:@"number"];
        btnContact = [[UIButton alloc] initWithFrame: CGRectMake(COMMON_H_MARGIN/2, (toolView.height - image.size.height) / 2, image.size.width, image.size.height)];
        [btnContact setImage: image forState: UIControlStateNormal];
        [toolView addSubview:btnContact];
        
        btnContactText = [[UIButton alloc] init];
        [btnContactText setTitle: @"" forState: UIControlStateNormal];
        btnContactText.titleLabel.font = [UIFont systemFontOfSize: WodehuojiaFont3];
        [btnContactText sizeToFit];
        [btnContactText setFrame:CGRectMake(btnContact.maxX + 3, btnContact.y, SCREEN_WIDTH/15, btnContact.height)];
        
        [btnContactText setTitleColor: COL_TEXT_GRAY3 forState: UIControlStateNormal];
        [toolView addSubview: btnContactText];
        
        
        float btnMarginBT = 5.5;
        float btnHeight = toolView.height - btnMarginBT*2;
        float btnWidth = btnHeight * 1.2;
        
        
        UIImage *btnBgWhrite = [[UIImage imageNamed:@"btn_whrite"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        UIButton *btnXiangqing = [[UIButton alloc] initWithFrame: CGRectMake(toolView.width*0.74, btnMarginBT, btnWidth*2, btnHeight)];
        [btnXiangqing setTitle: @"报价详情" forState: UIControlStateNormal];
        [btnXiangqing setBackgroundImage:btnBgWhrite forState: UIControlStateNormal];
        [btnXiangqing setTitleColor: UIColorFromRGB(0x2A9A63) forState: UIControlStateNormal];
        btnXiangqing.titleLabel.font = [UIFont systemFontOfSize: 14];
        [btnXiangqing addTarget:self action: @selector(cellXiangqing:) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:btnXiangqing];
  
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
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"乌鲁木", WodehuojiaFont1);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(_title1, WodehuojiaFont1);
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
    [lblTitle1 setY:imageView.y];
    
    [lblTitle4 sizeToFit];
    [lblTitle4 setW:lblTitle4.width];
    [lblTitle4 setH:lblTitle4.height];
    [lblTitle4 setX:lblTitle1.maxX+SCREEN_WIDTH/100];
    [lblTitle4 setY:imageView.y];
}
- (void)setTitle3:(NSString *)value {
    _title3 = NilToEmpty(value);
    lblTitle3.text = _title3;
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"乌鲁木", WodehuojiaFont1);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(_title3, WodehuojiaFont1);
    [lblTitle3 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle3 sizeToFit];
    if(textSize2.width>textSize.width){
        [lblTitle3 setW:textSize.width];
        [lblTitle3 setH:textSize.height];
    }else{
        [lblTitle3 setW:lblTitle3.width];
        [lblTitle3 setH:lblTitle3.height];
    }
    [lblTitle3 setX:lblTitle4.maxX+SCREEN_WIDTH/100];
    [lblTitle3 setY:imageView.y];
}
- (void)setTitle2:(NSString *)value {
    _title2 = NilToEmpty(value);
    NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc]initWithString:_title2];
    if (_title2.length > 0) {
        [attributedStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WodehuojiaFont1] range:NSMakeRange(0, _title2.length-1)];
        [attributedStr2 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xFC5300) range:NSMakeRange(0, _title2.length-1)];
    }
    lblTitle2.attributedText=attributedStr2;
    
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"乌鲁木齐", WodehuojiaFont2);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(_title2, WodehuojiaFont2);
    [lblTitle2 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle2 sizeToFit];
    if(textSize2.width>textSize.width){
        [lblTitle2 setW:textSize.width];
        [lblTitle2 setH:textSize.height];
    }else{
        [lblTitle2 setW:lblTitle2.width];
        [lblTitle2 setH:lblTitle2.height];
    }
    [lblTitle2 setX:lblTitle3.maxX + SCREEN_WIDTH/45];
    [lblTitle2 setY:lblTitle3.y];
}
- (void)setToubiaoshu:(NSString *)value {
    _toubiaoshu = NilToEmpty(value);
    lblTitle5.text=_toubiaoshu;
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"西伯利亚大港", WodehuojiaFont2);
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(_toubiaoshu, WodehuojiaFont2);
    [lblTitle5 setAdjustsFontSizeToFitWidth:YES];
    [lblTitle5 sizeToFit];
    if(textSize2.width>textSize.width){
        [lblTitle5 setW:textSize.width];
        [lblTitle5 setH:textSize.height];
    }else{
        [lblTitle5 setW:lblTitle5.width];
        [lblTitle5 setH:lblTitle5.height];
    }
    [lblTitle5 setX:lblTitle2.maxX + SCREEN_WIDTH/45];
    [lblTitle5 setY:lblTitle3.y];
}

- (void) setZhuangzaigang:(NSString *)value {
    _zhuangzaigang = NilToEmpty(value);
    NSMutableAttributedString *attributedStr4 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"受载日期：%@", _zhuangzaigang]];
    if(_zhuangzaigang.length>0){
        [attributedStr4 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WodehuojiaFont2] range:NSMakeRange(attributedStr4.length-_zhuangzaigang.length,_zhuangzaigang.length-1)];
        [attributedStr4 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x56AD5F) range:NSMakeRange(attributedStr4.length-_zhuangzaigang.length,_zhuangzaigang.length-1)];
    }
    lblZhuangzaigang.attributedText = attributedStr4;
    [lblZhuangzaigang sizeToFit];
    [lblZhuangzaigang setH:lblZhuangzaigang.height];
    [lblZhuangzaigang setW: lblZhuangzaigang.width];
    [lblZhuangzaigang setY: lblTitle4.maxY+infoView.height/15];
    [lblZhuangzaigang setX:imageView.maxX + SCREEN_WIDTH/50];
}
-(void)setToubiaozhuangtai:(NSString *)value{
    _toubiaozhuangtai = NilToEmpty(value);
    NSMutableAttributedString *attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我的报价：%@ 万元", _toubiaozhuangtai]];
    if(_toubiaozhuangtai.length>0){
        [attributedStr3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WodehuojiaFont2] range:NSMakeRange(5, _toubiaozhuangtai.length)];
        [attributedStr3 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xFC5300) range:NSMakeRange(5, _toubiaozhuangtai.length)];
    }
    lbltoubiaozhuangtai.attributedText = attributedStr3;
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"我的报价：1000 万元", WodehuojiaFont3);
    NSString *pricestr=[NSString stringWithFormat:@"我的报价：%@ 万元", _toubiaozhuangtai];
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(pricestr, WodehuojiaFont3);
    [lbltoubiaozhuangtai setAdjustsFontSizeToFitWidth:YES];
    [lbltoubiaozhuangtai sizeToFit];
    if(textSize2.width>textSize.width){
        [lbltoubiaozhuangtai setW:textSize.width];
        [lbltoubiaozhuangtai setH:textSize.height];
    }else{
        [lbltoubiaozhuangtai setW:lbltoubiaozhuangtai.width];
        [lbltoubiaozhuangtai setH:lbltoubiaozhuangtai.height];
    }
    [lbltoubiaozhuangtai setX:imageView.maxX + SCREEN_WIDTH/50];
    [lbltoubiaozhuangtai setY: lblZhuangzaigang.maxY+infoView.height/15];
}
-(void)setKaibiaohaisheng:(NSString *)value {
    _kaibiaohaisheng = NilToEmpty(value);
    NSMutableAttributedString *attributedStr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"(%@ 元/吨)", _kaibiaohaisheng]];
    if(_kaibiaohaisheng.length>0){
        [attributedStr3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WodehuojiaFont2] range:NSMakeRange(1, _kaibiaohaisheng.length)];
        [attributedStr3 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xFC5300) range:NSMakeRange(1, _kaibiaohaisheng.length)];
    }
    lblKaibiaohaisheng.attributedText = attributedStr3;
    CGSize textSize = JHTCalcStringSizeWithFontSize(@"(10000 元/吨)", WodehuojiaFont3);
    NSString *pricestr=[NSString stringWithFormat:@"(%@ 元/吨)", _kaibiaohaisheng];
    CGSize textSize2 = JHTCalcStringSizeWithFontSize(pricestr, WodehuojiaFont3);
    [lblKaibiaohaisheng setAdjustsFontSizeToFitWidth:YES];
    [lblKaibiaohaisheng sizeToFit];
    if(textSize2.width>textSize.width){
        [lblKaibiaohaisheng setW:textSize.width];
        [lblKaibiaohaisheng setH:textSize.height];
    }else{
        [lblKaibiaohaisheng setW:lblKaibiaohaisheng.width];
        [lblKaibiaohaisheng setH:lblKaibiaohaisheng.height];
    }
    
    [lblKaibiaohaisheng setX:lbltoubiaozhuangtai.maxX+ SCREEN_WIDTH/100];
    [lblKaibiaohaisheng setY: lblZhuangzaigang.maxY+infoView.height/15];
}
-(void)setStatus:(NSString *)value{
    _status = NilToEmpty(value);
}
-(void)setXiezaigang:(NSString *)value{
    _xiezaigang = NilToEmpty(value);
    if([_xiezaigang isEqualToString:@"1"] || [_xiezaigang isEqualToString:@"2"]){
        serviceimg=[UIImage imageNamed:@"quotedpriceone"];
        [statusImg setImage:serviceimg];
        lblXiezaigang.text=_status;
        lblXiezaigang.textColor=UIColorFromRGB(0x30ADE8);
    }
    else if([_xiezaigang isEqualToString:@"4"]){
        serviceimg=[UIImage imageNamed:@"quotedpricetwo"];
        [statusImg setImage:serviceimg];
        lblXiezaigang.text=_status;
        lblXiezaigang.textColor=UIColorFromRGB(0xBFBFC1);
    }
    
}
-(void)setYouxiaoqi:(NSString *)value {
    _youxiaoqi = NilToEmpty(value);
    NSMutableAttributedString *attributedStr5 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 人报价", _youxiaoqi?_youxiaoqi:@"0"]];
    if(_youxiaoqi.length>0){
        [attributedStr5 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:WodehuojiaFont4] range:NSMakeRange(0,_youxiaoqi.length)];
        [attributedStr5 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xFC5300) range:NSMakeRange(0,_youxiaoqi.length)];
    }
    [btnContactText setAttributedTitle:attributedStr5 forState:UIControlStateNormal];
    [btnContactText setFrame:CGRectMake(btnContact.maxX + 3, btnContact.y, SCREEN_WIDTH/5.8, btnContact.height)];
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
