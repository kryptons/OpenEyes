//
//  TodayTableViewCell.m
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "TodayTableViewCell.h"

@implementation TodayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // tableView.separatorStyle = UITableViewCellSeparatorStyleNone
        self.selectionStyle = UITableViewCellSelectionStyleNone; // 去掉选中效果
        self.clipsToBounds = YES;
        
        self.picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, -(kHeight / 1.7 - 250) / 2, kWidth, kHeight / 1.7)];
        
        self.picture.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.picture];
        
        self.coverview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 250)];
        self.coverview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
        [self.contentView addSubview:self.coverview];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 250 * 0.5 - 30, kWidth, 30)];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.littleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 250 * 0.5 + 30, kWidth, 30)];
        self.littleLabel.font = [UIFont systemFontOfSize:14.0];
        self.littleLabel.textAlignment = NSTextAlignmentCenter;
        self.littleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.littleLabel];
        
    }
    return self;
}

- (void)setModel:(TodayModel *)model {
    
    if (_model != model) {
        
        [self.picture sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil        ];
        self.titleLabel.text = model.title;
        
        // 转换时间
        NSInteger time = [model.duration integerValue];
        NSString *timeString = [NSString stringWithFormat:@"%02ld'%02ld''", time / 60, time % 60]; // 显示视频总时间
        NSString *string = [NSString stringWithFormat:@"#%@ / %@", model.category, timeString];
        self.littleLabel.text = string;
    }
}

- (CGFloat)cellOffset {
    
    CGRect centerToWindow = [self convertRect:self.bounds toView:self.window];
    CGFloat centerY = CGRectGetMidY(centerToWindow);
    CGPoint windowCenter = self.superview.center;
    
    CGFloat cellOffsetY = centerY - windowCenter.y;
    CGFloat offsetDig = cellOffsetY / self.superview.frame.size.height * 2;
    CGFloat offset = -offsetDig * (kHeight / 1.7 - 250) * 0.5;
    CGAffineTransform transY = CGAffineTransformMakeTranslation(0, offset);
    self.picture.transform = transY;
    return offset;
}

@end




















