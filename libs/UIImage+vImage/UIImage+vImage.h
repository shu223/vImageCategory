//
//  UIImage+vImage.h
//
//  Copyright (c) 2012 Shuichi Tsutsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (vImage)

// Convolution Oprations
- (UIImage *)gaussianBlur;
- (UIImage *)edgeDetection;
- (UIImage *)emboss;
- (UIImage *)sharpen;
- (UIImage *)unsharpen;

// Geometric Operations
- (UIImage *)rotateInRadians:(float)radians;

// Morphological Operations
- (UIImage *)dilate;
- (UIImage *)erode;
- (UIImage *)dilateWithIterations:(int)iterations;
- (UIImage *)erodeWithIterations:(int)iterations;
- (UIImage *)gradientWithIterations:(int)iterations;
- (UIImage *)tophatWithIterations:(int)iterations;
- (UIImage *)blackhatWithIterations:(int)iterations;

// Histogram Operations
- (UIImage *)equalization;

@end
