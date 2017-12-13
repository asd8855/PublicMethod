//
//  ViewController.m
//  PublicMethod
//
//  Created by libo on 2017/12/12.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<SKStoreProductViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark -- SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 在App内部加载App Store 展示信息，但不能直接跳转到评论编辑页面
 再加载处App Store 展示页面后，需要手动点击 评论-> 撰写评论
 */
- (IBAction)jump {
    //https://itunes.apple.com/cn/app/id1271598291?mt=8 校易收
    NSString *appId = @"1271598291";
    
    SKStoreProductViewController *storeVC = [[SKStoreProductViewController alloc]init];
    storeVC.delegate = self;
    //初始化参数
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    //跳转 App Store 页
    [storeVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"错误信息：%@",error.userInfo);
        }else {
            //弹出模态视图
            [self presentViewController:storeVC animated:YES completion:nil];
        }
    }];
}


/**
 可评论评分,无次数限制
 */
- (IBAction)jump2 {
    
    NSString *appStr = @"https://itunes.apple.com/cn/app/id1271598291?mt=8";
    NSString *scoreStr = @"https://itunes.apple.com/cn/app/id1271598291?mt=8&action=write-review";
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:scoreStr] options:@{} completionHandler:^(BOOL success) {
        }];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStr]];
    }
}


/**
 只能评分,不能编写评论
 有次数限制,一年只能使用三次
 使用次数超限后,需要跳转到appstore
 */
- (IBAction)jump3 {
    if (@available(iOS 10.3, *)) {
        if ([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {
            //防止键盘遮挡
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            [SKStoreReviewController requestReview];
        }
    } else {
        // Fallback on earlier versions
        [self jump2];
    }
}




@end
