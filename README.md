# SYQrCodeDemo

SYQrCode 封装了二维码生成及扫描二维码

# 扫描二维码 SYQrCodeScanne

扫描二维码支持摄像头扫描，相册选择图片扫描

使用扫描二维码，复制以下代码

SYQrCodeScanne *VC = [[SYQrCodeScanne alloc]init];

block scanneScusseBlock 为nil时，自动调用[[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];

VC.scanneScusseBlock = ^(SYCodeType codeType, NSString *url){

if (SYCodeTypeUnknow == codeType) { //未知的二维码，即二维码解析失败

NSLog(@"二维码无法识别");

}else if (SYCodeTypeLink == codeType) {   //解析出的字符串以 http:// 或 https:// 为前缀的

[[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];

}else{  //普通字符串类型

}

};

[VC scanning];


扫描二维码可支持条形码类型，修改以下代码即可

// 3.1.设置输入元数据的类型(类型是二维码与条形码数据)

[output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];

//[output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code]];


# 生成二维码

#import "UIImage+SYGenerateQrCode.h" 生成二维码
二维码有多种样式生成方法，可自行选择 

#import "UIImage+SYQrCodeDiversification.h"  二维码多样化
可直接对二维码图片进行编辑，改变样式，可自行组合

# 注：
使用二维码多样化改变二维码图片样式时，最后一定要调用  + (UIImage *)imageSetBackgroundImage:(UIImage *)originImage
backgroundImage:(UIImage *)backgroundImage 方法，backgroundImage可为nil，在修改图片样式时最终生成的图片无法保存，必须使用此方法添加背景图片

大家如果觉得好用不要忘了star，另外如果有问题可以联系我QQ：1102210843，大家共同学习，谢谢













