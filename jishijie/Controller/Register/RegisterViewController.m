//
//  RegisterViewController.m
//  jishijie
//
//  Created by zhx on 15/8/12.
//  Copyright (c) 2015年 zhx. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+PJR.h"

@interface RegisterViewController ()

{
    //是否已经发送短信验证码 1是 0否
    NSString *verifyType;
    //定时器
    NSTimer *_timer;
}
//获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *verifyCodeButton;
//注册按钮事件
- (IBAction)registerButton:(id)sender;
//获取验证码事件
- (IBAction)getVerifyCodeButton:(id)sender;
//点此登录事件
- (IBAction)clickToLoginButton:(id)sender;
//手机号码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;

@end

static int count = 0;

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

//获取验证码事件
- (IBAction)getVerifyCodeButton:(id)sender {
    //电话号码校验
    if([self.phoneNumberTextField.text isBlank])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"手机号码不能为空"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else if(![self.phoneNumberTextField.text validateMobile]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"手机号码不正确"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (![verifyType isEqualToString:@"1"]) {
        [_timer invalidate];
        count = 0;
        NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                          target:self
                                                        selector:@selector(updateTime)
                                                        userInfo:nil
                                                         repeats:YES];
        _timer = timer;
    }else if ([verifyType isEqualToString:@"1"]){
        NSLog(@"已经发送验证码");
    }
}
//点此登录事件
- (IBAction)clickToLoginButton:(id)sender {
    NSLog(@"点此登录");
}

//验证码按钮刷新
-(void)updateTime
{
    count++;
    if (count >= 60)
    {
        [_timer invalidate];
        [self.verifyCodeButton setTitle:@"再次发送" forState:UIControlStateNormal];
        verifyType = @"0";
        return;
    }
    
    [self.verifyCodeButton setTitle:[NSString stringWithFormat:@"%i",60-count] forState:UIControlStateNormal];
}

@end
