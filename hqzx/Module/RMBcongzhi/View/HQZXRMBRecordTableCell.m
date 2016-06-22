//
//  HQZXRMBRecordTableCell.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/15.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXRMBRecordTableCell.h"
@interface HQZXRMBRecordTableCell (){
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
    UILabel *twoLable;
    UILabel *threeLable;
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

@implementation HQZXRMBRecordTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.rowNum = -1;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = TableBgColor;
        UIView *cell = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH*2, SCREEN_WIDTH/8)];
        cell.backgroundColor = UIColorFromRGB(0x0F151B);
        NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
        
        float cellViewWidth = (cell.width-5)/6;
        
        //一区
        //        oneInfoView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, cellViewWidth, cell.height-1)];
        //        oneInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        //        [cell addSubview:oneInfoView];
        //
        //        oneLineView = [[UIView alloc] initWithFrame: CGRectMake(oneInfoView.maxX, 0, 1, cell.height-1)];
        //        oneLineView.backgroundColor = UIColorFromRGB(0x141D26);
        //        [cell addSubview:oneLineView];
        //
        //        oneBonLineView = [[UIView alloc] initWithFrame: CGRectMake(oneInfoView.x, oneInfoView.maxY, cellViewWidth, 1)];
        //        oneBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        //        [cell addSubview:oneBonLineView];
        //
        //        oneLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        //        oneLable.text = LocatizedStirngForkey(@"CAOZUO");
        //        oneLable.textColor = UIColorFromRGB(0x2E6ED0);
        //        oneLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        //        [oneInfoView addSubview: oneLable];
        //        [oneLable sizeToFit];
        //        [oneLable setX:(oneInfoView.width-oneLable.width)/2];
        //        [oneLable setY:(oneInfoView.height-oneLable.height)/2];
        
        //二区
        twoInfoView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, cellViewWidth, cell.height-1)];
        twoInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:twoInfoView];
        
        twoLineView = [[UIView alloc] initWithFrame: CGRectMake(twoInfoView.maxX, 0, 1, cell.height-1)];
        twoLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:twoLineView];
        
        twoBonLineView = [[UIView alloc] initWithFrame: CGRectMake(twoInfoView.x, twoInfoView.maxY, cellViewWidth, 1)];
        twoBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:twoBonLineView];
        
        twoLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        twoLable.text = LocatizedStirngForkey(@"CHONGZHISHIJIAN");
        twoLable.textColor = UIColorFromRGB(0x2E6ED0);
        twoLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        [twoInfoView addSubview: twoLable];
        [twoLable sizeToFit];
        [twoLable setX:(twoInfoView.width-twoLable.width)/2];
        [twoLable setY:(twoInfoView.height-twoLable.height)/2];
        
        //三区
        threeInfoView = [[UIView alloc] initWithFrame: CGRectMake(twoLineView.maxX, 0, cellViewWidth, cell.height-1)];
        threeInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        [cell addSubview:threeInfoView];
        
        threeLineView = [[UIView alloc] initWithFrame: CGRectMake(threeInfoView.maxX, 0, 1, cell.height-1)];
        threeLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:threeLineView];
        
        threeBonLineView = [[UIView alloc] initWithFrame: CGRectMake(threeInfoView.x, threeInfoView.maxY, cellViewWidth, 1)];
        threeBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        [cell addSubview:threeBonLineView];
        
        threeLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        threeLable.text = LocatizedStirngForkey(@"CHONGZHIFANGSHI");
        threeLable.textColor = UIColorFromRGB(0x2E6ED0);
        threeLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        [threeInfoView addSubview: threeLable];
        [threeLable sizeToFit];
        [threeLable setX:(threeInfoView.width-threeLable.width)/2];
        [threeLable setY:(threeInfoView.height-threeLable.height)/2];
//        if([language isEqualToString:@"zh-Hans"]){
//            [threeLable setX:(threeInfoView.width-threeLable.width)/2];
//            [threeLable setY:(threeInfoView.height-threeLable.height)/2];
//        }else if([language isEqualToString:@"en"]){
//            threeLable.lineBreakMode = NSLineBreakByCharWrapping;
//            threeLable.numberOfLines = 0;
//            threeLable.font = [UIFont systemFontOfSize: 11];
//            [threeLable setW:threeInfoView.width-4];
//            [threeLable setH:threeInfoView.height-6];
//            [threeLable setX:2];
//            [threeLable setY:3];
//        }
        
        
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
        foreLable.text = LocatizedStirngForkey(@"DINGDNAHAO");
        foreLable.textColor = UIColorFromRGB(0x2E6ED0);
        foreLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        [foreInfoView addSubview: foreLable];
        [foreLable sizeToFit];
        [foreLable setX:(foreInfoView.width-foreLable.width)/2];
        [foreLable setY:(foreInfoView.height-foreLable.height)/2];
//        if([language isEqualToString:@"zh-Hans"]){
//            [foreLable setX:(foreInfoView.width-foreLable.width)/2];
//            [foreLable setY:(foreInfoView.height-foreLable.height)/2];
//        }else if([language isEqualToString:@"en"]){
//            foreLable.lineBreakMode = NSLineBreakByCharWrapping;
//            foreLable.numberOfLines = 0;
//            foreLable.font = [UIFont systemFontOfSize: 11];
//            [foreLable setW:foreInfoView.width-4];
//            [foreLable setH:foreInfoView.height-6];
//            [foreLable setX:2];
//            [foreLable setY:3];
//        }
        
        
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
        fiveLable.text = LocatizedStirngForkey(@"CHONGZHIJINE");
        fiveLable.textColor = UIColorFromRGB(0x2E6ED0);
        fiveLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
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
        sixLable.text = LocatizedStirngForkey(@"SHOUXUFEI");
        sixLable.textColor = UIColorFromRGB(0x2E6ED0);
        sixLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        [sixInfoView addSubview: sixLable];
        [sixLable sizeToFit];
        [sixLable setX:(sixInfoView.width-sixLable.width)/2];
        [sixLable setY:(sixInfoView.height-sixLable.height)/2];
        
//        if([language isEqualToString:@"zh-Hans"]){
//            [sixLable setX:(sixInfoView.width-sixLable.width)/2];
//            [sixLable setY:(sixInfoView.height-sixLable.height)/2];
//        }else if([language isEqualToString:@"en"]){
//            sixLable.lineBreakMode = NSLineBreakByCharWrapping;
//            sixLable.numberOfLines = 0;
//            sixLable.font = [UIFont systemFontOfSize: 11];
//            [sixLable setW:sixInfoView.width-4];
//            [sixLable setH:sixInfoView.height-6];
//            [sixLable setX:2];
//            [sixLable setY:3];
//        }
        
        
        
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
        sevenLable.text = LocatizedStirngForkey(@"ZHUANGTAI");
        sevenLable.textColor = UIColorFromRGB(0x2E6ED0);
        sevenLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        [sevenInfoView addSubview: sevenLable];
        [sevenLable sizeToFit];
        [sevenLable setX:(sevenInfoView.width-sevenLable.width)/2];
        [sevenLable setY:(sevenInfoView.height-sevenLable.height)/2];
        
        //        if([language isEqualToString:@"zh-Hans"]){
        //
        //        }else if([language isEqualToString:@"en"]){
        //            sevenLable.lineBreakMode = NSLineBreakByCharWrapping;
        //            sevenLable.numberOfLines = 0;
        //            sevenLable.font = [UIFont systemFontOfSize: 11];
        //            [sevenLable setW:sevenInfoView.width-4];
        //            [sevenLable setH:sevenInfoView.height-6];
        //            [sevenLable setX:2];
        //            [sevenLable setY:3];
        //        }
        
        
        
        //八区
//        eightInfoView = [[UIView alloc] initWithFrame: CGRectMake(sevenLineView.maxX, 0, cellViewWidth, cell.height-1)];
//        eightInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
//        [cell addSubview:eightInfoView];
//        
//        eightLineView = [[UIView alloc] initWithFrame: CGRectMake(eightInfoView.maxX, 0, 1, cell.height-1)];
//        eightLineView.backgroundColor = UIColorFromRGB(0x141D26);
//        [cell addSubview:eightLineView];
//        
//        eightBonLineView = [[UIView alloc] initWithFrame: CGRectMake(eightInfoView.x, eightInfoView.maxY, cellViewWidth, 1)];
//        eightBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
//        [cell addSubview:eightBonLineView];
//        
//        eightLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
//        eightLable.text = LocatizedStirngForkey(@"ZHUANGTAI");
//        eightLable.textColor = UIColorFromRGB(0x2E6ED0);
//        eightLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
//        [eightInfoView addSubview: eightLable];
//        [eightLable sizeToFit];
//        [eightLable setX:(eightInfoView.width-eightLable.width)/2];
//        [eightLable setY:(eightInfoView.height-eightLable.height)/2];
        
        //        if([language isEqualToString:@"zh-Hans"]){
        //
        //        }else if([language isEqualToString:@"en"]){
        //            eightLable.lineBreakMode = NSLineBreakByCharWrapping;
        //            eightLable.numberOfLines = 0;
        //            eightLable.font = [UIFont systemFontOfSize: 11];
        //            [eightLable setW:eightInfoView.width-4];
        //            [eightLable setH:eightInfoView.height-6];
        //            [eightLable setX:2];
        //            [eightLable setY:3];
        //        }
        
        
        
        //九区
        //        nineInfoView = [[UIView alloc] initWithFrame: CGRectMake(eightLineView.maxX, 0, cellViewWidth, cell.height-1)];
        //        nineInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        //        [cell addSubview:nineInfoView];
        //
        //        nineLineView = [[UIView alloc] initWithFrame: CGRectMake(nineInfoView.maxX, 0, 1, cell.height-1)];
        //        nineLineView.backgroundColor = UIColorFromRGB(0x141D26);
        //        [cell addSubview:nineLineView];
        //
        //        nineBonLineView = [[UIView alloc] initWithFrame: CGRectMake(nineInfoView.x, nineInfoView.maxY, cellViewWidth, 1)];
        //        nineBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        //        [cell addSubview:nineBonLineView];
        //
        //        nineLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        //        nineLable.text = LocatizedStirngForkey(@"CHEGJIAOSHULIANG");
        //        nineLable.textColor = UIColorFromRGB(0x2E6ED0);
        //        nineLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        //        [nineInfoView addSubview: nineLable];
        //        [nineLable sizeToFit];
        //
        //        if([language isEqualToString:@"zh-Hans"]){
        //            [nineLable setX:(nineInfoView.width-nineLable.width)/2];
        //            [nineLable setY:(nineInfoView.height-nineLable.height)/2];
        //        }else if([language isEqualToString:@"en"]){
        //            nineLable.lineBreakMode = NSLineBreakByCharWrapping;
        //            nineLable.numberOfLines = 0;
        //            nineLable.font = [UIFont systemFontOfSize: 11];
        //            [nineLable setW:nineInfoView.width-4];
        //            [nineLable setH:nineInfoView.height-6];
        //            [nineLable setX:2];
        //            [nineLable setY:3];
        //        }
        //
        //
        //
        //        //十区
        //        tenInfoView = [[UIView alloc] initWithFrame: CGRectMake(nineLineView.maxX, 0, cellViewWidth, cell.height-1)];
        //        tenInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        //        [cell addSubview:tenInfoView];
        //
        //        tenLineView = [[UIView alloc] initWithFrame: CGRectMake(tenInfoView.maxX, 0, 1, cell.height-1)];
        //        tenLineView.backgroundColor = UIColorFromRGB(0x141D26);
        //        [cell addSubview:tenLineView];
        //
        //        tenBonLineView = [[UIView alloc] initWithFrame: CGRectMake(tenInfoView.x, tenInfoView.maxY, cellViewWidth, 1)];
        //        tenBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        //        [cell addSubview:tenBonLineView];
        //
        //        tenLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        //        tenLable.text = LocatizedStirngForkey(@"CHENGJIAOJINE");
        //        tenLable.textColor = UIColorFromRGB(0x2E6ED0);
        //        tenLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        //        [tenInfoView addSubview: tenLable];
        //        [tenLable sizeToFit];
        //
        //        if([language isEqualToString:@"zh-Hans"]){
        //            [tenLable setX:(tenInfoView.width-tenLable.width)/2];
        //            [tenLable setY:(tenInfoView.height-tenLable.height)/2];
        //        }else if([language isEqualToString:@"en"]){
        //            tenLable.lineBreakMode = NSLineBreakByCharWrapping;
        //            tenLable.numberOfLines = 0;
        //            tenLable.font = [UIFont systemFontOfSize: 11];
        //            [tenLable setW:tenInfoView.width-4];
        //            [tenLable setH:tenInfoView.height-6];
        //            [tenLable setX:2];
        //            [tenLable setY:3];
        //        }
        //
        //        //十一区
        //        elevenInfoView = [[UIView alloc] initWithFrame: CGRectMake(tenLineView.maxX, 0, cellViewWidth, cell.height-1)];
        //        elevenInfoView.backgroundColor = UIColorFromRGB(0x0F151B);
        //        [cell addSubview:elevenInfoView];
        //
        //        elevenBonLineView = [[UIView alloc] initWithFrame: CGRectMake(elevenInfoView.x, elevenInfoView.maxY, cellViewWidth, 1)];
        //        elevenBonLineView.backgroundColor = UIColorFromRGB(0x141D26);
        //        [cell addSubview:elevenBonLineView];
        //
        //        elevenLable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
        //        elevenLable.text = LocatizedStirngForkey(@"PINGJUNCHENGJIAOJIA");
        //        elevenLable.textColor = UIColorFromRGB(0x2E6ED0);
        //        elevenLable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        //        [elevenInfoView addSubview: elevenLable];
        //        [elevenLable sizeToFit];
        //
        //        if([language isEqualToString:@"zh-Hans"]){
        //            [elevenLable setX:(elevenInfoView.width-elevenLable.width)/2];
        //            [elevenLable setY:(elevenInfoView.height-elevenLable.height)/2];
        //        }else if([language isEqualToString:@"en"]){
        //            elevenLable.lineBreakMode = NSLineBreakByCharWrapping;
        //            elevenLable.numberOfLines = 0;
        //            elevenLable.font = [UIFont systemFontOfSize: 11];
        //            [elevenLable setW:elevenInfoView.width-4];
        //            [elevenLable setH:elevenInfoView.height-6];
        //            [elevenLable setX:2];
        //            [elevenLable setY:3];
        //        }
        
        [self addSubview: cell];
    }
    return self;
}
@end
