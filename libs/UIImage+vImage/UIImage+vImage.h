//
//  UIImage+vImage.h
//  VImageDemo
//
//  Created by Shuichi Tsutsumi on 12/05/23.
//
//  本コードはNYXImagesHelperよりvImage関連個所を抽出し修正を加えたものです。
//  https://github.com/Nyx0uf/NYXImagesKit
//

#import <UIKit/UIKit.h>

@interface UIImage (vImage)

-(UIImage*)gaussianBlur;
-(UIImage*)edgeDetection;
-(UIImage*)emboss;
-(UIImage*)sharpen;
-(UIImage*)unsharpen;
-(UIImage*)rotateImagePixelsInRadians:(float)radians;

@end
