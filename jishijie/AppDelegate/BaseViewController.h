//
//  BaseViewController.h
//  jishijie
//
//  Created by zhx on 15/8/10.
//  Copyright (c) 2015年 zhx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface BaseViewController : UIViewController
@property MBProgressHUD *HUD;
/**
 *  设置导航栏左边按钮功能
 *
 *  @param leftImage  图片
 *  @param leftAction 点击事件
 */
- (void)setLeftBarWithLeftImage:(NSString *)leftImage action:(SEL)leftAction;
- (void)setLeftBarWithLeftTitle:(NSString *)leftTitle action:(SEL)leftAction;
/**
 *  设置导航栏右边的按钮功能
 *
 *  @param rightImage  图片
 *  @param rightAction 方法名 点击事件
 */
- (void)setRightBarWithRightImage:(NSString *)rightImage action:(SEL)rightAction;
/**
 *  设置导航栏右边按钮
 *
 *  @param title       标题
 *  @param target      目标对象
 *  @param rightAction 点击事件
 */
- (void)setRightBarTitle:(NSString *)title target:(id)target action:(SEL)rightAction;

/**
 *  点击隐藏键盘
 */
- (void)setupForDismissKeyboard;
/**
 *  返回上一个控制器
 */
- (void)popBack;
/**
 *  关闭模态控制器
 */
- (void)dismiss;
- (void)pushToViewController:(UIViewController *)vc anmation:(BOOL) anmation;
/**
 *  设置标题栏
 *
 *  @param title
 */
- (void)setNavTitle:(NSString *)title;

/**
 *  动态计算UItextView的高度
 *
 *  @param textView  UItextView
 *  @param strText   strText
 *
 *  @return UItextView的高度
 */
- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText;

@end
