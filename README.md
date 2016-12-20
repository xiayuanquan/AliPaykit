# AliPaykit
## 支付宝支付

### pch宏文件

     //
     
     //  Prefix header
     
     //  夏远全
     
     //  The contents of this file are implicitly included at the beginning of every source file.
     
     //

     #import <Availability.h>

     #ifndef __IPHONE_5_0
     
     #warning "This project uses features only available in iOS SDK 5.0 and later."
     
     #endif

    #ifdef __OBJC__
    
    #import <UIKit/UIKit.h>
    
    #import <Foundation/Foundation.h>
    
    #import <AlipaySDK/AlipaySDK.h> //支付宝SDK
    
    #import "PayManager.h"          //支付宝调起支付类
    
    #import "DataSigner.h"          //支付宝签名类
    
    #import "Order.h"               //订单模型
    
    #import "APAuthV2Info.h"        //授权模型

    /**
    
     -----------------------------------
     
     支付宝支付需要配置的参数
     
     -----------------------------------
     
    */

    //开放平台登录https://openhome.alipay.com/platform/appManage.htm

    //管理中心获取APPID
    
    #define AlipayAPPID      @""

    //管理中心获取PIDID
    
     #define PIDID           @""

    //支付宝私钥（用户自主生成，使用pkcs8格式的私钥）
    
    #define AlipayPrivateKey  @""

    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    
    #define URLScheme     @"AliPayKit"

    //支付宝支付接口
    
     #define AlipayUrl     @"alipay.trade.app.pay"

    #endif

### 演示截图
![image](https://github.com/xiayuanquan/AliPaykit/blob/master/AliPayKit/source/demo1.jpeg);

![image](https://github.com/xiayuanquan/AliPaykit/blob/master/AliPayKit/source/demo2.png);
