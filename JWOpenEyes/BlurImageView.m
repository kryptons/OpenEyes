//
//  BlurImageView.m
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "BlurImageView.h"

@implementation BlurImageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        // 设置图片
        self.image = [UIImage imageNamed:@"11471923,2560,1600.jpg"];
        // 创建模糊视图
        UIVisualEffectView *backVisual = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        // 将模糊视图的大小等于自身
        backVisual.frame = self.bounds;
        // 设置模糊视图的透明度
        backVisual.alpha = 1.0;
        [self addSubview:backVisual];
    }
    return self;
}

@end
