//
//  AppDefinition.h
//  jishijie
//
//  Created by xiong on 15/3/20.
//  Copyright (c) 2015年 xiong. All rights reserved.
//
#ifndef jishijie_AppDefinition_h
#define jishijie_AppDefinition_h
//系统
#define IS_OS_6_OR_LATER     ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define IOS7                 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8                 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

// 获取Documents目录路径 NSString *docDir = [paths objectAtIndex:0];
#define DOCUMENT_PATH  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

// 获取Caches目录路径 NSString *cachesDir = [paths objectAtIndex:0];
#define CACHES_PATH  = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

//// 获取tmp目录路径
//#define NSTemporaryDirectory =  NSTemporaryDirectory();
//#define folerName_PHOTO @"photos"

//屏幕
#define SCREEN_BOUNDS        [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH         [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT        [[UIScreen mainScreen] bounds].size.height
#define kScreenHeight        [UIScreen mainScreen].bounds.size.height
#define kScreenWidth         [UIScreen mainScreen].bounds.size.width

//屏幕分辨率
#define isRetina             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad                (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//-------------------图片类----------------------------
#define LOADIMAGE(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

//----------------------颜色类---------------------------
#define COLOR_GRAY  [UIColor colorWithRed:0.773  green:0.773  blue:0.776 alpha:1] 
#define COLOR_BLUE  [UIColor colorWithRed:0.345  green:0.686  blue:0.714 alpha:1]
#define CLEARCOLOR [UIColor clearColor]
#define RGBColor(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])


//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
#define AFTER_MAIN(time,block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)),dispatch_get_main_queue(),block)
#define AFTER_BACK(time,block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)),dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block)

//XcodeAppVersion
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//拨打电话
#define canTel                 ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]])
#define tel(phoneNumber)       ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]])
#define telprompt(phoneNumber) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]]])

//打开URL
#define canOpenURL(appScheme) ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]])
#define openURL(appScheme) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]])

//------------------字体-------------------------------------
#define FontNumber    @"Roboto-Light"
#define FontWord      @"Helvetica"
#define FontWordBold  @"Helvetica-Bold"
#define FontWordEn    @"Helvetica"

//NSDefault key
#define NSDEFAULT_USERNAME                            @"username"
#define NSDEFAULT_PASSWORD                            @"password"


#define USER_VERIFYKEY                                @"USER_VERIFYKEY"//用户验证key
#define USER_PHONENUMER                               @"USER_PHONENUMER"//用户手机号

//------------------通知-------------------------------------
#define NotificationReachability                      @"NotificationReachability"
//XMPP推送相关通知
#define kLOGIN_SUCCESS                                @"kLOGIN_SUCCESS"
#define kREGIST_RESULT                                @"kREGIST_RESULT"
#define kXMPP_ROSTER_CHANGE                           @"kXMPP_ROSTER_CHANGE"
#define kXMPP_MESSAGE_CHANGE                          @"kXMPP_MESSAGE_CHANGE"

//------------------应用常量配置-------------------------------------
//百度地图key
#define BAIDU_MAP_KEY                                 @"H9LmuRLW8h2CjR8eUflSpV4P"
//XMPP相关配置
#define                                               kXMPP_HOST @"120.24.163.118"
#define                                               kXMPP_PORT 5222

#endif
