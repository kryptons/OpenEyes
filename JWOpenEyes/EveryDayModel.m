//
//  EveryDayModel.m
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "EveryDayModel.h"

@implementation EveryDayModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"description"]) {
        
        self.descrip = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        
        self.ID = [value stringValue];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"duration"]) {
        
        self.duration = [value stringValue];
    }
}

@end
