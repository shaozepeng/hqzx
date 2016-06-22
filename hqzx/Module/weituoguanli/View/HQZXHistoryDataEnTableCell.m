//
//  HQZXHistoryDataEnTableCell.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXHistoryDataEnTableCell.h"
@interface HQZXHistoryDataEnTableCell (){
    UIView *infoView;
    UIView *oneInfoView;
    UIView *twoInfoView;
    UIView *threeInfoView;
    UIView *foreInfoView;
    UIView *fiveInfoView;
    UIView *sixInfoView;
    UIView *sevenInfoView;
    UIView *eightInfoView;
    UIView *nineInfoView;
    UIView *tenInfoView;
    UIView *elevenInfoView;
    
    UIView *oneBonLineView;
    UIView *twoBonLineView;
    UIView *threeBonLineView;
    UIView *foreBonLineView;
    UIView *fiveBonLineView;
    UIView *sixBonLineView;
    UIView *sevenBonLineView;
    UIView *eightBonLineView;
    UIView *nineBonLineView;
    UIView *tenBonLineView;
    UIView *elevenBonLineView;
    
    UIView *oneLineView;
    UIView *twoLineView;
    UIView *threeLineView;
    UIView *foreLineView;
    UIView *fiveLineView;
    UIView *sixLineView;
    UIView *sevenLineView;
    UIView *eightLineView;
    UIView *nineLineView;
    UIView *tenLineView;
    
    UILabel *oneLable;
    UILabel *oneFLable;
    UILabel *oneSLable;
    UILabel *twoLable;
    UILabel *twoFLable;
    UILabel *threeLable;
    UILabel *threeFLable;
    UILabel *foreLable;
    UILabel *fiveLable;
    UILabel *sixLable;
    UILabel *sevenLable;
    UILabel *eightLable;
    UILabel *nineLable;
    UILabel *tenLable;
    UILabel *elevenLable;
}
@end


@implementation HQZXHistoryDataEnTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.rowNum = -1;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = TableBgColor;
        UIView *cell = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH*2.2, SCREEN_WIDTH/8)];
        cell.backgroundColor = UIColorFromRGB(0x0F151B);
        NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
        
        float cellViewWidth = (cell.width-9)/10.5;
        
        //一区
        oneInfoView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, cellViewWidth*1, cell.height-1)];
        oneInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:oneInfoView];
        
        oneLineView = [[UIView alloc] initWithFrame: CGRectMake(oneInfoView.maxX, 0, 1, cell.height-1)];
        oneLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:oneLineView];
        
        oneBonLineView = [[UIView alloc] initWithFrame: CGRectMake(oneInfoView.x, oneInfoView.maxY, cellViewWidth*1, 1)];
        oneBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:oneBonLineView];
        
        oneSLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        oneSLable.text = @"已成交";
        oneSLable.textColor = [UIColor redColor];
        oneSLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
        [oneInfoView addSubview: oneSLable];
        [oneSLable sizeToFit];
        [oneSLable setX:(oneInfoView.width-oneSLable.width)/2];
        [oneSLable setY:(oneInfoView.height-oneSLable.height)/2];
        
        //二区
        twoInfoView = [[UIView alloc] initWithFrame: CGRectMake(oneLineView.maxX, 0, cellViewWidth*1.5, cell.height-1)];
        twoInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:twoInfoView];
        
        twoLineView = [[UIView alloc] initWithFrame: CGRectMake(twoInfoView.maxX, 0, 1, cell.height-1)];
        twoLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:twoLineView];
        
        twoBonLineView = [[UIView alloc] initWithFrame: CGRectMake(twoInfoView.x, twoInfoView.maxY, cellViewWidth*1.5, 1)];
        twoBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:twoBonLineView];
        
        twoLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        twoLable.text = @"2016-05-26";
        twoLable.textColor = UIColorFromRGB(0xE0E2E2);
        twoLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
        [twoInfoView addSubview: twoLable];
        [twoLable sizeToFit];
        [twoLable setX:(twoInfoView.width-twoLable.width)/2];
        [twoLable setY:3];
        
        twoFLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        twoFLable.text = @"20:23:45";
        twoFLable.textColor = UIColorFromRGB(0xE0E2E2);
        twoFLable.font = [UIFont systemFontOfSize: DATAFONTTWO];
        [twoInfoView addSubview: twoFLable];
        [twoFLable sizeToFit];
        [twoFLable setX:(twoInfoView.width-twoFLable.width)/2];
        [twoFLable setY:twoLable.maxY+3];
        
        
        
        
        //三区
        threeInfoView = [[UIView alloc] initWithFrame: CGRectMake(twoLineView.maxX, 0, cellViewWidth*1, cell.height-1)];
        threeInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:threeInfoView];
        
        threeLineView = [[UIView alloc] initWithFrame: CGRectMake(threeInfoView.maxX, 0, 1, cell.height-1)];
        threeLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:threeLineView];
        
        threeBonLineView = [[UIView alloc] initWithFrame: CGRectMake(threeInfoView.x, threeInfoView.maxY, cellViewWidth*1, 1)];
        threeBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:threeBonLineView];
        
        threeLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        threeLable.text = LocatizedStirngForkey(@"SHANGWEIFUKUAN");
        threeLable.textColor = UIColorFromRGB(0xE0E2E2);
        if([language isEqualToString:@"zh-Hans"]){
            threeLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
        }else if([language isEqualToString:@"en"]){
            threeLable.font = [UIFont systemFontOfSize: DATAFONTONE];
        }
        [threeInfoView addSubview: threeLable];
        [threeLable sizeToFit];
        
        [threeLable setX:(threeInfoView.width-threeLable.width)/2];
        [threeLable setY:(threeInfoView.height-threeLable.height)/2];
        
        
        
        //四区
        foreInfoView = [[UIView alloc] initWithFrame: CGRectMake(threeLineView.maxX, 0, cellViewWidth, cell.height-1)];
        foreInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:foreInfoView];
        
        foreLineView = [[UIView alloc] initWithFrame: CGRectMake(foreInfoView.maxX, 0, 1, cell.height-1)];
        foreLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:foreLineView];
        
        foreBonLineView = [[UIView alloc] initWithFrame: CGRectMake(foreInfoView.x, foreInfoView.maxY, cellViewWidth, 1)];
        foreBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:foreBonLineView];
        
        foreLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        foreLable.text = @"类别";
        foreLable.textColor = UIColorFromRGB(0xE0E2E2);
        foreLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
        [foreInfoView addSubview: foreLable];
        [foreLable sizeToFit];
        [foreLable setX:(foreInfoView.width-foreLable.width)/2];
        [foreLable setY:(foreInfoView.height-foreLable.height)/2];
        
        //五区
        fiveInfoView = [[UIView alloc] initWithFrame: CGRectMake(foreLineView.maxX, 0, cellViewWidth, cell.height-1)];
        fiveInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:fiveInfoView];
        
        fiveLineView = [[UIView alloc] initWithFrame: CGRectMake(fiveInfoView.maxX, 0, 1, cell.height-1)];
        fiveLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:fiveLineView];
        
        fiveBonLineView = [[UIView alloc] initWithFrame: CGRectMake(fiveInfoView.x, fiveInfoView.maxY, cellViewWidth, 1)];
        fiveBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:fiveBonLineView];
        
        fiveLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        fiveLable.text = @"1002";
        fiveLable.textColor = UIColorFromRGB(0xE0E2E2);
        fiveLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
        [fiveInfoView addSubview: fiveLable];
        [fiveLable sizeToFit];
        
        [fiveLable setX:(fiveInfoView.width-fiveLable.width)/2];
        [fiveLable setY:(fiveInfoView.height-fiveLable.height)/2];
        
        
        
        //六区
        sixInfoView = [[UIView alloc] initWithFrame: CGRectMake(fiveLineView.maxX, 0, cellViewWidth, cell.height-1)];
        sixInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:sixInfoView];
        
        sixLineView = [[UIView alloc] initWithFrame: CGRectMake(sixInfoView.maxX, 0, 1, cell.height-1)];
        sixLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:sixLineView];
        
        sixBonLineView = [[UIView alloc] initWithFrame: CGRectMake(sixInfoView.x, sixInfoView.maxY, cellViewWidth, 1)];
        sixBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:sixBonLineView];
        
        sixLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        sixLable.text = @"￥100.99";
        sixLable.textColor = UIColorFromRGB(0xE0E2E2);
        sixLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
        [sixInfoView addSubview: sixLable];
        [sixLable sizeToFit];
        
        [sixLable setX:(sixInfoView.width-sixLable.width)/2];
        [sixLable setY:(sixInfoView.height-sixLable.height)/2];
        
        
        
        //七区
        sevenInfoView = [[UIView alloc] initWithFrame: CGRectMake(sixLineView.maxX, 0, cellViewWidth, cell.height-1)];
        sevenInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:sevenInfoView];
        
        sevenLineView = [[UIView alloc] initWithFrame: CGRectMake(sevenInfoView.maxX, 0, 1, cell.height-1)];
        sevenLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:sevenLineView];
        
        sevenBonLineView = [[UIView alloc] initWithFrame: CGRectMake(sevenInfoView.x, sevenInfoView.maxY, cellViewWidth, 1)];
        sevenBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:sevenBonLineView];
        
        sevenLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        sevenLable.text = @"￥100.99";
        sevenLable.textColor = UIColorFromRGB(0xE0E2E2);
        sevenLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
        [sevenInfoView addSubview: sevenLable];
        [sevenLable sizeToFit];
        
        [sevenLable setX:(sevenInfoView.width-sevenLable.width)/2];
        [sevenLable setY:(sevenInfoView.height-sevenLable.height)/2];
        
        
        
        //八区
        eightInfoView = [[UIView alloc] initWithFrame: CGRectMake(sevenLineView.maxX, 0, cellViewWidth, cell.height-1)];
        eightInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:eightInfoView];
        
        eightLineView = [[UIView alloc] initWithFrame: CGRectMake(eightInfoView.maxX, 0, 1, cell.height-1)];
        eightLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:eightLineView];
        
        eightBonLineView = [[UIView alloc] initWithFrame: CGRectMake(eightInfoView.x, eightInfoView.maxY, cellViewWidth, 1)];
        eightBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:eightBonLineView];
        
        eightLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        eightLable.text = @"￥100.99";
        eightLable.textColor = UIColorFromRGB(0xE0E2E2);
        eightLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
        [eightInfoView addSubview: eightLable];
        [eightLable sizeToFit];
        
        [eightLable setX:(eightInfoView.width-eightLable.width)/2];
        [eightLable setY:(eightInfoView.height-eightLable.height)/2];
        
        
        
        //九区
        nineInfoView = [[UIView alloc] initWithFrame: CGRectMake(eightLineView.maxX, 0, cellViewWidth, cell.height-1)];
        nineInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:nineInfoView];
        
        nineLineView = [[UIView alloc] initWithFrame: CGRectMake(nineInfoView.maxX, 0, 1, cell.height-1)];
        nineLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:nineLineView];
        
        nineBonLineView = [[UIView alloc] initWithFrame: CGRectMake(nineInfoView.x, nineInfoView.maxY, cellViewWidth, 1)];
        nineBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:nineBonLineView];
        
        nineLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        nineLable.text = @"1002";
        nineLable.textColor = UIColorFromRGB(0xE0E2E2);
        nineLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
        [nineInfoView addSubview: nineLable];
        [nineLable sizeToFit];
        
        [nineLable setX:(nineInfoView.width-nineLable.width)/2];
        [nineLable setY:(nineInfoView.height-nineLable.height)/2];
        
        
        
        //十区
        tenInfoView = [[UIView alloc] initWithFrame: CGRectMake(nineLineView.maxX, 0, cellViewWidth, cell.height-1)];
        tenInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:tenInfoView];
        
        tenLineView = [[UIView alloc] initWithFrame: CGRectMake(tenInfoView.maxX, 0, 1, cell.height-1)];
        tenLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:tenLineView];
        
        tenBonLineView = [[UIView alloc] initWithFrame: CGRectMake(tenInfoView.x, tenInfoView.maxY, cellViewWidth, 1)];
        tenBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:tenBonLineView];
        
        tenLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        tenLable.text = @"￥100.99";
        tenLable.textColor = UIColorFromRGB(0xE0E2E2);
        tenLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
        [tenInfoView addSubview: tenLable];
        [tenLable sizeToFit];
        
        [tenLable setX:(tenInfoView.width-tenLable.width)/2];
        [tenLable setY:(tenInfoView.height-tenLable.height)/2];
        
        [self addSubview: cell];
    }
    return self;
}
-(void)setTime:(NSString *)value{
    _time = NilToEmpty(value);
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:[_time integerValue]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:nd];
    twoLable.text = dateString;
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"HH:mm:ss"];
    NSString *dateString2 = [dateFormat2 stringFromDate:nd];
    twoFLable.text = dateString2;
    
}
-(void)setTradetype:(NSString *)value{
    _tradetype = NilToEmpty(value);
    threeLable.text = _tradetype;
    [threeLable sizeToFit];
    [threeLable setX:(threeInfoView.width-threeLable.width)/2];
    [threeLable setY:(threeInfoView.height-threeLable.height)/2];
    
}
-(void)setNumber:(NSString *)value{
    _number = NilToEmpty(value);
    foreLable.text = _number;
    [foreLable sizeToFit];
    [foreLable setX:(foreInfoView.width-foreLable.width)/2];
    [foreLable setY:(foreInfoView.height-foreLable.height)/2];
}
-(void)setPrice:(NSString *)value{
    _price = NilToEmpty(value);
    float jiage = [_price floatValue]*[_number floatValue];
    fiveLable.text = [NSString stringWithFormat:@"￥%.2f",jiage];
    [fiveLable sizeToFit];
    [fiveLable setX:(fiveInfoView.width-fiveLable.width)/2];
    [fiveLable setY:(fiveInfoView.height-fiveLable.height)/2];
    
    sevenLable.text = [NSString stringWithFormat:@"￥%@",_price];
    [sevenLable sizeToFit];
    [sevenLable setX:(sevenInfoView.width-sevenLable.width)/2];
    [sevenLable setY:(sevenInfoView.height-sevenLable.height)/2];
}
-(void)setFee:(NSString *)value{
    _fee = NilToEmpty(value);
    float shouxu = [_price floatValue]*[_fee floatValue]/100;
    sixLable.text = [NSString stringWithFormat:@"￥%.2f",shouxu];
    [sixLable sizeToFit];
    
    [sixLable setX:(sixInfoView.width-sixLable.width)/2];
    [sixLable setY:(sixInfoView.height-sixLable.height)/2];
}
-(void)setVolume:(NSString *)value{
    _volume = NilToEmpty(value);
    eightLable.text = _volume;
    [eightLable sizeToFit];
    [eightLable setX:(eightInfoView.width-eightLable.width)/2];
    [eightLable setY:(eightInfoView.height-eightLable.height)/2];
}
-(void)setDealmoney:(NSString *)value{
    _dealmoney = NilToEmpty(value);
    nineLable.text = [NSString stringWithFormat:@"￥%.2f",[_dealmoney floatValue]];;
    [nineLable sizeToFit];
    [nineLable setX:(nineInfoView.width-nineLable.width)/2];
    [nineLable setY:(nineInfoView.height-nineLable.height)/2];
    float volm;
    if([_volume intValue]==0){
        volm = 0.00;
    }else{
        volm = [_dealmoney floatValue]/[_volume floatValue];
    }
    
    tenLable.text = [NSString stringWithFormat:@"￥%.2f",volm];
    [tenLable sizeToFit];
    [tenLable setX:(tenInfoView.width-tenLable.width)/2];
    [tenLable setY:(tenInfoView.height-tenLable.height)/2];
}
-(void)setStatus:(NSString *)value{
    _status = NilToEmpty(value);
//    if([_status intValue]==-1){
//        if([_volume intValue]>0){
//            oneSLable.text = LocatizedStirngForkey(@"BUFENCHENGJIAO");
//        }else{
//            oneSLable.text = LocatizedStirngForkey(@"YICHENGJIAO");
//        }
//    }else if([_status intValue]==0){
//        if([_volume intValue]==[_number intValue]){
//            oneSLable.text = LocatizedStirngForkey(@"WANQUANCHENGJIAO");
//        }
//    }
    oneSLable.text = _status;
    [oneSLable sizeToFit];
    [oneSLable setX:(oneInfoView.width-oneSLable.width)/2];
    [oneSLable setY:(oneInfoView.height-oneSLable.height)/2];
//    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
//    if([language isEqualToString:@"zh-Hans"]){
//        oneSLable.font = [UIFont systemFontOfSize: DATAFONTTHREE];
//        [oneSLable sizeToFit];
//        [oneSLable setX:(oneInfoView.width-oneSLable.width)/2];
//        [oneSLable setY:(oneInfoView.height-oneSLable.height)/2];
//    }else if([language isEqualToString:@"en"]){
//        oneSLable.font = [UIFont systemFontOfSize: DATAFONTONE];
//        oneSLable.lineBreakMode = NSLineBreakByCharWrapping;
//        oneSLable.numberOfLines = 0;
//        oneSLable.font = [UIFont systemFontOfSize: 11];
//        [oneSLable setW:oneInfoView.width-8];
//        [oneSLable setH:oneInfoView.height-6];
//        [oneSLable setX:4];
//        [oneSLable setY:3];
//    }
}
@end
