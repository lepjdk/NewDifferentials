//
//  NBSaleViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBSaleViewController: NBBaseViewController {

    //MAKR:--属性变量
    //订单列表视图
    @IBOutlet weak var tottalSalesLabel: UILabel!
    //我的月零售额
    @IBOutlet weak var meRetailMothSalesLabel: UILabel!
    //团队月销售额
    @IBOutlet weak var teamMothSalesLabel: UILabel!
    //总销售额
    @IBOutlet weak var orderViewList: UIView!
    
    //MAKR:--生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置订单列表
        orderViewList.addSubview(orderView)
        orderView.frame = orderViewList.bounds
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MAKR:-- 内部控制方法
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

   
    //MAKR:--懒加载
    private lazy var orderView = NBOrderListView.orderListView()
}
