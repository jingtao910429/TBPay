//
//  PayManager.swift
//  TBPayExample
//
//  Created by qianqichao on 2017/12/6.
//  Copyright © 2017年 qianqichao. All rights reserved.
//

import Foundation

enum PayType: Int {
    case alipay = 1         // 支付宝
    case wechat = 2         // 微信
    case applypay = 3       // Apply pay
}

class PayManager: NSObject {
    
    class func startAliPay(orderInfo: String, scheme: String, completionHandler: @escaping CompletionBlock) {
        AlipaySDK.defaultService().payOrder(orderInfo, fromScheme: scheme, callback: completionHandler)
    }
    
}
