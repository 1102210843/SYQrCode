//
//  UIImage+SYRoundImage.m
//  SYQrCodeDemo
//
//  Created by sunyu on 16/5/9.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "UIImage+SYRoundImage.h"

@implementation UIImage (SYRoundImage)

+ (UIImage *)generateRoundedCornersWithImage:(UIImage *)image size:(CGSize)size radius:(CGFloat)radius
{
    if (!image)return nil;
    
    const CGFloat width = size.width;
    const CGFloat height = size.height;
    
    radius = MAX(5.f, radius);
    radius = MIN(10.f, radius);
    
    UIImage *newImage = [image normalizedImage];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextBeginPath(context);
    addRoundRectToPath(context, rect, radius, newImage.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage * img = [UIImage imageWithCGImage: imageMasked];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}


/**
 处理部分图片方向问题
 */
- (UIImage *)normalizedImage {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:(CGRect){0, 0, self.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}



/**
 *  给上下文添加圆角蒙版
 */
void addRoundRectToPath(CGContextRef context, CGRect rect, float radius, CGImageRef image)
{
    float width, height;
    if (radius == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    width = CGRectGetWidth(rect);
    height = CGRectGetHeight(rect);
    
    //裁剪路径
    CGContextMoveToPoint(context, width, height / 2);
    CGContextAddArcToPoint(context, width, height, width / 2, height, radius);
    CGContextAddArcToPoint(context, 0, height, 0, height / 2, radius);
    CGContextAddArcToPoint(context, 0, 0, width / 2, 0, radius);
    CGContextAddArcToPoint(context, width, 0, width, height / 2, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRestoreGState(context);
}


@end
