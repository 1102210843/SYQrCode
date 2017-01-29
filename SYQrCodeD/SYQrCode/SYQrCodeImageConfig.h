//
//  SYQrCodeImageConfig.h
//  SYQrCodeD
//
//  Created by 孙宇 on 2017/1/29.
//  Copyright © 2017年 sunyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SYQrCodeImageConfig : NSObject

//链接
@property (nonatomic, strong) NSString *link;

//生成二维码尺寸 默认：1024*1024
@property (nonatomic, assign) CGFloat size;

//圆角
@property (nonatomic, assign) CGFloat radius;

//中心插入图片
@property (nonatomic, strong) UIImage *centerImage;
//背景图片
@property (nonatomic, strong) UIImage *backgroundImage;


//样式扩展 默认使用 rgbValue 填充二维码图片

// style1
// 二维码色值 默认：#FFFFFF
@property (nonatomic, assign) NSString *rgbValue;

// style2
// 填充图片
@property (nonatomic, strong) UIImage *fillImage;
//可修改填充图片的色彩，只适用于黑白两色的简单图片 (RGB色彩)
@property (nonatomic, strong) NSString *color1;
@property (nonatomic, strong) NSString *color2;

@end
