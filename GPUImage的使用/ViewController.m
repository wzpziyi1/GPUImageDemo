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


@property (nonatomic, strong) GPUImageStillCamera *camera;

//美白滤镜
@property (nonatomic, strong) GPUImageBrightnessFilter *filter;
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
    [self beautyCamera];
}

#pragma mark -- GPUImage操作


- (IBAction)takePhoto:(id)sender
{
    [self.camera capturePhotoAsImageProcessedUpToFilter:self.filter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        UIImageWriteToSavedPhotosAlbum(processedImage, nil, nil, nil);
        self.imageView.image = processedImage;
        [self.camera stopCameraCapture];
    }];
}

/**
 美颜相机效果
 */
- (void)beautyCamera
{
    self.camera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    [self.camera addTarget:self.filter];
    
    // 创建GPUImageView,用于显示实时画面
    GPUImageView *showView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:showView atIndex:0];
    [self.filter addTarget:showView];
    
    //开始补抓画面
    [self.camera startCameraCapture];
}

- (GPUImageStillCamera *)camera
{
    if (!_camera)
    {
        _camera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    }
    return _camera;
}

- (GPUImageBrightnessFilter *)filter
{
    if (!_filter)
    {
        _filter = [[GPUImageBrightnessFilter alloc] init];
        //美白、曝光度
        _filter.brightness = 0.7;
    }
    return _filter;
}

//-------分隔线-------
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
    
    /*其他滤镜效果
     GPUImageSepiaFilter
     GPUImageToonFilter
     GPUImageSketchFilter
     GPUImageEmbossFilter
     */
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
