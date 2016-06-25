//
//  ImageContentView.h
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentView;
@class TodayModel;

@interface ImageContentView : UIView

@property (nonatomic, strong) UIImageView *picture;

- (instancetype)initWithFrame:(CGRect)frame width:(CGFloat)width model:(TodayModel *)model color:(UIColor *)color;

/**
 * 图片偏移量
 */
- (void)imageOffset;

@end
