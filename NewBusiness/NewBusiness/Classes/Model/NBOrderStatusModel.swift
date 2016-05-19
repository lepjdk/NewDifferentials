//
//  NBOrderStatusModel.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/22.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBOrderStatusModel: NSObject {

    var buyerClosedOrderCount : Int = 0
    var buyerShipOrderCount : Int = 0
    var buyerShopOrderCount : Int = 0
    var buyerWaitingOrderCount : Int = 0
    var buyerWaitingPayOrderCount : Int = 0
    var monthlyOrderMoney : Int = 0
    var monthlyRetailMoney : Int = 0
    var monthlySaleMoney : Int = 0
    var sellerClosedOrderCount : Int = 0
    var sellerShipOrderCount : Int = 0
    var sellerShopOrderCount : Int = 0
    var sellerWaitingOrderCount : Int = 0
    var sellerWaitingPayOrderCount : Int = 0
    
    init(dict : [String : AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["buyerClosedOrderCount", "buyerShipOrderCount", "buyerShopOrderCount", "buyerWaitingOrderCount"]
        let dict = dictionaryWithValuesForKeys(keys)
        return "\(dict)"
    }
    
}
