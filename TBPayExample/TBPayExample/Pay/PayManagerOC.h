//
//  PayManagerOC.h
//  TBPayExample
//
//  Created by Mac on 2017/12/6.
//  Copyright © 2017年 qianqichao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayManagerOC : NSObject
- (void)startAliPay:(NSString *)orderInfo scheme:(NSString *)scheme;
@end
