# SYQrCodeDemo

SYQrCode 封装了二维码生成及扫描二维码

使用时导入 SYQrCode.h 头文件即可使用

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

#import "SYQrCodeImage.h" 生成二维码

添加 SYQrCodeImageConfig 配置类

生成二维码使用一下方法，通过callback返回配置参数即可生成二维码图片

+ (id)qrCodeImageWithConfigCallback:(SYQrCodeImageConfig * (^)())callback

大家如果觉得好用不要忘了star，另外如果有问题可以联系我QQ：1102210843，大家共同学习，谢谢













