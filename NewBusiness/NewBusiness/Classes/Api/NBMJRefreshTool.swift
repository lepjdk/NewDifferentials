//
//  NBMJRefreshTool.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/22.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

protocol RefreshToolDelegate : class {
    func refreshData(target : AnyObject?, onLoad : Int?)
    func refreshTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
}

class NBMJRefreshTool: NSObject {
   
    weak var delegate : RefreshToolDelegate?
    
    var tableView : UITableView? {
        didSet
            {
                tableView?.dataSource = self
                createHeader()
                createFooter()
        }
    }
//    var dataList2 : NSMutableArray {
//        get
//        {
//            return self.dataList2
//        }
//    }
    lazy var dataList : NSMutableArray = {
        let data = NSMutableArray()
        return data
    }()
    var emptyView = UIView()
    /*
    //单例
    static let shareRefresh: NBMJRefreshTool = {
       let refresh = NBMJRefreshTool()
        return refresh
    }()
    */
    //MARK:--内部控制方法
    private func createHeader()
    {
        weak var wkself = self
        tableView!.mj_header = NBMJRefreshHeader(refreshingBlock: { () -> Void in
            wkself?.loadData()
        })
    }
    private func createFooter()
    {
        weak var wkself = self
        tableView?.mj_footer = MJRefreshAutoFooter(refreshingBlock: { () -> Void in
            wkself?.loadData()
        })
        tableView?.mj_footer.hidden = true
        
    }
    //获取数据
    private func loadData()
    {
        self.delegate?.refreshData(self, onLoad: nil)
    }
    
    //MARK:--外部控制方法
    //重新加载数据
    func reloadData()
    {
        tableView?.mj_header.beginRefreshing()
    }
    //结束加载数据
    func endLoading()
    {
        tableView?.mj_header.endRefreshing()
        tableView?.mj_footer.endRefreshing()
    }
    
    
}
extension NBMJRefreshTool : UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return (self.delegate?.refreshTableView(tableView, cellForRowAtIndexPath: indexPath))!
    }
}
