//
//  ViewController.m
//  GPUImage的使用
//
//  Created by 王志盼 on 17/06/2017.
//  Copyright © 2017 王志盼. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dealupImageOne];
}

#pragma mark -- GPUImage操作


/**
 高斯模糊
 */
- (void)dealupImageOne
{
    UIImage *image = [UIImage imageNamed:@"test"];
    
    // 使用GPUImage高斯模糊效果
    // 如果是对图像进行处理GPUImagePicture
    GPUImagePicture *picProcess = [[GPUImagePicture alloc] initWithImage:image];
    
    //添加需要处理的滤镜
    GPUImageGaussianBlurFilter *blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    // 纹理
    blurFilter.texelSpacingMultiplier = 5;
    blurFilter.blurRadiusInPixels = 5;
    [picProcess addTarget:blurFilter];
    
    //处理图片
    [blurFilter useNextFrameForImageCapture];
    [picProcess processImage];
    
    self.imageView.image = [blurFilter imageFromCurrentFramebuffer];
}

@end
