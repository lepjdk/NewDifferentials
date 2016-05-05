//
//  NBUserModel.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/22.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBUserModel: NSObject {
    
    var id : String?
    var levelName : String?
    var phone : String?
    var head : String?
    var idCard : String?
    var levelId : String?
    var levelIndex : Int = -1
    var male : Int = -1
    var nextCredit : Int = -1
    var nextLevelName : String?
    var nickName : String?
    var orderStat : NBOrderStatusModel?
    var qq : String?
    var rank : Int = -1
    var sortIndex : String?
    var trueName : String?
    var wechat : String?
    var credit : Int = -1
    var email : String?
    
    init(dict : [String : AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        let keys = ["nickName", "phone", "male", "qq"]
        let dict = dictionaryWithValuesForKeys(keys)
        return "\(dict)"
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "orderStat" {
            orderStat = NBOrderStatusModel(dict: value as! [String : AnyObject])
            return
        }
        super.setValue(value, forKey: key)
    }

}
