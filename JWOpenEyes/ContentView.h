//
//  ContentView.h
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomView;
@interface ContentView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *littleLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) CustomView *collectionCustom;

@property (nonatomic, strong) CustomView *shareCustom;

@property (nonatomic, strong) CustomView *cacheCustom;

@property (nonatomic, strong) CustomView *replyCustom;

- (instancetype)initWithFrame:(CGRect)frame
                        width:(CGFloat)width
                        model:(TodayModel *)model
                        color:(UIColor *)color;

- (void)setData:(TodayModel *)model;

@end
