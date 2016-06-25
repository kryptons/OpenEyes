//
//  JWTodayTableViewController.m
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "JWTodayTableViewController.h"
#import "KRVideoPlayerController.h"
#import "ContentScrollView.h"
#import "ContentView.h"
#import "ImageContentView.h"
#import "CustomView.h"

/******************  SDWebImage  *********************/

@interface SDWebImageManager (cache)

- (BOOL)memoryCacheImageExistsForURL:(NSURL *)url;

@end

@implementation SDWebImageManager (cache)

- (BOOL)memoryCacheImageExistsForURL:(NSURL *)url {
    
    NSString *key = [self cacheKeyForURL:url];
    return ([self.imageCache imageFromMemoryCacheForKey:key] != nil) ? YES : NO;
}

@end
/*******************************************************/

@interface JWTodayTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *selectDict;

@property (nonatomic, strong) NSMutableArray *dateArray;

@property (nonatomic, strong) KRVideoPlayerController *videoPlayer;

@end

@implementation JWTodayTableViewController

#pragma mark - 数据解析
- (NSMutableDictionary *)selectDict {
    
    if (!_selectDict) {
        
        _selectDict = [NSMutableDictionary dictionary];
    }
    return _selectDict;
}

- (NSMutableArray *)dateArray {
    
    if (!_dateArray) {
        
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}

- (KRVideoPlayerController *)videoPlayer {
    
    if (!_videoPlayer) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _videoPlayer = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width * (9.0 / 16.0))];
    }
    return _videoPlayer;
}

/**
 * 解析数据
 */
- (void)jsonSelection {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSString *url = [NSString stringWithFormat:kEveryDay, dateString];
    
    [RequestBLL requestGET:url success:^(id response) {
        
        NSDictionary *dict = (NSDictionary *)response;
        
        NSArray *array = dict[@"dailyList"];
        
        for (NSDictionary *dict1 in array) {
            
            NSMutableArray *selectArray = [NSMutableArray array];
            NSArray *videoArray = dict1[@"videoList"];
            
            for (NSDictionary *dict2 in videoArray) {
                
                TodayModel *model = [[TodayModel alloc] init];
                [model setValuesForKeysWithDictionary:dict2];
                model.collectionCount = dict2[@"consumption"][@"collectionCount"];
                model.replyCount      = dict2[@"consumption"][@"replyCount"];
                model.shareCount      = dict2[@"consumption"][@"shareCount"];
                [selectArray addObject:model];
            }
            NSString *date = [[dict1[@"date"] stringValue] substringToIndex:10];
            [self.selectDict setValue:selectArray forKey:date];
        }
        
        NSComparisonResult (^priceBlock)(NSString *, NSString *) = ^(NSString *string1, NSString *string2) {
            
            NSInteger number1 = [string1 integerValue];
            NSInteger number2 = [string2 integerValue];
            
            if (number1 > number2) {
                
                return NSOrderedAscending;
            }
            else if (number1 < number2) {
                
                return NSOrderedDescending;
            }
            else {
                
                return NSOrderedSame;
            }
        };
        
        self.dateArray = [[[self.selectDict allKeys] sortedArrayUsingComparator:priceBlock] mutableCopy];
        
        NSLog(@"%ld", [self.dateArray count]);
        
        [self.tableView reloadData]; // 加载数据
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error = %@", error);
    }];
}

#pragma mark - 加载页面
// 循环标识
static NSString *const JWRegister = @"register";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"主页";
    
    [self.tableView registerClass:[TodayTableViewCell class] forCellReuseIdentifier:JWRegister];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉分割线
    
    [self jsonSelection];
}


#pragma mark - Table view data source
// 多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.dateArray count];
}

// 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.selectDict[self.dateArray[section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    TodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JWRegister forIndexPath:indexPath];;
    
    return cell;
}

// 头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    // 转时间
    NSString *string = self.dateArray[section];
    long long int date1 = (long long int)[string intValue];
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMdd"];
    NSString *date = [dateFormatter stringFromDate:date2];
    
    return date;
}

// 索引条
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    
//    NSMutableArray *array = [NSMutableArray array];
//    // 转时间
//    for (NSString *string in self.dateArray) {
//        
//        long long int date1 = (long long int)[string intValue];
//        
//        NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"dd"];
//        NSString *date = [dateFormatter stringFromDate:date2];
//        
//        [array addObject:date];
//    }
//    
//    NSArray *backDate = [array copy];
//    
//    return backDate;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 250;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

// 添加每个cell出现时的3d动画
- (void)tableView:(UITableView *)tableView willDisplayCell:(TodayTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TodayModel *model = self.selectDict[self.dateArray[indexPath.section]][indexPath.row];
    
    if (![[SDWebImageManager sharedManager] memoryCacheImageExistsForURL:[NSURL URLWithString:model.coverForDetail]]) {
        
        CATransform3D rotation; // 3D旋转
        rotation = CATransform3DMakeTranslation(0, 50, 20);
        rotation = CATransform3DScale(rotation, 0.9, .9, 1);
        rotation.m34 = 1.0 / -600;
        
        cell.layer.shadowColor = [[UIColor orangeColor] CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        
        cell.layer.transform = rotation;
        [UIView beginAnimations:@"rotation" context:nil];
        [UIView setAnimationDuration:0.5];
        cell.layer.transform = CATransform3DIdentity; // 停止动画
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
    }
    
    [cell cellOffset];
    cell.model = model;
}

#pragma mark - 单元格代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self showImageAtIndexPath:indexPath];
}

#pragma mark - 设置待播放界面
- (void)showImageAtIndexPath:(NSIndexPath *)indexPath {
    
    self.array = self.selectDict[self.dateArray[indexPath.section]];
    self.currentIndexPath = indexPath;
    
    TodayTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [cell convertRect:cell.bounds toView:nil];
    CGFloat y = rect.origin.y;
    
    self.pictureView = [[PictureView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) imageArray:self.array index:indexPath.row];
    self.pictureView.offsetY = y;
    self.pictureView.animationTrans = cell.picture.transform;
    self.pictureView.animationView.picture.image = cell.picture.image;
    self.pictureView.scrollView.delegate = self;
    
    [[self.tableView superview] addSubview:self.pictureView];
    
    // 添加轻扫手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    
    self.pictureView.contentView.userInteractionEnabled = YES;
    swipe.direction = UISwipeGestureRecognizerDirectionUp; // 向上轻扫
    [self.pictureView.contentView addGestureRecognizer:swipe];
    
    // 添加点击播放手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.pictureView.scrollView addGestureRecognizer:tap];
    
    [self.pictureView animationShow];
}

#pragma mark - 平移手势触发事件
- (void)swipeAction:(UISwipeGestureRecognizer *)swipe {
    
    [self.pictureView animationDismissUsingCompleteBlock:^{
        
        self.pictureView = nil;
        [self.videoPlayer dismiss];
    }];
}

#pragma mark - 点击手势触发事件
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    // 当前选中的cell
    TodayModel *model = [self.array objectAtIndex:self.currentIndexPath.row];
    
    [self.videoPlayer showInWindow];
    self.videoPlayer.contentURL = [NSURL URLWithString:model.playUrl];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.pictureView.scrollView]) {
        
        for (ImageContentView *subView in scrollView.subviews) {
            
            if ([subView respondsToSelector:@selector(imageOffset)]) {
                
                [subView imageOffset];
            }
        }
        
        CGFloat x = self.pictureView.scrollView.contentOffset.x;
        CGFloat off = ABS( ((int)x % (int)kWidth) - kWidth/2) /(kWidth/2) + .2;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.pictureView.playView.alpha = off;
            self.pictureView.contentView.titleLabel.alpha = off + 0.3;
            self.pictureView.contentView.littleLabel.alpha = off + 0.3;
            self.pictureView.contentView.lineView.alpha = off + 0.3;
            self.pictureView.contentView.descriptionLabel.alpha = off + 0.3;
            self.pictureView.contentView.collectionCustom.alpha = off + 0.3;
            self.pictureView.contentView.shareCustom.alpha = off + 0.3;
            self.pictureView.contentView.cacheCustom.alpha = off + 0.3;
            self.pictureView.contentView.replyCustom.alpha = off + 0.3;
        }];
    }
    else {
        
        NSArray <TodayTableViewCell *> *array = [self.tableView visibleCells];
        [array enumerateObjectsUsingBlock:^(TodayTableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [obj cellOffset];
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.pictureView.scrollView]) {
        
        int index = floor((self.pictureView.scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;
        
        self.pictureView.scrollView.currentIndex = index;
        self.currentIndexPath = [NSIndexPath indexPathForRow:index inSection:self.currentIndexPath.section];
        [self.tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        [self.tableView setNeedsDisplay];
        
        TodayTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.currentIndexPath];
        
        [cell cellOffset];
        
        CGRect rect = [cell convertRect:cell.bounds toView:nil];
        self.pictureView.animationTrans = cell.picture.transform;
        self.pictureView.offsetY = rect.origin.y;
        
        TodayModel *model = self.array[index];
        [self.pictureView.contentView setData:model];
        [self.pictureView.animationView.picture sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail]];
    }
}

@end
