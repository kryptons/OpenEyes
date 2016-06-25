//
//  PictureView.m
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "PictureView.h"
#import "ContentView.h"
#import "ContentScrollView.h"
#import "TodayModel.h"
#import "TodayTableViewCell.h"

@implementation PictureView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray index:(NSInteger)index {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds = YES;
        self.scrollView = [[ContentScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64) imageArray:imageArray index:index];
        self.scrollView.userInteractionEnabled = YES;
        [self addSubview:self.scrollView];
        
        TodayModel *model = imageArray[index];
        self.contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, kHeight / 1.7, kWidth, kHeight - kHeight / 1.7) width:35 model:model color:[UIColor whiteColor]];
        [self.contentView setData:model];
        [self addSubview:self.contentView];
        
        self.playView = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth - 100) / 2, (kHeight/1.7 - 100) / 2 + 64, 100, 100)];
        self.playView.image = [UIImage imageNamed:@"video-play"];
        [self addSubview:self.playView];
        
        self.animationView = [[TodayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [self.animationView.coverview removeFromSuperview];
        [self addSubview:_animationView];
        self.playView.alpha = 0;
        self.scrollView.alpha = 0;
    }
    return self;
}

- (void)animationShow {
    
    self.contentView.frame = CGRectMake(0, self.offsetY, kWidth, 250);
    self.animationView.frame = CGRectMake(0, self.offsetY, kWidth, 250);
    self.animationView.picture.transform = self.animationTrans;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.animationView.frame = CGRectMake(0, 64, kWidth, kHeight / 1.7);
        self.animationView.picture.transform = CGAffineTransformMakeTranslation(0, (kHeight / 1.7 - 250) * 0.5);
        self.contentView.frame = CGRectMake(0, kHeight / 1.7 + 64, kWidth, kHeight - kHeight / 1.7 - 64);
    
    } completion:^(BOOL finished) {
        
        self.scrollView.alpha = 1;
        [UIView animateWithDuration:0.25 animations:^{
            
            self.animationView.alpha = 0;
            self.playView.alpha = 1;
        }];
    }];
}

- (void)animationDismissUsingCompleteBlock:(void (^)(void))complete {
    
    [UIView animateWithDuration:0.25 animations:^{
    
        self.animationView.alpha = 1;
    } completion:^(BOOL finished) {
        
        self.scrollView.alpha = 0;
        self.playView.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect rect = self.animationView.frame;
            rect.origin.y = self.offsetY;
            rect.size.height = 250;
            self.animationView.frame = rect;
            self.animationView.picture.transform = self.animationTrans;
            self.contentView.frame = rect;
            
        } completion:^(BOOL finished) {
            
            self.animationTrans = CGAffineTransformIdentity;
            [self.contentView removeFromSuperview];
            [UIView animateWithDuration:0.25 animations:^{
                
                self.animationView.alpha = 0;
            } completion:^(BOOL finished) {
                
                [self removeFromSuperview];
                complete();
            }];
        }];
    }];
}

@end




















