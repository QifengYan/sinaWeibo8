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

#define YQAuthClient_id     @"3165314916"
#define YQAuthClient_secret @"967afe2dd64a84f7be9e318e8e45ca2f"
#define YQAuthRedirect_uri  @"http://www.baidu.com/"


#pragma mark - 换取 accessToken
/// 换取accessToken
- (void)accessTokenWithCode:(NSString *)code {
   
    // 创建请求对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"client_id"] = YQAuthClient_id;
    parameters[@"client_secret"] = YQAuthClient_secret;
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = YQAuthRedirect_uri;
    
    // 错误信息 "Request failed: unacceptable content-type: text/plain"
    // 请求失败 确实响应类型
    //  创建一个响应类型
//    manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"text/plain", nil];
    
    
    
    // 发送post 请求
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 成功回调
        NSLog(@"success-- %@",responseObject);
        
        // 获取到数据 字典转模型
        YQAccount *account = [YQAccount accountWithDict:responseObject];
        
//        // 获取沙盒路径
//        NSString *docPath = ;
//        
//        // 拼接路径
//        NSString *filePath = ;
        
        // 保存用户信息 （归档）
        [YQAccountTool saveAccount:account];
        
        // 登陆成功 回调
        YQKeyWindow.rootViewController = [[YQWelcomeController alloc] init];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 错误回调
        NSLog(@"error-- %@",error);
    }];
    
    
}
@end
