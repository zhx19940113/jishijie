//
//  AppDelegate.m
//  jishijie
//
//  Created by zhx on 15/8/7.
//  Copyright (c) 2015年 zhx. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoListViewController.h"
#import "RegisterViewController.h"
#import "NavigationController.h"
#import "BNCoreServices.h"
#import "MainViewController.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "RootViewController.h"

BMKMapManager* _mapManager;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //1.网络小菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    //2.监控网络状态
    [self startNetworkMonitoring];
    
    //3.适配简配弹出
    //Enabling keyboard manager(Use this line to enable managing distance between keyboard & textField/textView).
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    //4.要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BAIDU_MAP_KEY generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    //5.初始化导航SDK  com.baidu.navitest RYCz5WoPf4Mm8Y5Q0X2EPROZ
    //               com.opticmatrix.jishijie H9LmuRLW8h2CjR8eUflSpV4P
    //如果无语音请配置TTS白名单http://app.navi.baidu.com/ttsregister/appinfo
    [BNCoreServices_Instance initServices:BAIDU_MAP_KEY];
    [BNCoreServices_Instance startServicesAsyn:nil fail:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //测试登录
//    UIStoryboard *loginSB =[UIStoryboard storyboardWithName:@"Login" bundle:nil];
//    LoginViewController *loginViewController = loginSB.instantiateInitialViewController;
    
    //测试注册
    UIStoryboard *registerSB =[UIStoryboard storyboardWithName:@"Register" bundle:nil];
    RegisterViewController *registerViewController = registerSB.instantiateInitialViewController;
    
    //测试消息推送
//    UIStoryboard *mainSB =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewController *mainViewController = mainSB.instantiateInitialViewController;
    
    //测试网络框架
//    DemoListViewController *demoListViewController = [[DemoListViewController alloc] init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:demoListViewController];
    
    //测试导航
//   MainViewController *navViewController = [[MainViewController alloc] init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:navViewController];
    
    //测试地图
//    RootViewController *rootViewController = [[RootViewController alloc] init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];

    self.window.rootViewController = registerViewController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark    --网络状态监控

/**
 *	@brief	开始检测网络状态
 */
-(void)startNetworkMonitoring
{
    AFNetworkReachabilityManager *mgr=[AFNetworkReachabilityManager sharedManager];
    //当网络状态改变的时候，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown://未知网络
            case AFNetworkReachabilityStatusNotReachable://没有网络
                NSLog(@"没有网络（断网）");
                // [self showAlertView:@"提示" message:@"网络异常，请检查网络设置！"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://手机自带网络
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi://WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    //开始监控
    [mgr startMonitoring];
}

#pragma mark 百度地图BMKGeneralDelegate回调

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
