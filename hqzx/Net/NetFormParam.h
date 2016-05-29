//
//  NetFormParam.h
//  VHReproductiveHealth
//
//  Created by Rainbow on 4/13/15.
//  Copyright (c) 2015 vichiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetFormParam : NSObject
- (id)formData:(id<AFMultipartFormData>)formData;
@end
