//
//  PayManager.h
//  TBPayExample
//
//  Created by qianqichao on 2017/12/6.
//  Copyright © 2017年 qianqichao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AliPayCompletionBlock)(NSDictionary *resultDic);

@interface PayManager : NSObject

+ (void)startAlipay:(NSString *)order scheme:(NSString *)scheme callback:(AliPayCompletionBlock)result;

+ (int)startWXPay:(NSString *)order;

@end
