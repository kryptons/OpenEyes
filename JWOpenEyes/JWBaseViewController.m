//
//  JWBaseViewController.m
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "JWBaseViewController.h"
#import "JWTodayTableViewController.h"
#import "JWBaseNavigationViewController.h"

@interface JWBaseViewController ()

@property (strong, nonatomic) JWTodayTableViewController *todayVC;

@end

@implementation JWBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.todayVC = [[JWTodayTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    JWBaseNavigationViewController *baseNav = [[JWBaseNavigationViewController alloc] initWithRootViewController:self.todayVC];
    baseNav.navigationBar.translucent = NO;
    [self addChildViewController:baseNav];
    [self.view addSubview:baseNav.view];
    
}

@end
