//
//  ViewController.m
//  VImageDemo
//
//  Copyright (c) 2012 Shuichi Tsutsumi. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+vImage.h"

#ifdef THUMBNAIL_BIG
#define kWidth      106
#define kHeight     106
#define kInterval   1
#define kNumRow     3
#define kNumColumn  3
#else
#define kWidth      159
#define kHeight     159
#define kInterval   2
#define kNumRow     3
#define kNumColumn  2
#endif

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
            [self generateUIImageViewWithFrame:frame];
        }
    }
    
    self.orgImage = [UIImage imageNamed:@"lena_256.png"];
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
        
        switch (i) {
            case 1:
                imageView.image = [self.orgImage gaussianBlur];
//                [self saveImage:imageView.image filename:@"1"];
                break;
            case 2:
                imageView.image = [self.orgImage edgeDetection];
//                [self saveImage:imageView.image filename:@"2"];
                break;
            case 3:
                imageView.image = [self.orgImage emboss];
//                [self saveImage:imageView.image filename:@"3"];
                break;
            case 4:
                imageView.image = [self.orgImage sharpen];
//                [self saveImage:imageView.image filename:@"4"];
                break;
            case 5:
                imageView.image = [self.orgImage unsharpen];
//                [self saveImage:imageView.image filename:@"5"];
                break;
            default:
                break;
        }
        
        i++;
    }    
}

@end
