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

@end
