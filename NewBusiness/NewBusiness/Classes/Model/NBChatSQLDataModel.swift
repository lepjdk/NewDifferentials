//
//  NBChatSQLDataModel.swift
//  NewBusiness
//
//  Created by lepjdk on 16/5/13.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBChatSQLDataModel: NSObject {

    /*
    @property (nonatomic, retain) NSString * id;
    @property (nonatomic, retain) NSString * name;
    @property (nonatomic, retain) NSString * image;
    @property (nonatomic, retain) NSString * code;
    @property (nonatomic, retain) NSString * desc;
    @property (nonatomic, retain) NSString * userId;
    @property (nonatomic, retain) NSNumber * price;
    @property (nonatomic, retain) NSNumber * amount;
    @property (nonatomic, retain) NSDate * addTime;
    */
    var productId : String?
    var name : String?
    var image : String?
    var code : String?
    var desc : String?
    var userId : String?
    var price : Double = 0.0
    var amount : Int = 0
    var addDate : String?
}
