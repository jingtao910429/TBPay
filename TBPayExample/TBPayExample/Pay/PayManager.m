//
//  PayManager.m
//  TBPayExample
//
//  Created by qianqichao on 2017/12/6.
//  Copyright © 2017年 qianqichao. All rights reserved.
//

#import "PayManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>

@implementation PayManager

+ (void)startAlipay:(NSString *)order scheme:(NSString *)scheme callback:(AliPayCompletionBlock)result {
    [[AlipaySDK defaultService] payOrder:order fromScheme:scheme callback:result];
}

+ (int)startWXPay:(NSString *)order {
//    {
//        "resultCode": 0,
//        "errMsg": null,
//        "body": {
//            "orderNo": "2017120618052453533767",
//            "orderInfo": "{\"xml\":{\"nonce_str\":\"JiuNk8EB2cDfcGBk\",\"appSign\":\"A5C207ED627C20374343D36A15C48D52\",\"appid\":\"wx801a8ba3b2643a3d\",\"sign\":\"4FEFA338CC5DDE8AA8832FF1AE42359E\",\"trade_type\":\"APP\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":1409656102,\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx201712061805251251e788d40297651606\",\"timestamp\":1512554725}}"
//        }
//    }
    NSDictionary * para = [self dictionaryWithJsonString:order];
    //字符串解析失败
    if (para == nil) {
        return -1;
    }
    
    NSDictionary * req = para[@"xml"];
    //向微信注册
    [WXApi registerApp:req[@"appid"]];
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

+ (id)dictionaryWithJsonString:(NSString *)jsonString {
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
