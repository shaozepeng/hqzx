//
//  HQZXChooseViTableCell.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/16.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXChooseViTableCell.h"

@implementation HQZXChooseViTableCell{
    UIView *cell;
    UIImageView *imageView;
    UILabel *blable;
    UIButton *backBtn;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self.rowNum = -1;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = TableBgColor;
        cell = [[UIView alloc] initWithFrame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/10)];
        cell.backgroundColor = UIColorFromRGB(0x0F151B);
        //        NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
        
        imageView = [[UIImageView alloc] initWithFrame: CGRectMake(SCREEN_WIDTH/25, cell.height/5, cell.height*0.6, cell.height*0.6)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 1;
        [cell addSubview: imageView];
        
        blable = [[UILabel alloc] initWithFrame: CGRectMake(imageView.maxX+SCREEN_WIDTH/20, 1, 1, 1)];
        blable.text = LocatizedStirngForkey(@"LEIBIE");
        blable.textColor = [UIColor whiteColor];
        blable.font = [UIFont systemFontOfSize: FIRSTFONTONE];
        [cell addSubview: blable];
        [blable sizeToFit];
        [blable setY:(cell.height-blable.height)/2];
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(SCREEN_WIDTH-cell.height-SCREEN_WIDTH/40, 0, cell.height, cell.height);
        [backBtn setTintColor:[UIColor whiteColor]];
        [backBtn setTitleColor:UIColorFromRGB(0x293035) forState:UIControlStateNormal];
        UIImage *leftBtnImage = [UIImage imageNamed:@"icon_jt_gray"];
        [backBtn setImage:leftBtnImage forState:UIControlStateNormal];
        [cell addSubview: backBtn];
        
        [self addSubview: cell];
    }
    return self;
}
- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = [NSString stringWithFormat:@"%@%@",ApiPicServer,imageUrl ];
    [imageView sd_setImageWithURL: [NSURL URLWithString: _imageUrl]];
}
- (void)setName:(NSString *)value {
    _name = NilToEmpty(value);
    blable.text = _name;
    
    [blable sizeToFit];
    [blable setY:(cell.height-blable.height)/2];
}

@end
