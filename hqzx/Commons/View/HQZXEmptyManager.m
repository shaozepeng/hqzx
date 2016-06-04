//
//  JHTEmptyManager.m
//  jht
//
//  Created by 孙泽山 on 15/9/8.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import "HQZXEmptyManager.h"
#import "FLAnimatedImage.h"

@implementation HQZXEmptyManager


+(HQZXEmptyManager*) emptyManager:(UIScrollView*) dataView emptyLabel:(NSString*) emptyLabel style:(JHTEmptyManagerStyle) style {
    HQZXEmptyManager *emptyManager = [[HQZXEmptyManager alloc] init];
    if (emptyManager) {
        emptyManager.dataView = dataView;
        emptyManager.emptyLabel = emptyLabel;
        emptyManager.style = style;
    }
    return emptyManager;
}
+(HQZXEmptyManager*) emptyManager:(UIScrollView*) dataView emptyLabel:(NSString*) emptyLabel{
    return [HQZXEmptyManager emptyManager:dataView emptyLabel:emptyLabel style: JHTEmptyManagerStyleDefault];
}

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return self.style == JHTEmptyManagerStyleDefault ? UIColorFromRGB(0x0F151A) : UIColorFromRGB(0x0F151A);
//    return self.style == JHTEmptyManagerStyleDefault ? UIColorFromRGB(0xEFEFF1) : [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    //    return 0;
    float offset =  - _dataView.height/2 + 64;
    return offset;
}

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData: [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:(self.style==JHTEmptyManagerStyleDefault?@"no_data_gray":@"no_data_whrite") ofType:@"gif"]]];
    UIImage *image = [UIImage imageNamed:@"icon_no_data"];
    float height = image.size.height * (scrollView.width / image.size.width);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.width, height)];
//    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-image.size.width*1.5)/2, 0, image.size.width*1.5, image.size.height*1.5)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview: imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    label.font = [UIFont systemFontOfSize:15];
    //    label.font = [UIFont boldSystemFontOfSize:15.5];
    label.textColor = UIColorFromRGB(0x5E5E5E);
    label.text = _emptyLabel?:LocatizedStirngForkey(@"MEIYOUXINSHUJU");
    [label sizeToFit];
    [label setX:((SCREEN_WIDTH-label.width)/2.0) andY:(imageView.maxY+SCREEN_WIDTH/15)];
    [view addSubview: label];
    //    imageView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
    return view;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
@end
