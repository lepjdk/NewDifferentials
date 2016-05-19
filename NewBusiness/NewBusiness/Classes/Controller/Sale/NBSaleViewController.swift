//
//  NBSaleViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBSaleViewController: NBBaseViewController {

    //MARK:--属性变量
    //总销售额
    @IBOutlet weak var tottalSalesLabel: UILabel!
    //我的月零售额
    @IBOutlet weak var meRetailMothSalesLabel: UILabel!
    //团队月销售额
    @IBOutlet weak var teamMothSalesLabel: UILabel!
    //订单列表视图
    @IBOutlet weak var orderViewList: UIView!
    
    var userInfo : NBUserModel?
    {
        didSet
        {
            teamMothSalesLabel.text = NSString(format: "%d", (userInfo?.orderStat?.monthlySaleMoney)!) as String
            meRetailMothSalesLabel.text = NSString(format: "%d", (userInfo?.orderStat?.monthlyRetailMoney)!) as String
            let tottalMoney = (userInfo?.orderStat?.monthlySaleMoney)! + (userInfo?.orderStat?.monthlyRetailMoney)!
            tottalSalesLabel.text = NSString(format: "%d", tottalMoney) as String
            orderView.updateView((userInfo?.orderStat)!, isSeller: true)
        }
    }
    
    //MARK:--生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置订单列表
        orderViewList.addSubview(orderView)
        orderView.frame = orderViewList.bounds
        //获取用户数据
        userInfo = NBUserUtil.shareUser.getUserModelInfo()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:-- 内部控制方法
    //我的返利按钮
    @IBAction func meReturnProfitBtnClick(sender: AnyObject) {
    }
    //我的零售订单按钮
    @IBAction func meRetailBtnClick(sender: AnyObject) {
    }
    //添加零售订单按钮
    @IBAction func addRetailListBtnClick(sender: AnyObject) {
    }
    //全部订单按钮
    @IBAction func allListBtnClick(sender: AnyObject) {
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        orderView.frame = orderViewList.bounds
//    }

   
    //MARK:--懒加载
    private lazy var orderView = NBOrderListView.orderListView()
}
