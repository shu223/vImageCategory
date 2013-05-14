//
//  ViewController.m
//  VImageDemo
//
//  Copyright (c) 2012 Shuichi Tsutsumi. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+vImage.h"

//#define THUMBNAIL_BIG
//#define SAVE_IMAGE

#ifndef THUMBNAIL_BIG
#define kWidth      106
#define kHeight     106
#define kInterval   1
#define kNumRow     4
#define kNumColumn  3
#else
#define kWidth      159
#define kHeight     159
#define kInterval   2
#define kNumRow     3
#define kNumColumn  2
#endif

#define kImageFilaname1 @"bw.png"
#define kImageFilaname2 @"dog.png"
#define kImageFilaname3 @"lena.png"
#define kImageFilaname4 @"dot.png"


@interface ViewController ()

@property (nonatomic, strong) UIImage *orgImage;

@end

@implementation ViewController

@synthesize orgImage;
@synthesize startBtn;


- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = CGRectMake(0, 0, kWidth, kHeight);
    for (int j=0; j<kNumRow; j++) {
        for (int i=0; i<kNumColumn; i++) {
            CGPoint origin = CGPointMake((kWidth + kInterval) * i, (kHeight + kInterval) * j);
            frame.origin = origin;
            UIImageView *imageView = [self generateUIImageViewWithFrame:frame];
            UILabel *label = [self generateUILabelWithFrame:CGRectMake(0, 0, kWidth, 20)];
            label.adjustsFontSizeToFitWidth = YES;
            [imageView addSubview:label];
        }
    }
    
    self.orgImage = [UIImage imageNamed:kImageFilaname3];

    [self reset];
    
    [self.view bringSubviewToFront:self.startBtn];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.orgImage = nil;
}

- (void)dealloc
{    
    [self viewDidUnload];
}


#pragma mark -------------------------------------------------------------------
#pragma mark Private

- (UIImageView *)generateUIImageViewWithFrame:(CGRect)frame {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:imageView];
    
    return imageView;
}

- (UILabel *)generateUILabelWithFrame:(CGRect)frame {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Futura-Medium" size:17.0f];
    
    return label;
}

- (void)reset {

    for (UIView *aSubview in self.view.subviews) {
        
        if ([aSubview isKindOfClass:[UIImageView class]]) {
            
            UIImageView *imageView = (UIImageView *)aSubview;
            imageView.image = self.orgImage;
        }
    }
}

- (void)saveImage:(UIImage *)image filename:(NSString *)filename {
    
    NSData *data = UIImagePNGRepresentation(image);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.png",
                          [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],
                          filename];
    if ([data writeToFile:filePath atomically:YES]) {
        NSLog(@"OK");
    } else {
        NSLog(@"Error");
    }                
}


#pragma mark -------------------------------------------------------------------
#pragma mark Action

- (IBAction)pressBtn {

    self.startBtn.hidden = YES;

    NSInteger i = 0;
    for (UIView *aSubview in self.view.subviews) {
        
        if (![aSubview isKindOfClass:[UIImageView class]]) {
            continue;
        }

        UIImageView *imageView = (UIImageView *)aSubview;
        
        NSString *title;
        switch (i) {
            case 0:
                title = @"original";
                break;
            case 1:
                imageView.image = [self.orgImage gaussianBlur];
                title = @"gaussianBlur";
                break;
            case 2:
                imageView.image = [self.orgImage edgeDetection];
                title = @"edgeDetection";
                break;
            case 3:
                imageView.image = [self.orgImage emboss];
                title = @"emboss";
                break;
            case 4:
                imageView.image = [self.orgImage sharpen];
                title = @"sharpen";
                break;
            case 5:
                imageView.image = [self.orgImage unsharpen];
                title = @"unsharpen";
                break;
            case 6:
                imageView.image = [self.orgImage rotateInRadians:M_PI_2 * 0.3];
                title = @"rotate";
                break;
            case 7:
                imageView.image = [self.orgImage dilateWithIterations:3];
                title = @"dilate";
                break;
            case 8:
                imageView.image = [self.orgImage erodeWithIterations:3];
                title = @"erode";
                break;
            case 9:
                imageView.image = [self.orgImage gradientWithIterations:3];
                title = @"gradient";
                break;
            case 10:
                imageView.image = [self.orgImage tophatWithIterations:4];
                title = @"tophat";
                break;
            case 11:
                imageView.image = [self.orgImage equalization];
                title = @"equalization";
                break;
            default:
                break;
        }
        
        
        for (UIView *aSubSubView in imageView.subviews) {
            if ([aSubSubView isKindOfClass:[UILabel class]]) {
                [(UILabel *)aSubSubView setText:title];
            }
        }
        
#ifdef SAVE_IMAGE
        [self saveImage:imageView.image filename:title];
#endif

        
        i++;
    }    
}

@end
