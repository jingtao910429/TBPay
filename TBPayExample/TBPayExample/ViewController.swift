//
//  ViewController.swift
//  TBPayExample
//
//  Created by qianqichao on 2017/12/6.
//  Copyright © 2017年 qianqichao. All rights reserved.
//

import UIKit
import TBPay

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //微信支付
        PayManager.startWXPay("{\"xml\":{\"nonce_str\":\"w8zUoHldVFRpABRM\",\"appSign\":\"606218EAD74DA17D96718260B0286BAB\",\"appid\":\"wx801a8ba3b2643a3d\",\"sign\":\"E0A65A02C5BBB8A7D7F46EB296FD961F\",\"trade_type\":\"APP\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":1409656102,\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx20171208143344c6f69f85590029957117\",\"timestamp\":1512714824}}");
        
        //支付宝
//        PayManager.startAlipay("alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2017081508202965&biz_content=%7B%22body%22%3A%22%E8%B4%AD%E4%B9%B0%E7%A7%AF%E5%88%86%22%2C%22out_trade_no%22%3A%222017120710520511630813%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22%E8%B4%AD%E4%B9%B0%E7%A7%AF%E5%88%86%22%2C%22timeout_express%22%3A%2230m%22%2C%22total_amount%22%3A%220.1%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Ftest.2boss.cn%2Fsuperior%2Fv1%2Fpay%2FalipayCallBack&sign=LzuyGbRbbrj7UFinBo2B5tmmx10DxbY8xJTBiz7Jou1xAxIgxxivO%2BfS4%2FlJ2zeyT5zZIEU3uhese7vHsQdC1Taf2FNWthCvhLYnB0GRdfFymIpdj6ShaHzSCw6z%2B0oFuUGtVk2aUXG%2FLeRpdwsz2%2Fc7bz%2FS3fKXG2x%2FaaaZc61vyl%2F8e2%2BcmmR3QqD7p%2BBNP26yvb5Qc0wX4wlG7Gz%2FHGodrc%2BAdenJkFJA6haq59bZllMWjWN%2Bz%2BCCcfixf9rlaZe%2FIUUcZidDGL8%2BLM0xJ76vuk9TRMcP91L8P74FBaTtYbEvCzQ6sidqut3M0xRxbZEcXsXent0meNYdG9%2BjHQ%3D%3D&sign_type=RSA2&timestamp=2017-12-07+10%3A52%3A05&version=1.0", scheme: "cn.2boss.www") { (result) in
//            print("-------------------\(result)")
//        }
    }
    
}

