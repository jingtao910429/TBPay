//
//  PayManager.m
//  TBPayExample
//
//  Created by qianqichao on 2017/12/6.
//  Copyright © 2017年 qianqichao. All rights reserved.
//

#import "PayManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import <PassKit/PKPaymentAuthorizationViewController.h>    //Apple pay的展示控件
#import <AddressBook/AddressBook.h>                         //用户联系信息相关

@interface PayManager() <PKPaymentAuthorizationViewControllerDelegate>

@property (nonatomic, strong) UIViewController<TBApplyPayDelegate> * controller;

@end

@implementation PayManager

+ (instancetype)shareManager {
    static PayManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)startAlipay:(NSString *)order scheme:(NSString *)scheme callback:(AliPayCompletionBlock)result {
    [[AlipaySDK defaultService] payOrder:order fromScheme:scheme callback:result];
}

- (TBPayResultType)startWXPay:(NSString *)order {
    NSDictionary * para = [self dictionaryWithJsonString:order];
    //字符串解析失败
    if (para == nil) {
        return TBPayResultType_ParsingFailure;
    }
    
    NSDictionary * req = para[@"xml"];
    //向微信注册
    [WXApi registerApp:req[@"appid"]];
    
    //没有装微信客户端
    if ([WXApi isWXAppInstalled] == NO) {
        return TBPayResultType_WXAppNotInstalled;
    }
    
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = [NSString stringWithFormat:@"%@",req[@"mch_id"]];
    request.prepayId = req[@"prepay_id"];
    request.package = @"Sign=WXPay";
    request.nonceStr = req[@"nonce_str"];
    request.timeStamp = [req[@"timestamp"] intValue];
    request.sign = req[@"appSign"];
    [WXApi sendReq:request];
    return 0;
}

- (TBPayResultType)startApplyPay:(NSString *)order controller:(UIViewController<TBApplyPayDelegate> *)controller {
    if (![PKPaymentAuthorizationViewController class]) {
        return TBPayResultType_ApplyPayDeviceNotAllowed;
    }
    if (![PKPaymentAuthorizationViewController canMakePayments]) {
        return TBPayResultType_ApplyPayDeviceNotAllowed;
    }
    //检查用户是否可进行某种卡的支付，是否支持Amex、MasterCard、Visa与银联四种卡，根据自己项目的需要进行检测
    NSArray *supportedNetworks = @[PKPaymentNetworkChinaUnionPay];
    if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:supportedNetworks]) {
        return TBPayResultType_ApplyPayNetworkNotAllowed;
    }
    
    NSDictionary * para = [self dictionaryWithJsonString:order];
    //字符串解析失败
    if (para == nil) {
        return TBPayResultType_ParsingFailure;
    }
    self.controller = controller;
    
    PKPaymentRequest *payRequest = [[PKPaymentRequest alloc] init];
    payRequest.countryCode = para[@"countryCode"];
    payRequest.currencyCode = para[@"currencyCode"];
    payRequest.merchantIdentifier = para[@"merchantIdentifier"];
    payRequest.supportedNetworks = supportedNetworks;
    payRequest.merchantCapabilities = PKMerchantCapability3DS|PKMerchantCapabilityEMV;
    NSDecimalNumber *totalAmount = [NSDecimalNumber decimalNumberWithString:para[@"amount"]];
    PKPaymentSummaryItem *total = [PKPaymentSummaryItem summaryItemWithLabel:para[@"summary"] amount:totalAmount];
    
    NSMutableArray *summaryItems = [NSMutableArray arrayWithArray:@[total]];
    payRequest.paymentSummaryItems = summaryItems;
    
    PKPaymentAuthorizationViewController *view = [[PKPaymentAuthorizationViewController alloc]initWithPaymentRequest:payRequest];
    view.delegate = self;
    [self.controller presentViewController:view animated:YES completion:nil];
    return 0;
}

#pragma mark - PKPaymentAuthorizationViewControllerDelegate
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion {
    PKPaymentToken *payToken = payment.token;               //支付凭据，发给服务端进行验证支付是否真实有效
    PKContact *billingContact = payment.billingContact;     //账单信息
    PKContact *shippingContact = payment.shippingContact;   //送货信息
    PKContact *shippingMethod = payment.shippingMethod;     //送货方式
    
    if ([self.controller conformsToProtocol:@protocol(TBApplyPayDelegate)] && [self.controller respondsToSelector:@selector(applyPayAuthorization:result:)]) {
        [self.controller applyPayAuthorization:payment result:^(BOOL isAuthorization) {
            if (isAuthorization) {
                completion(PKPaymentAuthorizationStatusSuccess);
            } else {
                completion(PKPaymentAuthorizationStatusFailure);
            }
        }];
    } else {
        completion(PKPaymentAuthorizationStatusFailure);
    }
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if ([self.controller conformsToProtocol:@protocol(TBApplyPayDelegate)] && [self.controller respondsToSelector:@selector(applyPayDidFinish)]) {
        [self.controller applyPayDidFinish];
    }
}



- (id)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                             options:NSJSONReadingMutableContainers
                                               error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
