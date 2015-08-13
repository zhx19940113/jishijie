//
//  WriteUserInformationViewController.h
//  jishijie
//
//  Created by zhx on 15/8/10.
//  Copyright (c) 2015年 zhx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TNRadioButtonGroup.h"

@interface WriteUserInformationViewController : BaseViewController
{
    TNRadioButtonGroup *sexGroup;
    UIImageView *backgroundImageView;
    UIImageView *logoImageView;
    UIImageView *userNameImageView;
    UITextField *userNameTextField;
    UIImageView *emailImageView;
    UITextField *emailTextField;
    UIImageView *setPasswordImageView;
    UITextField *setPasswordTextField;
    UIImageView *confirmPasswordImageView;
    UITextField *confirmPasswordTextField;
    UIImageView *sexImageView;
    UIButton *commitButton;
    UILabel *tipLabel;
}
@end
