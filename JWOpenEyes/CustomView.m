//
//  CustomView.m
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame width:(CGFloat)width LabelString:(id)labelString collor:(UIColor *)collor {
    
    if (self = [super initWithFrame:frame]) {
        
        CGFloat totalWidth = self.frame.size.width;
        CGFloat totalHeight = self.frame.size.height;
        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(0, 0, width, totalHeight);
        _button.tintColor = collor;
        [self addSubview:_button];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(width, 0, totalWidth - width, totalHeight)];
        _label.textColor = collor;
        NSString *text = [NSString stringWithFormat:@"%@", labelString];
        _label.text = text;
        _label.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_label];
    }
    return self;
}

- (void)setTitle:(id)title {
    
    self.label.text = [NSString stringWithFormat:@"%@",title];
}

- (void)setColor:(UIColor *)color {
    
    self.button.tintColor = color;
    self.label.textColor  = color;
}

@end







