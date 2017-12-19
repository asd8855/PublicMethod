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
    
    CGFloat space = 5; //图片和文字的间距
    NSString *titleString = [NSString stringWithFormat:@"我是测试我是测试"];
    CGFloat titleWidth = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}].width;
    UIImage *btnImage = [UIImage imageNamed:@"xys_home_books_icon"];
    CGFloat imageWidth = btnImage.size.width;
    
    CGFloat imageHeight = btnImage.size.height;
    CGFloat titleHeight = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}].height;
    
    CGFloat btnWidth = 200; // 按钮的宽度
    if (titleWidth > btnWidth - imageWidth - space) {
        titleWidth = btnWidth - imageWidth - space;
    }
    
    UIButton *testButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, btnWidth, imageHeight + space + titleHeight)];
    testButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [testButton setBackgroundColor:[UIColor greenColor]];
    [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testButton setTitle:titleString forState:UIControlStateNormal];
    [testButton setImage:btnImage forState:UIControlStateNormal];
    [self.view addSubview:testButton];
    
    //按钮本身默认的是： 图片在左，文字在右。并且文字和图片的边缘是UIEdgeInsetsZero
    //top  left bottom right
    /*
        top： 为正数的时候，是往下偏移，为负数的时候往上偏移
        left： 为正数的时候往右偏移，为负数的时候往左偏移
        bottom：为正数的时候往上偏移，为负数的时候往下偏移
        right：为正数的时候往左偏移，为负数的时候往右偏移
     向相反的方面偏移为正数，相同的为负数
     */
    //文字在左，图片在右
//    [testButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageWidth + space *0.5), 0, (imageWidth + space * 0.5))];
//    [testButton setImageEdgeInsets:UIEdgeInsetsMake(0,(titleWidth + space * 0.5), 0, -(titleWidth + space * 0.5))];
    

//    //文字在上，图片在下
    [testButton setTitleEdgeInsets:UIEdgeInsetsMake(-(titleHeight + space) * 0.5, -imageWidth * 0.5, (titleHeight + space) * 0.5,imageWidth * 0.5)];
    [testButton setImageEdgeInsets:UIEdgeInsetsMake((imageHeight + space) * 0.5, titleWidth * 0.5, -(imageHeight + space) * 0.5, -titleWidth * 0.5)];
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
