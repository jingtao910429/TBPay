//
//  PayManager.h
//  TBPayExample
//
//  Created by qianqichao on 2017/12/6.
//  Copyright © 2017年 qianqichao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>                                 //用户绑定的银行卡信息

//支付宝回调
typedef void(^AliPayCompletionBlock)(NSDictionary *resultDic);

//ApplyPay回调
typedef void(^ApplyPayAuthorizationCompletionBlock)(BOOL isAuthorization);

typedef NS_ENUM(NSInteger, TBPayResultType)
{
    TBPayResultType_ParsingFailure              = -1,//json解析失败
    TBPayResultType_WXAppNotInstalled           = -2,//没有安装微信客户端
    TBPayResultType_ApplyPayDeviceNotAllowed    = -3,//设备不支持ApplyPay
    TBPayResultType_ApplyPayNetworkNotAllowed   = -4 //网络不支持ApplyPay
};

//TAApplyPay代理
@protocol TBApplyPayDelegate <NSObject>

@required
- (void)applyPayAuthorization:(PKPayment *)payment result:(ApplyPayAuthorizationCompletionBlock)result;

- (void)applyPayDidFinish;

@end

@interface PayManager : NSObject

+ (instancetype)shareManager;

- (void)startAlipay:(NSString *)order scheme:(NSString *)scheme callback:(AliPayCompletionBlock)result;

- (TBPayResultType)startWXPay:(NSString *)order;

- (TBPayResultType)startApplyPay:(NSString *)order controller:(UIViewController<TBApplyPayDelegate> *)controller;

@end
