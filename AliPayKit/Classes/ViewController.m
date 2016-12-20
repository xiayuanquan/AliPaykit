//
//  ViewController.m
//  AliPayKit
//
//  Created by 夏远全  on 16/12/20.
//  Copyright © 2016年 广州市东德网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "PayManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [PayManager openAliPayForPaying];
}

@end
