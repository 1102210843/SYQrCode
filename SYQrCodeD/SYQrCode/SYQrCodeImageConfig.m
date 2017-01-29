//
//  SYQrCodeImageConfig.m
//  SYQrCodeD
//
//  Created by 孙宇 on 2017/1/29.
//  Copyright © 2017年 sunyu. All rights reserved.
//

#import "SYQrCodeImageConfig.h"

@implementation SYQrCodeImageConfig
- (instancetype)init
{
    if (self = [super init]){
        self.size = 1024;
        self.rgbValue = @"#000000";
    }
    return self;
}
@end
