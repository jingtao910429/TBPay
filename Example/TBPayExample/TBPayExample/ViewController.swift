//
//  ViewController.swift
//  TBPayExample
//
//  Created by qianqichao on 2017/12/6.
//  Copyright © 2017年 qianqichao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //支付宝
        PayManager.startAliPay(orderInfo: "app_id=2016050401361786&biz_content=%7b%22body%22%3a%22%e7%94%a8%e6%88%b7%e9%92%b1%e5%8c%85%e5%85%85%e5%80%bc30.00%e5%85%83%ef%bc%9b%22%2c%22subject%22%3a%22%e7%94%a8%e6%88%b7%e9%92%b1%e5%8c%85%e5%85%85%e5%80%bc30.00%e5%85%83%22%2c%22out_trade_no%22%3a%2225b8818e096e449e94feb5d45e8a7c10%22%2c%22timeout_express%22%3a%221d%22%2c%22total_amount%22%3a30.0%2c%22product_code%22%3a%22QUICK_MSECURITY_PAY%22%7d&charset=utf-8&format=JSON&method=alipay.trade.app.pay&notify_url=https%3a%2f%2ftest.rongyu100.com%2fapi_v2%2fapp%2fDepositOrder%2fAliPayResultNotify&sign_type=RSA&timestamp=2017-12-06+13%3a52%3a53&version=1.0&sign=pTTdkR%2bXPDVanJS%2flgCR3baArG1cpSg3vwZ%2fLJaXaMcd%2bCpn16rmOnjXPqp2E%2b7hX6m90U3NthGDomlRmcF0z1bRaQH9YS4IxaxOKjbfbepaB1Qdr12DlflnSEhEixEzdShqG8taqZr83pvDYom6HVRgWZ5Lmt7w4TrncUk3PhY%3d", scheme: "com.applechina.RongYu100") { (result) in
            print("------------\(result)")
        }
    }
    
}

