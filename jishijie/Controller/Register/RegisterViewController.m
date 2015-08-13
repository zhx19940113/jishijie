//
//  RegisterViewController.m
//  jishijie
//
//  Created by zhx on 15/8/12.
//  Copyright (c) 2015年 zhx. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
- (IBAction)registerButton:(id)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//注册按钮事件
- (IBAction)registerButton:(id)sender {
   //拨打电话
    telprompt(@"13751814184");
}
@end
