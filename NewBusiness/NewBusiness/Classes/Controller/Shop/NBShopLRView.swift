//
//  NBShopLRView.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/11.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBShopLRView: UIView {

    private let leftCell = "shopLeft"
    private let rightCell = "shopRight"
    
    private var selectIndexPath : NSIndexPath?
    private let categoryRefresh  = NBMJRefreshTool()
    private let productRefresh = NBMJRefreshTool()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 224 / 255.0, green: 224 / 255.0, blue: 224 / 255.0, alpha: 1)
        //加载子控件
        setUpChildView()
        //设置控件约束
        setUpChildLayout()
        //设置数据加载
        setUpRefreshTool()
//        leftTableView.registerNib(NSBundle.mainBundle().loadNibNamed("NBShopLeftCell", owner: nil, options: nil), forCellReuseIdentifier:leftCell)
        leftTableView.registerNib(UINib.init(nibName: "NBShopLeftCell", bundle: nil), forCellReuseIdentifier: leftCell)
        rightTableView.registerNib(UINib.init(nibName: "NBShopRightCell", bundle: nil), forCellReuseIdentifier: rightCell)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeProduct:"), name: "keyChangeProductNotify", object: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    //MAKR:--内部控制方法
    private func setUpChildView()
    {
        self.addSubview(leftTableView)
        self.addSubview(rightTableView)
    }
    //设置控件约束
    private func setUpChildLayout()
    {
        leftTableView.frame = CGRect(x: 0, y: 1, width: self.frame.size.width * 0.25, height: self.frame.size.height - 1)
        rightTableView.frame = CGRect(x: CGRectGetMaxX(leftTableView.frame), y: 1, width: self.frame.size.width * 0.75, height: self.frame.size.height - 1)
    }
    //刷新控件设置
    private func setUpRefreshTool()
    {
        categoryRefresh.tableView = leftTableView
        let header = categoryRefresh.tableView?.mj_header as! MJRefreshStateHeader
        header.lastUpdatedTimeLabel?.hidden = true
        categoryRefresh.delegate = self
        
        productRefresh.tableView = rightTableView
        productRefresh.delegate = self
        //开始刷新
        categoryRefresh.reloadData()
    }
    //更新事件
    @objc private func changeProduct(info : NSNotification)
    {
        /*
        guard let indexPath = selectIndexPath else
        {
            return
        }
        let cell = rightTableView.cellForRowAtIndexPath(indexPath) as! NBShopRightCell
        cell.dataItem = NBProductDataUtil.shareUtil.productData
        */
        let infoData = info.userInfo! as NSDictionary
        guard let num = infoData["number"] as? Int else
        {
            return
        }
        guard let productID = infoData["productId"] as? String else
        {
            return
        }
        chooseProduct(productID, num: num)
        
    }
    private func chooseProduct(productStr : String, num : Int)
    {
        if productRefresh.dataList.count <= 0
        {
            return
        }
        for var i = 0; i < productRefresh.dataList.count; i++
        {
            let item = productRefresh.dataList[i] as! NBProductListModel
            if item.id == productStr
            {
                item.addNumber = num
                break
            }
        }
        rightTableView.reloadData()
    }
    //分类产品数据加载
    private func loadCategoryData()
    {
        weak var wkself = self
        let dictM = NSMutableDictionary()
        dictM["page"] = "1"
        dictM["pagesize"] = "20"
        dictM["version_code"] = "20160426"
        NBAFNManagerTool.shareInstance.listProductCategories(dictM) { (task, result, error) -> () in
            if error == nil
            {
                let requestData = result as! NSDictionary
                NSLog("%@", requestData)
                let data = requestData["data"]
                let message = requestData["message"]
                let code = requestData["code"]?.integerValue
                if code == 0 {
                   wkself!.categoryRefresh.dataList = NBModelTool.modelObjectArrayWithKeyValuesArray(NBCategoryModel.classForCoder(), keyValuesArray: data as! NSArray)
                    wkself?.categoryRefresh.tableView?.reloadData()
                    if wkself?.selectCategory == nil
                    {
                        wkself?.setUpdateProduct(0)
                    }
                   NSLog("%@", data as! NSArray)
                }
                else
                {
                     NSLog("%@", message as! String)
                }
                
            }
            else
            {
                
            }
            self.categoryRefresh.endLoading()
        }
    }
    //产品数据加载
    private func loadProductData()
    {
        let categoryId = selectCategory!.id
        if (categoryId! as NSString).length <= 0
        {
            return
        }
        weak var wkself = self
        let dictM = NSMutableDictionary()
        dictM["categoryId"] = categoryId
        dictM["page"] = "1"
        dictM["pagesize"] = "20"
        dictM["version_code"] = "20160426"
        
        NBAFNManagerTool.shareInstance.listProductList(dictM) { (task, result, error) -> () in
            if error == nil
            {
                let requestData = result as! NSDictionary
                NSLog("___%@___", requestData)
                let data = requestData["data"]
                let message = requestData["message"]
                let code = requestData["code"]?.integerValue
                if code == 0 {
                    wkself!.productRefresh.dataList = NBModelTool.modelObjectArrayWithKeyValuesArray(NBProductListModel.classForCoder(), keyValuesArray: data as! NSArray)
                    NSLog("%@", wkself!.productRefresh.dataList)
                    //缓存数据
                    NBProductDataUtil.shareUtil.cacheInsertProduct(wkself!.productRefresh.dataList)
                    //更新表格
                    wkself?.productRefresh.tableView?.reloadData()
                    NSLog("%@", data as! NSArray)
                }
                else
                {
                    NSLog("%@", message as! String)
                }
                
            }
            else
            {
                
            }
            self.productRefresh.endLoading()
        }

    }
    
    private func setUpdateProduct(index : Int)
    {
        if index >= categoryRefresh.dataList.count
        {
            return
        }
        guard let category = categoryRefresh.dataList[index] as? NBCategoryModel else
        {
            return
        }
        selectCategory = category
//        productRefresh.reloadData()
        
    }
    //MAKR:--懒加载
    //左边图
    private lazy var leftTableView : UITableView = {
        let tableView = UITableView()
//        tableView.dataSource = self;
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.rowHeight = 65
        tableView.backgroundColor = UIColor(red: 241 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
        return tableView
    }()
    //右边图
    private lazy var rightTableView : UITableView = {
        let tableView = UITableView()
//        tableView.dataSource = self;
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.rowHeight = 90
        tableView.backgroundColor = UIColor(red: 234 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, alpha: 1)
        return tableView
    }()
    
    private var selectCategory : NBCategoryModel? {
        willSet{
            if selectCategory == newValue
            {
                return
            }
//            selectCategory = newValue
            productRefresh.reloadData()
        }
    }

}

extension NBShopLRView : RefreshToolDelegate {
    /*
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView == self.leftTableView)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(leftCell, forIndexPath: indexPath)
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(rightCell, forIndexPath: indexPath)
            return cell
        }
    }
    */
    func refreshData(target: AnyObject?, onLoad: Int?) {
         let refreshTool = target as! NBMJRefreshTool
        if refreshTool.tableView == leftTableView
        {
            loadCategoryData()
            
        }
        else
        {
            loadProductData()
        }
        
    }
    func refreshTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView == self.leftTableView)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(leftCell, forIndexPath: indexPath) as! NBShopLeftCell
            cell.dataItem = categoryRefresh.dataList[indexPath.row] as? NBCategoryModel
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(rightCell, forIndexPath: indexPath) as! NBShopRightCell
            cell.dataItem = productRefresh.dataList[indexPath.row] as? NBProductListModel
            return cell
        }
    }
}
extension NBShopLRView : UITableViewDelegate
{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == leftTableView
        {
            selectCategory = categoryRefresh.dataList[indexPath.row] as? NBCategoryModel
        }
        else if tableView == rightTableView
        {
            NSLog("rightView")
            NBProductDataUtil.shareUtil.productData = self.productRefresh.dataList[indexPath.row] as? NBProductListModel
            selectIndexPath = indexPath
        NSNotificationCenter.defaultCenter().postNotificationName("keyDidSelectCellNotify", object: nil, userInfo: ["dataItem" : self.productRefresh.dataList[indexPath.row]])
        }
        NSLog("hello")
    }
}
