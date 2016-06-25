//
//  ContentScrollView.m
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "ContentScrollView.h"
#import "ImageContentView.h"
#import "TodayModel.h"


@interface ContentScrollView()

@property (nonatomic, assign, readwrite) NSInteger currentIndex;

@end

@implementation ContentScrollView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray index:(NSInteger)index {
    
    if (self = [super initWithFrame:frame]) {
        
        self.contentSize = CGSizeMake([imageArray count] * kWidth, 0);
        self.bounces = NO;
        self.pagingEnabled = YES;
        self.contentOffset = CGPointMake(index * kWidth, 0);
        
        for (int i = 0; i < [imageArray count]; i++) {
            
            ImageContentView *scrollView = [[ImageContentView alloc] initWithFrame:CGRectMake(i * kWidth, 0, kWidth, kHeight) width:35.0 model:imageArray[i] color:[UIColor whiteColor]];
            
            TodayModel *model = [[TodayModel alloc] init];
            model = imageArray[i];
            [scrollView.picture sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil];
            [self addSubview:scrollView];
        }
    }
    return self;
}

@end
