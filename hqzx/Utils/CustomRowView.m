//
//  CustomRowView.m
//  jht
//
//  Created by 邵泽鹏 on 15/7/6.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import "MacroDefinition.h"
#import "CustomRowView.h"
#import "DoAlertView.h"
@implementation CustomRowView

+ (CustomRowView *)userdInstance{
    __strong static CustomRowView *singleton = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

-(UIView*)customView:(NSArray*) arrayView{
    UIView *noticeView;
    UIView *nextView;
    if(arrayView.count>=1){
        noticeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DO_VIEW_WIDTH, 60*arrayView.count+arrayView.count-1)];
        noticeView.backgroundColor=UIColorFromRGB(0xEDEDED);
        UIView *firstView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, DO_VIEW_WIDTH, 60)];
        firstView.backgroundColor=UIColorFromRGB(0xFFFFFF);
        [noticeView addSubview:firstView];
        UIButton *firstBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 15, DO_VIEW_WIDTH, 30)];
        [firstBtn setTitle:[arrayView objectAtIndex:0] forState:UIControlStateNormal];
        [firstBtn setTitleColor:UIColorFromRGB(0x4D4D4D) forState:UIControlStateNormal];
        firstBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        firstBtn.contentEdgeInsets = UIEdgeInsetsMake(0,15, 0, 0);
        [firstView addSubview:firstBtn];
        [firstBtn addTarget:self action:@selector(firstBlocks) forControlEvents:UIControlEventTouchUpInside];
        
        if(arrayView.count>=2){
            for(int i=1;i<arrayView.count;++i){
                nextView=[[UIView alloc] initWithFrame:CGRectMake(0,60*i+1.0*i, DO_VIEW_WIDTH, 60)];
                nextView.backgroundColor=UIColorFromRGB(0xFFFFFF);
                UIButton *nextBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 15, DO_VIEW_WIDTH, 30)];
                [nextBtn setTitle:[arrayView objectAtIndex:i] forState:UIControlStateNormal];
                [nextBtn setTitleColor:UIColorFromRGB(0x4D4D4D) forState:UIControlStateNormal];
                nextBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                nextBtn.contentEdgeInsets = UIEdgeInsetsMake(0,15, 0, 0);
                [nextView addSubview:nextBtn];
                [nextBtn addTarget:self action:@selector(nextBlocks:) forControlEvents:UIControlEventTouchUpInside];
                [nextBtn setTag:i];
                [noticeView addSubview:nextView];
            }
        }
    }
    return noticeView;
}
-(void) firstBlocks{
    WEAK_SELF
        if (weakself.Custom_Block) {
            weakself.Custom_Block(0);
        }
}
-(void) nextBlocks:(id)sender{
    UIButton *buttons = (UIButton*)sender;
    WEAK_SELF
    if (weakself.Custom_Block) {
        weakself.Custom_Block(buttons.tag);
    }
}
@end
