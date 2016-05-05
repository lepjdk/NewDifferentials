//
//  NBModelTool.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/26.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBModelTool: NSObject {

    class func objectArrayWithKeyValuesArray(className : AnyClass, keyValuesArray : AnyObject) -> NSMutableArray
    {
        /*
        // 0.获取当前应用程序的命名空间
        guard let nsp = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else {
            return
        }
        
        // 注意: 在Swift中想通过字符串创建类, 必须加上命名空间""
        guard let cls: AnyClass = NSClassFromString(nsp + "." + (childControllerName ?? "")) else {
            return
        }
        */
        return className.mj_objectArrayWithKeyValuesArray(keyValuesArray)
    }
}
