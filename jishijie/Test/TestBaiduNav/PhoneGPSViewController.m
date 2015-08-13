//
//  ViewController.m
//  NaviDemo
//
//  Created by Baidu on 14/12/18.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "PhoneGPSViewController.h"
#import "BNRoutePlanModel.h"
#import "BNCoreServices.h"

@interface PhoneGPSViewController ()<BNNaviUIManagerDelegate,BNNaviRoutePlanDelegate>

//导航类型，分为模拟导航和真实导航
@property (assign, nonatomic) BN_NaviType naviType;

@end


@implementation PhoneGPSViewController

- (UIButton*)createButton:(NSString*)title target:(SEL)selector frame:(CGRect)frame
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [button setBackgroundColor:[UIColor whiteColor]];
    }else
    {
        [button setBackgroundColor:[UIColor clearColor]];
    }
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"手机GPS导航";
    
    UILabel* startNodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, self.view.frame.size.width, 30)];
    startNodeLabel.backgroundColor = [UIColor clearColor];
    startNodeLabel.text = @"起点：国人通信大厦";
    startNodeLabel.textAlignment = NSTextAlignmentCenter;
    startNodeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:startNodeLabel];
    
    
    UILabel* endNodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(startNodeLabel.frame.origin.x, startNodeLabel.frame.origin.y+startNodeLabel.frame.size.height, self.view.frame.size.width, startNodeLabel.frame.size.height)];
    endNodeLabel.backgroundColor = [UIColor clearColor];
    endNodeLabel.text = @"终点：上海宾馆";
    endNodeLabel.textAlignment = NSTextAlignmentCenter;
    endNodeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:endNodeLabel];
    
    CGSize buttonSize = {120,40};
    CGRect buttonFrame = {(self.view.frame.size.width-buttonSize.width*2-30)/2,40+endNodeLabel.frame.size.height+endNodeLabel.frame.origin.y,buttonSize.width,buttonSize.height};
    UIButton* simulatorNaviButton = [self createButton:@"模拟导航" target:@selector(simulateNavi:)  frame:buttonFrame];
    [self.view addSubview:simulatorNaviButton];
    
    buttonFrame.origin.x+=buttonFrame.size.width+30;
    UIButton* realNaviButton = [self createButton:@"真实导航" target:@selector(realNavi:) frame:buttonFrame];
    [self.view addSubview:realNaviButton];
    
    buttonFrame.origin.y+=buttonFrame.size.height+30;
    buttonFrame.origin.x = simulatorNaviButton.frame.origin.x;
    buttonFrame.size.width = self.view.frame.size.width - buttonFrame.origin.x * 2;
    UIButton* digitDogButton = [self createButton:@"电子狗" target:@selector(digitDog:) frame:buttonFrame];
    [self.view addSubview:digitDogButton];
}

- (BOOL)checkServicesInited
{
    if(![BNCoreServices_Instance isServicesInited])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"引擎尚未初始化完成，请稍后再试"
                                                           delegate:nil
                                                  cancelButtonTitle:@"我知道了"
                                                  otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}

//模拟导航
- (void)simulateNavi:(UIButton*)button
{
    if (![self checkServicesInited]) return;
    _naviType = BN_NaviTypeSimulator;
    [self startNavi];
}

//真实GPS导航
- (void)realNavi:(UIButton*)button
{
    if (![self checkServicesInited]) return;
    _naviType = BN_NaviTypeReal;
    [self startNavi];
}

- (void)digitDog:(UIButton*)button
{
    if (![self checkServicesInited]) return;
    [BNCoreServices_UI showDigitDogUI:YES delegete:self];
}


- (void)startNavi
{
    NSMutableArray *nodesArray = [[NSMutableArray alloc]initWithCapacity:2];
    //起点 传入的是原始的经纬度坐标，若使用的是百度地图坐标，可以使用BNTools类进行坐标转化
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
    startNode.pos = [[BNPosition alloc] init];
    startNode.pos.x = 113.948222;
    startNode.pos.y = 22.549555;
    startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:startNode];

    //也可以在此加入1到3个的途经点
    
    BNRoutePlanNode *midNode = [[BNRoutePlanNode alloc] init];
    midNode.pos = [[BNPosition alloc] init];
    midNode.pos.x = 113.977004;
    midNode.pos.y = 22.556393;
    midNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:midNode];
    
    //终点
    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
    endNode.pos = [[BNPosition alloc] init];
    endNode.pos.x = 114.089863;
    endNode.pos.y = 22.546236;
    endNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:endNode];
    
    [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Highway naviNodes:nodesArray time:nil delegete:self userInfo:nil];
}



#pragma mark - BNNaviRoutePlanDelegate
//算路成功回调
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{
    NSLog(@"算路成功");
    //路径规划成功，开始导航
    [BNCoreServices_UI showNaviUI:_naviType delegete:self isNeedLandscape:YES];
}

//算路失败回调
- (void)routePlanDidFailedWithError:(NSError *)error andUserInfo:(NSDictionary *)userInfo
{
    NSLog(@"算路失败");
    if ([error code] == BNRoutePlanError_LocationFailed) {
        NSLog(@"获取地理位置失败");
    }
    else if ([error code] == BNRoutePlanError_LocationServiceClosed)
    {
        NSLog(@"定位服务未开启");
    }
}

//算路取消回调
-(void)routePlanDidUserCanceled:(NSDictionary*)userInfo {
    NSLog(@"算路取消");
}

#pragma mark - BNNaviUIManagerDelegate

//退出导航回调
-(void)onExitNaviUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航");
}

//退出导航声明页面回调
- (void)onExitDeclarationUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航声明页面");
}

-(void)onExitDigitDogUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出电子狗页面");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
