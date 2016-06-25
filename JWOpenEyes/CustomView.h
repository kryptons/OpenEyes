//
//  CustomView.h
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UILabel  *label;

- (instancetype)initWithFrame:(CGRect)frame width:(CGFloat)width LabelString:(id)labelString collor:(UIColor *)collor;

- (void)setTitle:(id)title;

- (void)setColor:(UIColor *)color;

@end
