//
//  ViewController.swift
//  TBPayExample
//
//  Created by qianqichao on 2017/12/6.
//  Copyright © 2017年 qianqichao. All rights reserved.
//

import UIKit
import TBPay
import PassKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //微信支付
//        PayManager.startWXPay("{\"countryCode\":\"CN\",\"currencyCode\":\"CNY\",\"merchantIdentifier\":\"merchant.com.rabbit.liyou\",\"amount\":\"0.01\",\"summary\":\"支付付付付付付付付付付付付付付付\"}");
//
        
        PayManager.share().startApplyPay("{\"countryCode\":\"CN\",\"currencyCode\":\"CNY\",\"merchantIdentifier\":\"merchant.com.rabbit.liyou\",\"amount\":\"0.01\",\"summary\":\"支付付付付付付付付付付付付付付付\"}", controller: self)
        
    }
    
}

extension ViewController: TBApplyPayDelegate {
    
    func applyPayAuthorization(_ payment: PKPayment!, result: ApplyPayAuthorizationCompletionBlock!) {
        let time: TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            result(true)
        }
    }
    
    func applyPayDidFinish() {
        
    }
    
}

