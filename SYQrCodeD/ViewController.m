//
//  ViewController.m
//  SYQrCodeD
//
//  Created by sunyu on 16/5/17.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "ViewController.h"
#import "SYQrCode.h"

@interface ViewController ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController
{
    UIImageView *imageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 100, 100);
    [button setTitle:@"扫码" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(goScanne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(200, 100, 100, 100);
    [button1 setTitle:@"生成二维码" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor cyanColor];
    [button1 addTarget:self action:@selector(drawImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(button1.frame)+10, 375, 375)];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveQrCodeImage:)];
    
    [imageView addGestureRecognizer:tap];
    
}

- (void)drawImage:(UIButton *)button
{
    UIImage *image = nil;
    
    NSString *link = @"https://www.baidu.com/link?url=lV1hUtb7iigXGP4d0VcBTUTx4XLopvHysOIU3N3LJvBIWj7MuKzSyU14BAvCkeXgbhDwNpwBEpdUAXmnzeElWa&wd=&eqid=dab5812100009e37000000025731c53d";
    
    switch (_count) {
        case 0:
            image = [UIImage generateImageWithQrCode:link QrCodeImageSize:0];
            break;
        case 1:
            image = [UIImage generateImageWithQrCode:link QrCodeImageSize:0 RGB:@"#ee68ba"];
            break;
        case 2:
            image = [UIImage generateImageWithQrCode:link QrCodeImageSize:0 insertImage:[UIImage imageNamed:@"backImage"] radius:16];
            break;
        case 3:
            image = [UIImage generateImageWithQrCode:link QrCodeImageSize:0 RGB:@"#ee68ba" insertImage:[UIImage imageNamed:@"backImage"] radius:16];
            break;
        case 4:
            image = [UIImage generateImageWithQrCode:link QrCodeImageSize:0 backgroundImage:[UIImage imageNamed:@"backImage"]];
            break;
        case 5:
            image = [UIImage generateImageWithQrCode:link QrCodeImageSize:0 RGB:@"#ee68ba" backgroundImage:[UIImage imageNamed:@"backImage"] insertImage:[UIImage imageNamed:@"backImage"] radius:16];
            break;
        case 6:
            image = [UIImage generateImageWithQrCode:link QrCodeImageSize:0 fillImage:[UIImage imageNamed:@"形状111"]];
            break;
        case 7:
            image = [UIImage generateImageWithQrCode:link QrCodeImageSize:0 fillImage:[UIImage imageNamed:@"形状222"] color1:@"#1dacea" color2:@"#2d9f7c"];
            break;
        case 8:
            image = [UIImage generateImageWithQrCode:link QrCodeImageSize:0 fillImage:[UIImage imageNamed:@"形状111"] color1:nil color2:nil backgroundImage:[UIImage imageNamed:@"backImage"]];
            break;
        case 9:
            image = [UIImage generateImageWithQrCode:link QrCodeImageSize:0 fillImage:[UIImage imageNamed:@"形状222"] color1:@"#d40606" color2:@"#a10acc" backgroundImage:[UIImage imageNamed:@"backImage"] insertImage:[UIImage imageNamed:@"backImage"] radius:16];
            break;
    }
    
    _count=(_count==9)?0:(_count+1);
    
    [imageView setImage:image];
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
}


- (void)goScanne
{
    SYQrCodeScanne *VC = [[SYQrCodeScanne alloc]init];
    VC.scanneScusseBlock = ^(SYCodeType codeType, NSString *url){
        
        NSLog(@"%@", url);
        if (SYCodeTypeUnknow == codeType) {
            NSLog(@"二维码无法识别");
        }else if (SYCodeTypeLink == codeType) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        }else{
            
        }
    };
    [VC scanning];
}



- (void)saveQrCodeImage:(UITapGestureRecognizer *)tap
{
    if (imageView.image != nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"保存到手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }];
        [alert addAction:action];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action1];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存失败  %@", error);
    }else{
        NSLog(@"保存成功");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
