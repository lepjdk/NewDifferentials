//
//  NBActivityView.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/12.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBActivityView: UIView {

    let screenW = UIScreen.mainScreen().bounds.size.width
    let screenH = UIScreen.mainScreen().bounds.size.height
    private let cellID = "activityCell"
    private let contentRefresh  = NBMJRefreshTool()
    //MARK:--生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SetUpChildView()
        SetUpchildLayout()
        //设置数据加载
        setUpRefreshTool()
        contentView.registerNib(UINib.init(nibName: "NBActivityListCell", bundle: nil), forCellReuseIdentifier: cellID)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:--内部控制方法
    private func SetUpChildView()
    {
        self.addSubview(emptyImage)
        self.addSubview(emptyLabel)
        self.addSubview(contentView)
    }
    private func SetUpchildLayout()
    {
        emptyImage.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
        emptyImage.center = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5 - 35)
        emptyLabel.center = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5 + 35)
        contentView.frame = self.bounds
    }
    //刷新控件设置
    private func setUpRefreshTool()
    {
        contentRefresh.tableView = contentView
        contentRefresh.delegate = self
        //开始刷新
        contentRefresh.reloadData()
    }
    //产品数据加载
    private func loadActivtyData()
    {
        weak var wkself = self
        let dictM = NSMutableDictionary()
        dictM["page"] = "1"
        dictM["pagesize"] = "20"
        dictM["version_code"] = "20160426"
        
        NBAFNManagerTool.shareInstance.activityList(dictM) { (task, result, error) -> () in
            if error == nil
            {
                let requestData = result as! NSDictionary
                NSLog("___%@___", requestData)
                let data = requestData["data"]
                let message = requestData["message"]
                let code = requestData["code"]?.integerValue
                if code == 0 {
                    wkself!.contentRefresh.dataList = NBModelTool.modelObjectArrayWithKeyValuesArray(NBActivityModel.classForCoder(), keyValuesArray: data as! NSArray)
                    wkself?.contentRefresh.tableView?.reloadData()
                    if wkself!.contentRefresh.dataList.count <= 0
                    {
                        wkself?.contentView.backgroundColor = UIColor.clearColor()
                    }
                    else
                    {
                        wkself?.contentView.backgroundColor = UIColor.whiteColor()
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
            self.contentRefresh.endLoading()
        }
        
    }

    //MARK:--懒加载
    private lazy var emptyImage : UIImageView = {
       let imageV = UIImageView()
        imageV.image = UIImage(named: "img_nothing")
        return imageV
    }()
    private lazy var emptyLabel : UILabel = {
        let label = UILabel()
        label.text = "暂时没有活动噢"
//        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(13)
        label.sizeToFit()
        return label
    }()
    
    private lazy var contentView : UITableView = {
        let table = UITableView()
        table.separatorStyle = .None
        table.delegate = self
        return table
    }()

}

extension NBActivityView : UITableViewDelegate
{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
}

extension NBActivityView : RefreshToolDelegate
{
    func refreshData(target: AnyObject?, onLoad: Int?) {
        loadActivtyData()
    }
    func refreshTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! NBActivityListCell
        return cell
    }
}
