//
//  YQOauthController.m
//  sinaWeibo8
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQOauthController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "YQAccount.h"
#import "YQAccountTool.h"
#import "YQWelcomeController.h"

@interface YQOauthController ()<UIWebViewDelegate>

@end

@implementation YQOauthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个webView
    UIWebView *webView  = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    // 添加到控制器上
    [self.view addSubview:webView];
    
    //请求 例子
    // https://api.weibo.com/oauth2/authorize?client_id=123050457758183&redirect_uri=http://www.example.com/response&response_type=code
    // url拼接参数
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"3165314916";  // 申请应用时分配的AppKey
    NSString *redirect_uri = @"http://www.baidu.com/"; // 授权回调地址，
    
    // 拼接url 字符串
    NSString *urlString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    
    // 创建url
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 创建网络请求
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    // 加载webView
    [webView loadRequest:urlRequest];
    
    // 设置代理
    webView.delegate = self;
}

#pragma mark - UIWebViewDelegate 代理方法
/// 开始加载时候调用
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // 提示用户 正在加载
    [MBProgressHUD showMessage:@"正在加载..."];
}

/// 加载完成时调用
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [MBProgressHUD hideHUD];
}

/// 加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [MBProgressHUD hideHUD];
}

/// webView 发送请求 是否需要加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlStr = request.URL.absoluteString;

//    NSLog(@"test- %@",urlStr);
    
    // 授权之后的回调结果 http://www.baidu.com/?code=1522a03706024256cce94db457b434c9
    // 判断 字符串中是否有 code=
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        // 截取code
        NSString *code = [urlStr substringFromIndex:(range.location + range.length)];
       // 换取accessToken       6bf5b8d0eaff0a3f1e61a941f3d97218
        [self accessTokenWithCode:code];
        
        return NO; // 返回NO 请求失败 错误回调
    }
    
    return YES;
}




#pragma mark - 换取 accessToken
/// 换取accessToken
- (void)accessTokenWithCode:(NSString *)code {
   
    
    [YQAccountTool accountWithCode:code success:^{
        // 登陆成功 回调
        YQKeyWindow.rootViewController = [[YQWelcomeController alloc] init];
        
    } failurl:^(NSError *error) {
        // 错误回调
        NSLog(@"error-- %@",error);
    }];
    
}
@end
