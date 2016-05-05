//
//  NBSQLDataManagerTool.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/27.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBSQLDataManagerTool: NSObject {

    //创建数据存储单例
    static let shareManager : NBSQLDataManagerTool = {
        let manager = NBSQLDataManagerTool()
        return manager
    }()
    //数据库对象
    var dbQueue : FMDatabaseQueue = {
        // 1.拼接保存数据库文件的路径
        let path = NBStringUtil.cacheDir("sibuProduct.sqlite")
        
        // 2.创建数据库对象
        let queue = FMDatabaseQueue(path: path)
        return queue
    }()

    private override init() {
        super.init()
        //创建表
        self.createTable()
    }
    /// 创建表
    private func createTable() {
        // 1.编写SQL语句
        let sql = "CREATE TABLE IF NOT EXISTS T_Product( \n" +
            "id INTEGER IDENTITY(1,1) PRIMARY KEY, \n" +
            "productId TEXT, \n" +
            "price MONEY, \n" +
            "addNum INTEGER, \n" +
            "userId TEXT,\n" +
            "createDate TEXT NOT NULL DEFAULT (datetime('now', 'localtime')) \n" +
        "); \n"
        
        // 2.执行SQL语句
        dbQueue.inDatabase { (db) -> Void in
            db.executeUpdate(sql, withArgumentsInArray: nil)
        }
    }
}
