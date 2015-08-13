//
//  WriteUserInformationViewController.m
//  jishijie
//
//  Created by zhx on 15/8/10.
//  Copyright (c) 2015年 zhx. All rights reserved.
//

#import "WriteUserInformationViewController.h"
#import "CustomButton.h"
#import "UIImage+Addition.h"
#import "CommonUtil.h"
#import "TNRadioButtonGroup.h"

@interface WriteUserInformationViewController ()

@end

@implementation WriteUserInformationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI {
    [self setNavTitle:@"完成信息"];
    [self setLeftBarWithLeftImage:@"nav_icon_back" action:@selector(popBack)];
    [self setupForDismissKeyboard];
    CGRect rect = SCREEN_BOUNDS;
    self.view.backgroundColor = [UIColor whiteColor];
    
    backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, SCREEN_HEIGHT/2-150)];
    backgroundImageView.image = [UIImage imageNamed:@"img"];
    [self.view addSubview:backgroundImageView];
    
    logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(backgroundImageView.center.x-35
                                                                  , backgroundImageView.center.y-35, 80, 80)];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoImageView];
    
    CustomButton * userNameBtn = [CustomButton buttonWithType:UIButtonTypeCustom];
    [userNameBtn setFrame:CGRectMake(0, SCREEN_HEIGHT/2-145, rect.size.width, 40)];
    userNameBtn.imgView.frame = CGRectMake(15, 5, 31/1.6, 32/1.6);
    userNameBtn.tField.frame = CGRectMake(50, 0, rect.size.width-80, 30);
    userNameBtn.tField.font = [UIFont boldSystemFontOfSize:14];
    userNameBtn.tField.returnKeyType = UIReturnKeyDone;
    userNameBtn.tField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    userNameBtn.tField.borderStyle = UITextBorderStyleRoundedRect;
    userNameBtn.tField.placeholder = @"昵称";
    userNameBtn.imgView.image = [UIImage imageNamed:@"icon---Username"];
    
    [self.view addSubview:userNameBtn];
    [CommonUtil addLine:10 tox:SCREEN_WIDTH-10 y:SCREEN_HEIGHT/2-110 toY:SCREEN_HEIGHT/2-110 lineColor:[UIColor blackColor] mview:self.view];
    
    CustomButton * emaildBtn = [CustomButton buttonWithType:UIButtonTypeCustom];
    [emaildBtn setFrame:CGRectMake(0, SCREEN_HEIGHT/2-105, rect.size.width, 40)];
    emaildBtn.imgView.frame = CGRectMake(15, 5, 31/1.6, 32/1.6);
    emaildBtn.tField.frame = CGRectMake(50, 0, rect.size.width-80, 30);
    emaildBtn.tField.font = [UIFont boldSystemFontOfSize:14];
    emaildBtn.tField.placeholder = @"你的邮箱地址";
    emaildBtn.tField.returnKeyType = UIReturnKeyDone;
    emaildBtn.tField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    emaildBtn.tField.borderStyle = UITextBorderStyleRoundedRect;
    emaildBtn.imgView.image = [UIImage imageNamed:@"icon---Email---Full"];
  
    [self.view addSubview:emaildBtn];
    [CommonUtil addLine:10 tox:SCREEN_WIDTH-10 y:SCREEN_HEIGHT/2-70 toY:SCREEN_HEIGHT/2-70 lineColor:[UIColor blackColor] mview:self.view];
    
    CustomButton * passwordBtn = [CustomButton buttonWithType:UIButtonTypeCustom];
    [passwordBtn setFrame:CGRectMake(0, SCREEN_HEIGHT/2-65, rect.size.width, 40)];
    passwordBtn.imgView.frame = CGRectMake(15, 5, 31/1.6, 32/1.6);
    passwordBtn.tField.frame = CGRectMake(50, 0, rect.size.width-80, 30);
    passwordBtn.tField.font = [UIFont boldSystemFontOfSize:14];
    passwordBtn.tField.placeholder = @"设置密码";
    passwordBtn.tField.returnKeyType = UIReturnKeyDone;
    passwordBtn.tField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    passwordBtn.tField.borderStyle = UITextBorderStyleRoundedRect;
    passwordBtn.imgView.image = [UIImage imageNamed:@"icon---Password"];
    [self.view addSubview:passwordBtn];
    [CommonUtil addLine:10 tox:SCREEN_WIDTH-10 y:SCREEN_HEIGHT/2-30 toY:SCREEN_HEIGHT/2-30 lineColor:[UIColor blackColor] mview:self.view];

    CustomButton * confirmPasswordBtn = [CustomButton buttonWithType:UIButtonTypeCustom];
    [confirmPasswordBtn setFrame:CGRectMake(0, SCREEN_HEIGHT/2-25, rect.size.width, 40)];
    confirmPasswordBtn.imgView.frame = CGRectMake(15, 5, 31/1.6, 32/1.6);
    confirmPasswordBtn.tField.frame = CGRectMake(50, 0, rect.size.width-80, 30);
    confirmPasswordBtn.tField.font = [UIFont boldSystemFontOfSize:14];
    confirmPasswordBtn.tField.placeholder = @"确认密码";
    confirmPasswordBtn.tField.returnKeyType = UIReturnKeyDone;
    confirmPasswordBtn.tField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    confirmPasswordBtn.tField.borderStyle = UITextBorderStyleRoundedRect;
    confirmPasswordBtn.imgView.image = [UIImage imageNamed:@"icon---Password"];
    [self.view addSubview:confirmPasswordBtn];
    [CommonUtil addLine:10 tox:SCREEN_WIDTH-10 y:SCREEN_HEIGHT/2+10 toY:SCREEN_HEIGHT/2+10 lineColor:[UIColor blackColor] mview:self.view];
    
    sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT/2+15, 31/1.6, 32/1.6)];
    sexImageView.image = [UIImage imageNamed:@"icon---Gender---Full"];
    [self.view addSubview:sexImageView];
    [self createHorizontalList];
    commitButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-(SCREEN_WIDTH-60)/2, SCREEN_HEIGHT-150, SCREEN_WIDTH-60, 35)];
    [commitButton setTitle:@"确认" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [commitButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.443  green:0.718  blue:0.745 alpha:1]] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(CommitButton) forControlEvents:UIControlEventTouchUpInside];
    [commitButton.layer setMasksToBounds:YES];
    [commitButton.layer setCornerRadius:5];
    [self.view addSubview:commitButton];

    tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-(SCREEN_WIDTH-90)/2, SCREEN_HEIGHT-100, 90, 20)];
    tipLabel.text = @"我有极世界帐号,";
    tipLabel.textColor = COLOR_GRAY;
    tipLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:tipLabel];
}

- (void)createHorizontalList {
    TNImageRadioButtonData *maleData = [TNImageRadioButtonData new];
    maleData.labelText = @"男";
    maleData.identifier = @"male";
    maleData.selected = YES;
    maleData.unselectedImage = [UIImage imageNamed:@"icon_sel2"];
    maleData.selectedImage = [UIImage imageNamed:@"icon_sel"];
    
    TNImageRadioButtonData *femaleData = [TNImageRadioButtonData new];
    femaleData.labelText = @"女";
    femaleData.identifier = @"female";
    femaleData.selected = NO;
    femaleData.unselectedImage = [UIImage imageNamed:@"icon_sel2"];
    femaleData.selectedImage = [UIImage imageNamed:@"icon_sel"];
    sexGroup = [[TNRadioButtonGroup alloc] initWithRadioButtonData:@[maleData, femaleData] layout:TNRadioButtonGroupLayoutHorizontal];
    sexGroup.identifier = @"Sex group";
    [sexGroup create];
    sexGroup.position = CGPointMake(80, SCREEN_HEIGHT/2+20);
    [self.view addSubview:sexGroup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexGroupUpdated:) name:SELECTED_RADIO_BUTTON_CHANGED object:sexGroup];
    
    // show how update data works...
    
    [sexGroup update];
    
}

//确认按钮
- (void)CommitButton
{

}
//
- (void)sexGroupUpdated:(NSNotification *)notification {
    NSLog(@"Sex group updated to %@", sexGroup.selectedRadioButton.data.identifier);
}

@end
