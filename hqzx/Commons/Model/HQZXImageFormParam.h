//
//  JHTImageFormParam.h
//  jht
//
//  Created by 孙泽山 on 15/7/22.
//  Copyright (c) 2015年 zthz. All rights reserved.
//

#import "NetFormParam.h"

typedef void (^JHTImageUpLoadCallBack)(int index, BOOL success, NSString *url);
/**上传图片类型*/
typedef NS_ENUM(NSInteger, UpImageType)
{
    UpImageTypeHuoPan = 1,     /**< 货盘 */
    UpImageTypeChuanPan = 2    /**< 船盘 */
};

@interface HQZXImageFormParam : NetFormParam

@property int type;
@property NSData *imgupload;

- (instancetype) initWithImage:(NSData*) image type:(UpImageType) type;
@end
