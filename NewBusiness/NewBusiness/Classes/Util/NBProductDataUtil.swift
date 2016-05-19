//
//  NBProductDataUtil.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/27.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBProductDataUtil: NSObject {

    static let shareUtil = NBProductDataUtil()
    
    var productData : NBProductListModel?
    
    private var userID : String? = {
       let str = NBUserUtil.shareUser.getUserInfo()
       let strData = str as? NSDictionary
        if strData == nil
        {
            return nil
        }
        guard let strID = strData!["id"] else
        {
            return nil
        }
        return strID as? String
    }()
    
    //缓存产品数据
    func cacheInsertProduct(list: NSArray)
    {
        guard let userId = userID else {
            return
        }
        if list.count <= 0
        {
            return
        }
        for dataItem in list
        {
            let item = dataItem as! NBProductListModel
            guard let productId = item.id else
            {
                continue
            }
            //查看是否已经存在此记录
            if lookOutproduct(userId, productId: productId) {
                continue
            }
            
            //将数据加入到数据库中
            cacheProducts(userId, data : item)
            
        }
    }
    /**
     *查询对应数据
     */
    func searchProduct(data : NBProductListModel) -> Int
    {
        guard let userId = userID else {
            return 0
        }
        // 1.准备数据
        guard let productId = data.id else
        {
            return 0
        }
        return searchProductData(userId, productId: productId)
        
    }
    /**
     *查看是否已经存在此记录
     */
    private func lookOutproduct(userId : String, productId : String) -> Bool
    {
        var flag = false
        // 1.编写SQL语句
        let sql = "SELECT * FROM T_Product \n" +
            "WHERE \n" +
        "productId = '\(productId)' \n" +
        "AND userId = '\(userId)' ;"
        
        // 2.执行SQL语句
        // 注意点: FMDB的inDatabase的block(闭包)不是异步执行的
        NBSQLDataManagerTool.shareManager.dbQueue.inDatabase { (db) -> Void in
            // 2.1执行查询语句
            let result = db.executeQuery(sql, withArgumentsInArray: nil)
            NSLog("%@", result)
            if result == nil
            {
                flag = false
            }
            else
            {
                while result.next()
                {
                    flag = true
                }
            }
        }
        return flag
    }
    //查询对应的产品数量
    private func searchProductData(userId : String, productId : String) -> Int
    {
        var number = 0
        NSLog("%@--%@", userId, userID!)
        // 1.编写SQL语句
        let sql = "SELECT * FROM T_Product \n" +
            "WHERE \n" +
            "productId = '\(productId)' \n" +
        "AND userId = '\(userId)' ;"
        
        // 2.执行SQL语句
        // 注意点: FMDB的inDatabase的block(闭包)不是异步执行的
        NBSQLDataManagerTool.shareManager.dbQueue.inDatabase { (db) -> Void in
            // 2.1执行查询语句
            let result = db.executeQuery(sql, withArgumentsInArray: nil)
            NSLog("%@", result)
            if result == nil
            {
                return
            }
            else
            {
                while result.next()
                {
                    let str = result.intForColumn("addNum")
                    number = Int(str)
                }
            }
        }
        return number
    }
    //查询所有的产品数量
    func searchAllProduct() -> Int
    {
        guard let userId = userID else {
            return 0
        }
        var number = 0
        // 1.编写SQL语句
        let sql = "SELECT * FROM T_Product \n" +
            "WHERE \n" +
            "userId = '\(userId)' ;"
        
        // 2.执行SQL语句
        // 注意点: FMDB的inDatabase的block(闭包)不是异步执行的
        NBSQLDataManagerTool.shareManager.dbQueue.inDatabase { (db) -> Void in
            // 2.1执行查询语句
            let result = db.executeQuery(sql, withArgumentsInArray: nil)
            NSLog("%@", result)
            if result == nil
            {
                return
            }
            else
            {
                while result.next()
                {
                    let str = result.intForColumn("addNum")
                    number += Int(str)
                }
            }
        }
        return number
    }
    
    /**
    *将数据加入到数据库中
    */
    private func cacheProducts(userId : String, data : NBProductListModel)
    {
        // 1.准备数据
        let productid = data.id
        let name = data.name
        let image = data.thumbImg
        let code = data.brand
        let desc = data.detail
        let price = data.price
        let Num = 0

        // 2.编写SQL语句
        let sql = "INSERT INTO T_Product" +
            "(productId, name, image, code, desc, price, addNum, userId)" +
            "VALUES" +
        "(?, ?, ?, ?, ?, ?, ?, ?);"
        
        // 3.执行SQL语句
        NBSQLDataManagerTool.shareManager.dbQueue.inTransaction({ (db, rollback) -> Void in
            
            do{
                try db.executeUpdate(sql, values: [productid!, name!, image!, code!, desc!, price, Num, userId])
            }catch {
                // 回滚
                rollback.memory = true
            }
        })
    }
    /**
    *更新产品数据
    */
    func updateProductData(data : NBProductListModel)
    {
        // 1.准备数据
        guard let userId = userID else {
            return
        }
        guard let productId = data.id else
        {
            return
        }
        let number = data.addNumber
        // 2.编写SQL语句
        let sql = "UPDATE T_Product \n" +
                  "SET addNum = \(number) \n" +
            "WHERE \n" +
            "productId = '\(productId)' \n" +
            "AND userId = '\(userId)' ;"
        
        // 3.执行SQL语句
        NBSQLDataManagerTool.shareManager.dbQueue.inTransaction({ (db, rollback) -> Void in

            do{
                try db.executeUpdate(sql, values: nil)
            }catch {
                // 回滚
                rollback.memory = true
            }
        })
    }
    /**
     *更新产品数据
     */
    func updateProductDataSql(data : NBChatSQLDataModel)
    {
        // 1.准备数据
        guard let userId = userID else {
            return
        }
        guard let productId = data.productId else
        {
            return
        }
        let number = data.amount
        // 2.编写SQL语句
        let sql = "UPDATE T_Product \n" +
            "SET addNum = \(number) \n" +
            "WHERE \n" +
            "productId = '\(productId)' \n" +
        "AND userId = '\(userId)' ;"
        
        // 3.执行SQL语句
        NBSQLDataManagerTool.shareManager.dbQueue.inTransaction({ (db, rollback) -> Void in
            
            do{
                try db.executeUpdate(sql, values: nil)
            }catch {
                // 回滚
                rollback.memory = true
            }
        })
    }
    /**
    *获取购物车数据
    */
    func getShopChatData() -> NSArray
    {
        let arrM = NSMutableArray()
        guard let userId = userID else {
            return arrM
        }
        // 1.编写SQL语句
        let sql = "SELECT * FROM T_Product \n" +
            "WHERE \n" +
            "addNum > 0 \n" +
        "AND userId = '\(userId)' ;"
        
        // 2.执行SQL语句
        // 注意点: FMDB的inDatabase的block(闭包)不是异步执行的
        NBSQLDataManagerTool.shareManager.dbQueue.inDatabase { (db) -> Void in
            // 2.1执行查询语句
            let result = db.executeQuery(sql, withArgumentsInArray: nil)
            NSLog("%@", result)
            if result == nil
            {
                return
            }
            else
            {
                while result.next()
                {
                    let dictM = NSMutableDictionary()
                    dictM["productId"] = result.stringForColumn("productId")
                    dictM["name"] = result.stringForColumn("name")
                    dictM["image"] = result.stringForColumn("image")
                    dictM["code"] = result.stringForColumn("code")
                    dictM["desc"] = result.stringForColumn("desc")
                    dictM["userId"] = result.stringForColumn("userId")
                    dictM["price"] = result.stringForColumn("price")
                    dictM["amount"] = result.stringForColumn("addNum")
                    dictM["addDate"] = result.stringForColumn("addDate")
                    
                    arrM.addObject(dictM)
                }
            }
        }
        return arrM
    }
}
