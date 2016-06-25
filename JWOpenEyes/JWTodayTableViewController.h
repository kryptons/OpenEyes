//
//  JWTodayTableViewController.h
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PictureView;

@interface JWTodayTableViewController : UITableViewController

@property (nonatomic, strong) PictureView *pictureView;

@property (nonatomic, strong) UIImageView *blurredView;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end
