//
//  BaseViewController.m
//  jishijie
//
//  Created by zhx on 15/8/10.
//  Copyright (c) 2015年 zhx. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //7.0以上版本通过一句代码解决高度上升问题
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        
        self.edgesForExtendedLayout                                        = UIRectEdgeNone;
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    float fPadding                                                     = 16.0;// 8.0px x 2
    CGSize constraint                                                  = CGSizeMake(textView.contentSize.width - fPadding, CGFLOAT_MAX);
    
    CGSize size                                                        = [strText sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    float fHeight                                                      = size.height + 16.0;
    
    return fHeight;
}


/**
 *  设置导航栏左边按钮功能
 *
 *  @param leftImage  图片
 *  @param leftAction 点击事件
 */
- (void)setLeftBarWithLeftImage:(NSString *)leftImage action:(SEL)leftAction
{
    UIButton *btn_back                                                 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_back.frame                                                     = CGRectMake(0, 0, 22, 22);
    if (leftImage) {
        [btn_back setBackgroundImage:[UIImage imageNamed:leftImage] forState:UIControlStateNormal];
    }
    if (leftAction) {
        [btn_back addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
    } else {
        [btn_back addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    }
    // btn_back.backgroundColor = [UIColor greenColor];
    
    UIBarButtonItem *backItem                                          = [[UIBarButtonItem alloc] initWithCustomView:btn_back];
    //  backItem.customView.backgroundColor = setCyanColor;
    self.navigationItem.leftBarButtonItem                              = backItem;
}

- (void)setLeftBarWithLeftTitle:(NSString *)leftTitle action:(SEL)leftAction
{
    UIButton *btn_back                                                 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_back.frame                                                     = CGRectMake(0, 0, 60, 22);
    if (leftTitle) {
        [btn_back setTitle:leftTitle forState:UIControlStateNormal];
    }
    
    
    if (leftAction) {
        [btn_back addTarget:self action:leftAction forControlEvents:UIControlEventTouchUpInside];
    } else {
        [btn_back addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    }
    // btn_back.backgroundColor = [UIColor greenColor];
    
    UIBarButtonItem *backItem                                          = [[UIBarButtonItem alloc] initWithCustomView:btn_back];
    backItem.customView.backgroundColor                                = [UIColor colorWithRed:56.0/255 green:62.0/255 blue:75.0/255 alpha:1.0];
    self.navigationItem.leftBarButtonItem                              = backItem;
}
/**
 *  设置导航栏右边的按钮功能
 *
 *  @param rightImage  图片
 *  @param rightAction 方法名 点击事件
 */
- (void)setRightBarWithRightImage:(NSString *)rightImage action:(SEL)rightAction
{
    UIButton *btn_rihgt                                                = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_rihgt.frame                                                    = CGRectMake(0, 0, 22, 22);
    if (rightImage) {
        [btn_rihgt setBackgroundImage:[UIImage imageNamed:rightImage] forState:UIControlStateNormal];
    }
    if(rightAction)
    {
        [btn_rihgt addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [btn_rihgt addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    }
    // btn_rihgt.backgroundColor = [UIColor greenColor];
    UIBarButtonItem *rightItem                                         = [[UIBarButtonItem alloc] initWithCustomView:btn_rihgt];
    self.navigationItem.rightBarButtonItem                             = rightItem;
    
}
/**
 *  设置导航栏右边按钮
 *
 *  @param title       标题
 *  @param target      目标对象
 *  @param rightAction 点击事件
 */
- (void)setRightBarTitle:(NSString *)title target:(id)target action:(SEL)rightAction
{
    UIBarButtonItem *rightItem                                         = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:rightAction];
    rightItem.tintColor                                                = [UIColor greenColor];
    self.navigationItem.rightBarButtonItem                             = rightItem;
    
}

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNavTitle:(NSString *)title
{
    CGRect rect                                                        = CGRectMake(SCREEN_WIDTH/2-100, 0, 150, 44);
    UILabel *titleLabel                                                = [[UILabel alloc] initWithFrame:rect];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.backgroundColor                                         = [UIColor clearColor];
    titleLabel.text                                                    = title;
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.adjustsFontSizeToFitWidth                               = YES;
    [self.navigationItem setTitleView:titleLabel];
}

- (void)setupForDismissKeyboard {
    NSNotificationCenter *nc                                           = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf                                  = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}
-(void)pushToViewController:(UIViewController *)vc anmation:(BOOL) anmation;
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled  = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self.navigationController pushViewController:vc animated:anmation];
}

- (void)dealloc
{
    NSLog(@"%@ is dealloc",self.description);
}

@end
