//
//  HRCoverView.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/5/19.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HRCoverView.h"
//#import "HRFriendController.h"

@interface HRCoverView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *imagesArr;

@property (nonatomic, strong) NSArray *labelArr;
@end

@implementation HRCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor clearColor];
        
        UITableView *tableView = [[UITableView alloc] init];
        
        tableView.layer.cornerRadius = 5;
        tableView.scrollEnabled = NO;
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        [tableView setBackgroundColor:UIColorFromRGB(0x2F3339)];
        
        tableView.separatorColor = [UIColor grayColor];
            //设置分割线在cell的图片下面
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        tableView.tableFooterView = [[UIView alloc] init];
        
        [self addSubview:tableView];
        
            _tableView = tableView;
        
      
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.labelArr[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = UIColorFromRGB(0x2F3339);
    return cell;
}



#pragma make- 布局
- (void)layoutSubviews{
    
    CGRect rect = self.tableView.frame;
    
    rect.size.width = 100;
    rect.size.height = 2 *45;
    rect.origin.y = 80;
    rect.origin.x = self.bounds.size.width - rect.size.width;
    
    self.tableView.frame = rect;
    
    
    

}
    //画三角形
- (void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, self.bounds.size.width - 20, 60);
    CGContextAddLineToPoint(ctx, self.bounds.size.width - 30, 80);
    CGContextAddLineToPoint(ctx, self.bounds.size.width-10, 80);
    CGContextAddLineToPoint(ctx, self.bounds.size.width-20, 60);
    [UIColorFromRGB(0x2F3339) set];
    
    CGContextFillPath(ctx);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        //缩小到指定的位置
        self.center = CGPointMake(SCREEN_WIDTH-20,64);
        
    }completion:^(BOOL finished) {
        NSUInteger row = indexPath.row;
        if(row==0){
            [self switchAction:0];
        }else if(row==1){
            [self switchAction:1];
        }
        [self removeFromSuperview];
    }];
    
}
- (void)switchAction:(NSInteger)num{
    UINavigationController *tabBarController = (UINavigationController *)self.window.rootViewController;
    UINavigationItem *item = (UINavigationItem*)[tabBarController.navigationBar.items objectAtIndex:0];
    NSString *selectNum;
    if([item.title isEqualToString:LocatizedStirngForkey(@"SUBMIT_BTN_TITLE")]){
        selectNum = @"0";
    }else if([item.title isEqualToString:LocatizedStirngForkey(@"TWO")]){
        selectNum = @"1";
    }else if([item.title isEqualToString:LocatizedStirngForkey(@"THREE")]){
        selectNum = @"2";
    }
    if(num==0){
        [[GDLocalizableController shareInstance]  saveDefineUserLanguage:@"en"] ;
        if(self.changeButBlock){
            self.changeButBlock(0);
        }
    }else if(num==1){
        [[GDLocalizableController shareInstance]  saveDefineUserLanguage:@"zh-Hans"] ;
        if(self.changeButBlock){
            self.changeButBlock(1);
        }
    }
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:selectNum forKey:@"selectPlu"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage"
                                                        object:self
                                                      userInfo:parameter];
    
}
#pragma make-懒加载
//- (NSArray *)imagesArr{
//    
//    if (!_imagesArr) {
//        _imagesArr = @[
//                [UIImage imageNamed:@"right_menu_addFri"],
//                [UIImage imageNamed:@"right_menu_facetoface"],
//                [UIImage imageNamed:@"right_menu_multichat"],
//                [UIImage imageNamed:@"right_menu_payMoney"],
//                [UIImage imageNamed:@"right_menu_QR"],
//                [UIImage imageNamed:@"right_menu_sendFile"]
//                ];
//    }
//    return _imagesArr;
//}

#pragma make -懒加载

- (NSArray *)labelArr{

    if (!_labelArr) {
        _labelArr = @[LocatizedStirngForkey(@"YINGYU"),LocatizedStirngForkey(@"HANYU")];
    }
    return _labelArr;
}

// 一旦触摸此视图变回从父控件中移除
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
            //缩小到指定的位置
        self.center = CGPointMake(SCREEN_WIDTH-20,64);
        
    }completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
    
}

@end
