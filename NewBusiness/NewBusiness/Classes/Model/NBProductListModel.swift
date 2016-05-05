//
//  NBProductListModel.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/26.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBProductListModel: NSObject {

    /*
    message = "";
    page = 1;
    pageSize = 20;
    totalCount = 1;
    */
    var id : String?
    var bannelImgs : NSArray?
    var bannelThumbImgs : NSArray?
    var boxNum : Int = -1
    var brand : String?
    var detail : String?
    var info : String?
    var marketPrice : Int = -1
    var name : String?
    var price : Double = 0.0
    var shareText : String?
    var size : Int = -1
    var stock : Int = -1
    var addNumber : Int = 0
    var thumbImg : String?
    
}
