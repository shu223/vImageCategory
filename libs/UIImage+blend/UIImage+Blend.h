//
//  UIImage+Blend.h
//  Kuchibiru
//
//  Created by  on 11/08/26.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blend)

- (UIImage *)imageBlendedWithImage:(UIImage *)overlayImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

@end
