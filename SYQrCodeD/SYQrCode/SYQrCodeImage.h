//
//  SYQrCodeImage.h
//  SYQrCodeD
//
//  Created by 孙宇 on 2017/1/28.
//  Copyright © 2017年 sunyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYQrCodeImageConfig.h"

@interface SYQrCodeImage : UIImage

+ (id)qrCodeImageWithConfigCallback:(SYQrCodeImageConfig * (^)())callback;

@end
