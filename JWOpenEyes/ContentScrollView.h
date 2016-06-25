//
//  ContentScrollView.h
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageContentView;
@class ContentScrollView;

/**
 * 代理设置模式
 */
@protocol ContentScrollViewDelegate <UIScrollViewDelegate>

- (void)headerScroll:(ContentScrollView *)scroll didSelectItemAtIndex:(NSInteger)index;

- (void)headerScroll:(ContentScrollView *)scroll didClose:(BOOL)close;

@end

@interface ContentScrollView : UIScrollView

@property (nonatomic, assign, readonly) NSInteger currentIndex;

- (void)setCurrentIndex:(NSInteger)currentIndex;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray index:(NSInteger)index;

@end
