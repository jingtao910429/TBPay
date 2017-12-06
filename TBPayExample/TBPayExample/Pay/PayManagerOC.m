//
//  PayManagerOC.m
//  TBPayExample
//
//  Created by Mac on 2017/12/6.
//  Copyright © 2017年 qianqichao. All rights reserved.
//

#import "PayManagerOC.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation PayManagerOC
- (void)startAliPay:(NSString *)orderInfo scheme:(NSString *)scheme {
    [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:scheme callback:^(NSDictionary *resultDic) {
    }];
}
@end
