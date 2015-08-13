//
//  JKXMPPTool.h
//  ChatDemo
//
//  Created by zhx on 15/7/19.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "XMPPFramework.h"

@interface XMPPTool : NSObject<XMPPStreamDelegate,UIAlertViewDelegate,XMPPRosterDelegate,XMPPRosterMemoryStorageDelegate,XMPPIncomingFileTransferDelegate>
//通信管道，输入输出流
@property (nonatomic, strong) XMPPStream *xmppStream;
// 模块
@property (nonatomic, strong) XMPPAutoPing *xmppAutoPing;
//重连管理
@property (nonatomic, strong) XMPPReconnect *xmppReconnect;
//好友管理
@property (nonatomic, strong) XMPPRoster *xmppRoster;

@property (nonatomic, strong) XMPPRosterMemoryStorage *xmppRosterMemoryStorage;
//聊天信息归档
@property (nonatomic, strong) XMPPMessageArchiving *xmppMessageArchiving;

@property (nonatomic, strong) XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;

@property (nonatomic, strong) XMPPIncomingFileTransfer *xmppIncomingFileTransfer;

@property (nonatomic, assign) BOOL  xmppNeedRegister;

@property (nonatomic, copy)   NSString *myPassword;

@property (nonatomic, strong) XMPPPresence *receivePresence;

+ (instancetype)sharedInstance;
//用户登录
- (void)loginWithJID:(XMPPJID *)JID andPassword:(NSString *)password;

- (void)registerWithJID:(XMPPJID *)JID andPassword:(NSString *)password;
//添加好友
- (void)addFriend:(XMPPJID *)aJID;

@end
