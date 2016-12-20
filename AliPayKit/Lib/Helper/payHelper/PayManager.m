//
//  PayManager.m
//  AliPayKit
//
//  Created by 夏远全 on 16/12/20.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//

#import "PayManager.h"

@implementation PayManager

#pragma mark - 进行支付

+(void)openAliPayForPaying{
    
    /*=========================================================*/
    /*====客户端调用支付宝支付（实际操作请放到服务端）=================*/
    /*=========================================================*/
    

    //AppId和PrivateKey没有配置下的提示
    if ([AlipayAPPID length] == 0 || [AlipayPrivateKey length] == 0)
    {
        [self alertShow];
        return;
    }

    //将商品信息赋予AlixPayOrder的成员变量
    Order* order    = [Order new];
    order.app_id    = AlipayAPPID;  // NOTE: app_id设置
    order.method    = AlipayUrl;    // NOTE: 支付接口名称
    order.charset = @"utf-8";       // NOTE: 参数编码格式
    
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];// NOTE: 当前时间点
    
    order.version   = @"1.0";       // NOTE: 支付版本
    order.sign_type = @"RSA";       // NOTE: sign_type设置
    
    // NOTE: 商品数据
    order.biz_content                   = [BizContent new];
    order.biz_content.body              = @"我是测试数据";
    order.biz_content.subject           = @"1";
    order.biz_content.out_trade_no      = [self generateTradeNO];   //订单ID（由商家自行制定）
    order.biz_content.timeout_express   = @"30m";                   //超时时间设置
    order.biz_content.total_amount      = [NSString stringWithFormat:@"%.2f", 0.01];//商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo         = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded  = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(AlipayPrivateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = URLScheme;
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

#pragma mark - 随机字符串
//==============产生随机订单号==============
+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


#pragma mark - 提示信息
+(void)alertShow{
    
//去除警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    //AppId和PrivateKey没有配置下的提示
    if ([AlipayAPPID length] == 0 || [AlipayPrivateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
#pragma clang diagnostic pop
}

@end
