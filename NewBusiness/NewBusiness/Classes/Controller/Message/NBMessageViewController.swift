//
//  NBMessageViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBMessageViewController: NBBaseViewController {
    //MAKR:--xib属性参数
    @IBOutlet weak var searchView: NBSearchView!

    @IBOutlet weak var sendedProductMark: NBMarkLabel!
    @IBOutlet weak var payingMark: NBMarkLabel!
    @IBOutlet weak var sendingProductMark: NBMarkLabel!
    @IBOutlet weak var cellectingMark: NBMarkLabel!
    @IBOutlet weak var confermOrderMark: NBMarkLabel!
    //MAKR:--按钮事件监听
    @IBAction func systemMessageBtnClick() {
    }
    @IBAction func publicMessageBtnClick() {
    }
    @IBAction func vedioMessageBtnClick() {
    }
    @IBAction func classMessageBtnClick() {
    }
    /**
     btn.Tag
     1:确认订单信息
     2:待收款通知
     3:待发货通知
     4:待付款通知
     5:已发货通知
     */
    @IBAction func orderNotifyBtnClick(sender: AnyObject) {
    }
    //MAKR:--生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MAKR:--内部控制方法
    private func setUpView()
    {
        searchView.placeholderText = "搜索消息"
        searchView.delegate = self
    }

}
extension NBMessageViewController : SearchViewDelegate
{
    func didClickSearchBtn() {
        
    }
}
