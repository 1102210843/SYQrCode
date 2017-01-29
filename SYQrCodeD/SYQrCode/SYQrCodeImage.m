//
//  SYQrCodeImage.m
//  SYQrCodeD
//
//  Created by 孙宇 on 2017/1/28.
//  Copyright © 2017年 sunyu. All rights reserved.
//

#import "SYQrCodeImage.h"
#import "UIImage+SYQrCodeDiversification.h"
#import "UIImage+SYRoundImage.h"
#import <CoreImage/CoreImage.h>

@implementation SYQrCodeImage

+ (id)qrCodeImageWithConfigCallback:(SYQrCodeImageConfig * (^)())callback
{
    SYQrCodeImageConfig *config = callback();
    
    if (!config.link || (NSNull *)config.link == [NSNull null]) return nil;
    
    CGFloat codeSize = [self checkQrCodeImageSize:config.size];
    CIImage *image = [self drawQrCodeImageWithLink:config.link];
    UIImage *originImage = [self adjustClarityImageFromCIImage:image size:codeSize];
    
    UIImage *qrCodeImage = nil;
    if ((config.color1 == nil || config.color2 == nil) && config.fillImage == nil){
        qrCodeImage = [self imageDiversificationWithImage:originImage RGB:config.rgbValue];
    }else{
        UIImage *reFillImage = [self colorRedrawWithColor1:config.color1 color2:config.color2 byImage:config.fillImage];
        qrCodeImage = [self qrCodeFillImageWithQrCodeImage:originImage fillImage:reFillImage];
    }
    
    UIImage *insert = [self imageInsertedImage:qrCodeImage insertImage:config.centerImage radius:config.radius];
    UIImage *result = [self imageSetBackgroundImage:insert backgroundImage:config.backgroundImage];
    return result;//[self resetImageSize:codeSize byImage:result];
}

/**
 *  检查二维码尺寸是否符合规定
 *
 *  @param size 尺寸
 */
+ (CGFloat)checkQrCodeImageSize:(CGFloat)size
{
    size = (size==0)?1024:size;
    size = MAX(200, size);
    return size;
}


/**
 *  绘制二维码图片
 *
 *  @param link 二维码链接
 */
+ (CIImage *)drawQrCodeImageWithLink:(NSString *)link
{
    NSData * data = [link dataUsingEncoding: NSUTF8StringEncoding];
    CIFilter * filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
    return filter.outputImage;
}

/**
 *  调整清晰度，使其更加清晰
 *
 *  @param image 图片
 *  @param size  图片尺寸
 */
+ (UIImage *)adjustClarityImageFromCIImage:(CIImage *)image size: (CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef,(CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, extent, imageRef);
    CGImageRef imageRefResized = CGBitmapContextCreateImage(contextRef);
    //释放
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    return [UIImage imageWithCGImage:imageRefResized];
}


/**
 *  重置图片尺寸
 */
+ (UIImage *)resetImageSize:(CGFloat)size byImage:(UIImage *)image
{
    if (!image) return nil;
    if (size == 1024) return image;
    
    CGSize imageSize = CGSizeMake(size, size);
    UIGraphicsBeginImageContext(imageSize);
    [image drawInRect: (CGRect){ 0, 0, (imageSize) }];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}



@end
