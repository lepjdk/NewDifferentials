//
//  NBOrderListView.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/13.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBOrderListView: UIView {
    //MAKR:--xib属性
    @IBOutlet weak var confirmingLable: UILabel!
    @IBOutlet weak var paymentingLabel: UILabel!
    @IBOutlet weak var receiveGooded: UILabel!
    @IBOutlet weak var sendgooded: UILabel!
    @IBOutlet weak var sendGoodingLabel: UILabel!
    private var isLoadView : Bool = true
    
    //MAKR:--事件监听
    //订单点击监听事件
    /** 
    *btn.Tag
    *待确认:1
    *待付款:2
    *待发货:3
    *已发货:4
    *已收货:5
    */
    @IBAction func btnClick(sender: AnyObject) {
        
    }
    
    override func awakeFromNib() {

        let radius = confirmingLable.bounds.size.width * 0.5
        confirmingLable.layer.cornerRadius = radius
        confirmingLable.layer.masksToBounds = true
        paymentingLabel.layer.cornerRadius = radius
        paymentingLabel.layer.masksToBounds = true
        receiveGooded.layer.cornerRadius = radius
        receiveGooded.layer.masksToBounds = true
        sendgooded.layer.cornerRadius = radius
        sendgooded.layer.masksToBounds = true
        sendGoodingLabel.layer.cornerRadius = radius
        sendGoodingLabel.layer.masksToBounds = true
        
    }
    //MAKR:--外部控制方法
    class func orderListView() -> NBOrderListView
    {
        return NSBundle.mainBundle().loadNibNamed("NBOrderListView", owner: nil, options: nil).first as! NBOrderListView
    }
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
        if(isLoadView)
        {
            let radius = confirmingLable.bounds.size.width * 0.5
            confirmingLable.layer.cornerRadius = radius
            confirmingLable.layer.masksToBounds = true
            paymentingLabel.layer.cornerRadius = radius
            paymentingLabel.layer.masksToBounds = true
            receiveGooded.layer.cornerRadius = radius
            receiveGooded.layer.masksToBounds = true
            sendgooded.layer.cornerRadius = radius
            sendgooded.layer.masksToBounds = true
            sendGoodingLabel.layer.cornerRadius = radius
            sendGoodingLabel.layer.masksToBounds = true
            isLoadView = false
        }
    }
    */

}
