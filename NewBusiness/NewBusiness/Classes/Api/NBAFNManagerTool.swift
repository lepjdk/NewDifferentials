//
//  NBAFNManagerTool.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/21.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBAFNManagerTool: NSObject {

    //单例
    static let shareInstance : NBAFNManagerTool = {
        let managerTool = NBAFNManagerTool()
        return managerTool
    }()
    
    private lazy var sessionManager : AFHTTPSessionManager = {
        let baseUrl = NSURL(string: "http://sibuwesaleapi.orangebusiness.com.cn")
        let manager = AFHTTPSessionManager(baseURL: baseUrl)
        return manager
    }()
    //给闭包取别名
    typealias resultCallBack = (task : NSURLSessionDataTask?, result : AnyObject? , error : NSError?)->()
    
    private func getRequst(strUrl : String, parameters: AnyObject?, finished : resultCallBack)
    {
        sessionManager.GET(strUrl, parameters: parameters, progress: nil, success: { (task : NSURLSessionDataTask, respodData : AnyObject?) -> Void in
            finished(task: task, result: respodData, error: nil)
            }, failure: { (task : NSURLSessionDataTask?, error : NSError) -> Void in
                finished(task: task, result: nil, error: error)
        })
    }

}
//用户登录请求
extension NBAFNManagerTool
{
    func loginSession(parameters: AnyObject?, finished : resultCallBack)
    {
        let path = "/api/user/login"
        sessionManager.POST(path, parameters: parameters, progress: nil, success: { (task : NSURLSessionDataTask, respodData : AnyObject?) -> Void in
                finished(task: task, result: respodData, error: nil)
            }, failure: { (task : NSURLSessionDataTask?, error : NSError) -> Void in
                finished(task: task, result: nil, error: error)
        })
    }
}

//产品分类列表
extension NBAFNManagerTool
{
    func listProductCategories(parameters: AnyObject?, finished : resultCallBack)
    {
        let path = "/api/category/listProductCategories"
        getRequst(path, parameters: parameters, finished: finished)
    }
}
//产品列表
extension NBAFNManagerTool
{
    func listProductList(parameters: AnyObject?, finished : resultCallBack)
    {
        let path = "/api/product/list"
        getRequst(path, parameters: parameters, finished: finished)
    }
}

