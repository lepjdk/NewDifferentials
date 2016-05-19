//
//  NBModelTool.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/26.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBModelTool: NSObject {

    //MARK: -字典数组转模型
    class func modelObjectArrayWithKeyValuesArray(className : AnyClass, keyValuesArray : AnyObject) -> NSMutableArray
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
    //MARK: -字典转模型
    class func modelObjectWithKeyValues(className : AnyClass, keyValues : AnyObject) -> AnyObject
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
        return className.mj_objectWithKeyValues(keyValues)
    }
}
