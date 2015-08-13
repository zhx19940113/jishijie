//
//  ExternalGPSViewController.m
//  NaviDemo
//  外部gps导航是指gps数据是从外部传入，而不是由手机gps模块产生
//  Created by Baidu on 15/1/14.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "ExternalGPSViewController.h"
#import "BNRoutePlanModel.h"
#import "BNCoreServices.h"
#import "ExternalGPSModel.h"

@interface ExternalGPSViewController ()<BNNaviUIManagerDelegate,BNNaviRoutePlanDelegate>

//外部gps产生model
@property (strong, nonatomic) ExternalGPSModel* externalGPSModel;

@end


@implementation ExternalGPSViewController

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


- (ExternalGPSModel*)externalGPSModel
{
    if (!_externalGPSModel)
        _externalGPSModel = [[ExternalGPSModel alloc] init];
    return _externalGPSModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"外部GPS导航";
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
    UIButton* externalNaviButton = [self createButton:@"外部GPS导航" target:@selector(externalNaviButtonPressed:)  frame:buttonFrame];
    [self.view addSubview:externalNaviButton];
    
    buttonFrame.origin.x+=buttonFrame.size.width+30;
    UIButton* externalCuriseButton = [self createButton:@"外部GPS巡航" target:@selector(externalCuriseButtonPressed:) frame:buttonFrame];
    [self.view addSubview:externalCuriseButton];
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


//外部gps导航
- (void)externalNaviButtonPressed:(UIButton*)sender
{
    NSMutableArray *nodesArray = [[NSMutableArray alloc]initWithCapacity:2];
    //起点 传入的是原始的经纬度坐标，若使用的是百度地图坐标，可以使用BNTools类进行坐标转化
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
    startNode.pos = [[BNPosition alloc] init];
    startNode.pos.x = 113.948222;
    startNode.pos.y = 22.549555;
    startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:startNode];
    
    //终点
    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
    endNode.pos = [[BNPosition alloc] init];
    endNode.pos.x = 114.089863;
    endNode.pos.y = 22.546236;
    endNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:endNode];
}

//外部gps巡航
- (void)externalCuriseButtonPressed:(UIButton*)sender
{
    //设置为外部gps导航模式
    [BNCoreServices_Location setGpsFromExternal:YES];
    //显示巡航UI
    [BNCoreServices_UI showDigitDogUI:YES delegete:self];
    //开始发送gps
    [self.externalGPSModel startPostGPS];
}

#pragma mark - BNNaviRoutePlanDelegate
//算路成功回调
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{
    NSLog(@"算路成功");
    //设置为外部gps导航模式
    [BNCoreServices_Location setGpsFromExternal:YES];
    //显示导航UI
    [BNCoreServices_UI showNaviUI:BN_NaviTypeReal delegete:self isNeedLandscape:YES];
    //开始发送gps
    [self.externalGPSModel startPostGPS];
    
    
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
    //退出后恢复手机gps导航状态
    [BNCoreServices_Location setGpsFromExternal:NO];
    [self.externalGPSModel stopPostGPS];
}

//退出导航声明页面回调
- (void)onExitDeclarationUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航声明页面");
    [BNCoreServices_Location setGpsFromExternal:NO];
    [self.externalGPSModel stopPostGPS];
}

//退出电子狗页面回调
-(void)onExitDigitDogUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出电子狗页面");
    [BNCoreServices_Location setGpsFromExternal:NO];
    [self.externalGPSModel stopPostGPS];
    
}


@end
