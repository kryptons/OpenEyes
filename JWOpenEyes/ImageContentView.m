//
//  ImageContentView.m
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "ImageContentView.h"

@implementation ImageContentView

- (instancetype)initWithFrame:(CGRect)frame width:(CGFloat)width model:(TodayModel *)model color:(UIColor *)color {
    
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;  // 剪掉多余的View
        self.picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight / 1.7)];
        self.picture.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.picture];
    }
    return self;
}

/**
 * 图片偏移量
 */
- (void)imageOffset {
    
    CGRect centerToWindow = [self convertRect:self.bounds toView:nil];
    CGFloat centerX = CGRectGetMidX(centerToWindow);
    CGPoint windowCenter = self.window.center;
    
    CGFloat cellOffsetX = centerX - windowCenter.x;
    CGFloat offsetDig = cellOffsetX / self.window.frame.size.height * 2;
    
    CGAffineTransform transX = CGAffineTransformMakeTranslation(-offsetDig * kWidth * 0.7, 0);
    
    self.picture.transform = transX;
}

@end
