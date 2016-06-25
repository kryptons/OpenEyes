//
//  RequestBLL.m
//  JWOpenEyes
//
//  Created by 陈文昊 on 16/6/25.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "RequestBLL.h"

#define serverURL @"http://192.168.1.1:8080/jiekou"

@implementation RequestBLL

/** 
 * POST请求
 */
+ (void)requestPOST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    // 请求超时时间
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 30;
    NSString *postURL = url;
    if (![url hasPrefix:@"http"]) {
        
        postURL = [NSString stringWithFormat:@"%@%@", serverURL, url];
    }
    
    NSMutableDictionary *dict = [params mutableCopy];
    
    // 发送post请求
    [manager POST:postURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 请求成功
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        if (success) {
            
            success(dictionary);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 请求失败
        failure(operation, error);
    }];
    
}

/**
 * GET请求
 */
+ (void)requestGET:(NSString *)url success:(void (^)(id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    // 获取请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setHTTPShouldHandleCookies:NO];
    manager.requestSerializer.timeoutInterval = 30;
    
    NSString *getURL = url;
    if (![url hasPrefix:@"http"]) {
        
        getURL = [NSString stringWithFormat:@"%@%@", serverURL, url];
    }
    
    // 发送GET请求
    [manager GET:getURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        if (success) {
            
            success(dictionary);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        if (!operation.responseObject) {
            
            NSLog(@"网络错误");
        }
        if (failure) {
            
            failure(operation, error);
        }
    }];
}


+ (void)requestUploadImage:(NSString *)url params:(NSDictionary *)params uploadImage:(UIImage *)image success:(void (^)(id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    // 创建请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    
    NSString *postURL = [NSString stringWithFormat:@"%@%@", serverURL, url];
    NSMutableDictionary *dict = [params mutableCopy];
    [manager POST:postURL parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
        [formData appendPartWithFileData:imageData name:@"img" fileName:@"head.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        if (success) {
            
            success(dictionary);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            
            failure(operation, error);
        }
    }];
    
    
}





















@end
