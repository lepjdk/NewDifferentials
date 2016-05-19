//
//  NBShopChatViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/5/10.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBShopChatViewController: NBBaseViewController {

    private let cellID = "chatShopCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allSelectBtn: UIButton!
    @IBOutlet weak var tottalPriceLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var buyListBtn: UIButton!
    
    private let chatProductRefresh = NBMJRefreshTool()
    private var checkedArr = NSMutableArray()
    private var sqlProductArr = NSMutableArray()
    //MARK: -生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()

        emptyView.hidden = true
        tableView.separatorStyle = .None
        self.title = "购物车"
        chatProductRefresh.tableView = tableView
        chatProductRefresh.delegate = self
        chatProductRefresh.reloadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("checkBtnClick:"), name: "kCheckedNotify", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeProductClick:"), name: "keyChangeProductNotify", object: nil)
        
        tableView.registerNib(UINib.init(nibName: "NBShopChatCell", bundle: nil), forCellReuseIdentifier: cellID)
        
    }

    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: -内部方法
    private func updateChatShopData()
    {
        let arr = NBProductDataUtil.shareUtil.getShopChatData()
        if arr.count <= 0
        {
            dealEmpty(false)
            chatProductRefresh.endLoading()
            return
        }
        let pramArr = NSMutableArray()
        for var i = 0; i < arr.count; i++
        {
            let dict = arr[i] as! NSDictionary
            pramArr.addObject(dict["productId"]!)
        }
        sqlProductArr = NBModelTool.modelObjectArrayWithKeyValuesArray(NBChatSQLDataModel.classForCoder(), keyValuesArray: arr)
        let pramDict = NSMutableDictionary()
        pramDict["productIds"] = pramArr
        pramDict["version_code"] = "20160426"
        weak var wkself = self
        NBAFNManagerTool.shareInstance.shopChatList(pramDict) { (task, result, error) -> () in
            if error == nil{
                let requestData = result as! NSDictionary
                NSLog("%@", requestData)
                let data = requestData["data"]
                let message = requestData["message"]
                let code = requestData["code"]?.integerValue
                if code == 0 {
                    let chatShopData = NBModelTool.modelObjectWithKeyValues(NBShopChatModel.classForCoder(), keyValues: data!) as! NBShopChatModel
                    if chatShopData.productIds?.count <= 0
                    {
                        return
                    }
                    let modelArr = NSMutableArray()
                    for var i = 0;  i < chatShopData.productIds?.count; i++
                    {
                        let productId = chatShopData.productIds![i]
                        guard let productModel = wkself!.getProductById(productId as! String) else
                        {
                            continue
                        }
                        modelArr.addObject(productModel)
                    }
                    wkself?.chatProductRefresh.dataList = modelArr
                    if modelArr.count > 0
                    {
                        wkself?.dealEmpty(true)
                    }
                    else
                    {
                        wkself?.dealEmpty(false)
                    }
                    wkself?.chatProductRefresh.tableView!.reloadData()
                }
                else
                {
                    NSLog("%@", message as! String)
                }
            }
            wkself?.chatProductRefresh.endLoading()
            
        }
    }
    
    private func getProductById(strId : String) -> NBChatSQLDataModel?
    {
        var model = NBChatSQLDataModel()
        if sqlProductArr.count <= 0
        {
            return nil
        }
        for var i = 0; i < sqlProductArr.count; i++
        {
            let item = sqlProductArr[i] as! NBChatSQLDataModel
            if item.productId == strId
            {
                model = item
                return model
            }
        }
        return nil
    }
    
    @objc private func checkBtnClick(info : NSNotification)
    {
        let infoData = info.userInfo! as NSDictionary
        guard let data = infoData["data"] as? NBChatSQLDataModel else
        {
            return
        }
        let ischeck = infoData["isCheck"] as! Bool
        if checkedArr.containsObject(data)
        {
            if ischeck == false
            {
                checkedArr.removeObject(data)
            }
        }
        else
        {
            if ischeck == true
            {
                checkedArr.addObject(data)
            }
        }
        updateTottalData()
        updateAllSelect()
    }
    private func updateAllSelect()
    {
        if chatProductRefresh.dataList.count <= 0
        {
            allSelectBtn.selected = false
            return
        }
        if checkedArr.count >= chatProductRefresh.dataList.count
        {
            allSelectBtn.selected = true
        }
        else
        {
            allSelectBtn.selected = false
        }
    }
    @objc private func changeProductClick(notify : NSNotification)
    {
        let info = notify.userInfo! as NSDictionary
        guard let number = info["number"]?.integerValue else
        {
            return
        }
        guard let productID = info["productId"] as? String else
        {
            return
        }
        if number <= 0
        {
            chooseProduct(productID)
            updateAllSelect()
        }
        updateTottalData()
//        updateData(number)
    }
    private func updateTottalData()
    {
        if checkedArr.count <= 0
        {
            tottalPriceLabel.text = "¥0.0"
            return
        }
        var tottalP : Double = 0.0
        for var i = 0; i < checkedArr.count; i++
        {
            let item = checkedArr[i] as! NBChatSQLDataModel
            let price = item.price
            let num = item.amount
            tottalP += price * Double(num)
        }
        tottalPriceLabel.text = NSString(format: "¥%.1lf", tottalP) as String
    }
    private func chooseProduct(productStr : String)
    {
        if chatProductRefresh.dataList.count <= 0
        {
            return
        }
        for var i = 0; i < chatProductRefresh.dataList.count; i++
        {
            let item = chatProductRefresh.dataList[i] as! NBChatSQLDataModel
            if item.productId == productStr
            {
                chatProductRefresh.dataList.removeObjectAtIndex(i)
                break
            }
        }
        if checkedArr.count > 0
        {
            for var i = 0; i < checkedArr.count; i++
            {
                let item = checkedArr[i] as! NBChatSQLDataModel
                if item.productId == productStr
                {
                    checkedArr.removeObjectAtIndex(i)
                    break
                }
            }
        }
        if chatProductRefresh.dataList.count <= 0
        {
            dealEmpty(false)
        }
        else
        {
            dealEmpty(true)
        }
        tableView.reloadData()
        
    }
    private func dealEmpty(flag : Bool)
    {
        emptyView.hidden = flag
        allSelectBtn.enabled = flag
        buyListBtn.enabled = flag
        buyListBtn.backgroundColor = flag ? UIColor(red: 1.0, green: 159 / 255.0, blue: 0, alpha: 1) : UIColor.lightGrayColor()
    }
    //MARK: -内部控制方法
    @IBAction func allSelectClick(sender: AnyObject) {
        allSelectBtn.selected = !allSelectBtn.selected
        checkedArr.removeAllObjects()
        if allSelectBtn.selected == true
        {
            checkedArr.addObjectsFromArray(chatProductRefresh.dataList as [AnyObject])
        }
        tableView.reloadData()
        updateTottalData()
    }
    @IBAction func toBuyProductClick(sender: AnyObject) {
        if checkedArr.count <= 0
        {
            return
        }
        
    }
    
    //MARK: -懒加载
}

extension NBShopChatViewController : UITableViewDelegate
{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 98
    }
}
extension NBShopChatViewController : RefreshToolDelegate
{
    func refreshData(target: AnyObject?, onLoad: Int?) {
        updateChatShopData()
    }
    func refreshTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! NBShopChatCell
        cell.selectionStyle = .None
        cell.allChecked = allSelectBtn.selected
        cell.dataItem = self.chatProductRefresh.dataList[indexPath.row] as? NBChatSQLDataModel
        return cell
    }
}
/*
extension NBShopChatViewController : UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! NBShopChatCell
        cell.selectionStyle = .None
        return cell
    }
}
*/