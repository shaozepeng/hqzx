//
//  JHTEmptyManager.h
//  jht
//
//  Created by 孙泽山 on 15/9/8.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#define HQZXEmptyData(_DATAVIEW, _EMPTYMANAGER, _EMPTY_LABEL) _EMPTYMANAGER = [HQZXEmptyManager emptyManager: (_DATAVIEW) emptyLabel: _EMPTY_LABEL]; (_DATAVIEW).emptyDataSetDelegate = _EMPTYMANAGER; (_DATAVIEW).emptyDataSetSource = _EMPTYMANAGER;

#define HQZXEmptyDataWhrite(_DATAVIEW, _EMPTYMANAGER, _EMPTY_LABEL) _EMPTYMANAGER = [HQZXEmptyManager emptyManager: (_DATAVIEW) emptyLabel: _EMPTY_LABEL style: JHTEmptyManagerStyleWhrite]; (_DATAVIEW).emptyDataSetDelegate = _EMPTYMANAGER; (_DATAVIEW).emptyDataSetSource = _EMPTYMANAGER;

#import <Foundation/Foundation.h>
#import "UIScrollView+EmptyDataSet.h"
typedef enum
{
    JHTEmptyManagerStyleDefault = 0,
    JHTEmptyManagerStyleWhrite
}JHTEmptyManagerStyle;

@interface HQZXEmptyManager : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property UIScrollView *dataView;
@property NSString *emptyLabel;
@property JHTEmptyManagerStyle style;

+(HQZXEmptyManager*) emptyManager:(UIScrollView*) dataView emptyLabel:(NSString*) emptyLabel;
+(HQZXEmptyManager*) emptyManager:(UIScrollView*) dataView emptyLabel:(NSString*) emptyLabel style:(JHTEmptyManagerStyle) style;
@end
