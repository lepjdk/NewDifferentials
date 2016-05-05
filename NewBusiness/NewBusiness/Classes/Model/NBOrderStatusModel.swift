//
//  NBOrderStatusModel.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/22.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBOrderStatusModel: NSObject {

    var buyerClosedOrderCount : Int = -1
    var buyerShipOrderCount : Int = -1
    var buyerShopOrderCount : Int = -1
    var buyerWaitingOrderCount : Int = -1
    var buyerWaitingPayOrderCount : Int = -1
    var monthlyOrderMoney : Int = -1
    var monthlyRetailMoney : Int = -1
    var monthlySaleMoney : Int = -1
    var sellerClosedOrderCount : Int = -1
    var sellerShipOrderCount : Int = -1
    var sellerShopOrderCount : Int = -1
    var sellerWaitingOrderCount : Int = -1
    var sellerWaitingPayOrderCount : Int = -1
    
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
