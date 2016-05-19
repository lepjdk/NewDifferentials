//
//  NBOrderListView.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/13.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBOrderListView: UIView {
    //MARK:--xib属性
    @IBOutlet weak var confirmingLable: UILabel!
    @IBOutlet weak var paymentingLabel: UILabel!
    @IBOutlet weak var receiveGooded: UILabel!
    @IBOutlet weak var sendgooded: UILabel!
    @IBOutlet weak var sendGoodingLabel: UILabel!
    @IBOutlet weak var waitingDealLabel: UILabel!
    private var isLoadView : Bool = true
    
    //MARK:--事件监听
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
    //MARK:--外部控制方法
    class func orderListView() -> NBOrderListView
    {
        return NSBundle.mainBundle().loadNibNamed("NBOrderListView", owner: nil, options: nil).first as! NBOrderListView
    }
    func updateView(model : NBOrderStatusModel, isSeller : Bool)
    {
        if isSeller == true
        {
            waitingDealLabel.text = "待收款"
            confirmingLable.text = NSString(format: "%d", model.sellerWaitingOrderCount) as String
            paymentingLabel.text = NSString(format: "%d", model.sellerWaitingPayOrderCount) as String
            receiveGooded.text = NSString(format: "%d", model.sellerShopOrderCount) as String
            sendgooded.text = NSString(format: "%d", model.sellerShipOrderCount) as String
            sendGoodingLabel.text = NSString(format: "%d", model.sellerClosedOrderCount) as String
        }
        else
        {
            waitingDealLabel.text = "待付款"
            confirmingLable.text = NSString(format: "%d", model.buyerWaitingOrderCount) as String
            paymentingLabel.text = NSString(format: "%d", model.buyerWaitingPayOrderCount) as String
            receiveGooded.text = NSString(format: "%d", model.buyerShopOrderCount) as String
            sendgooded.text = NSString(format: "%d", model.buyerShipOrderCount) as String
            sendGoodingLabel.text = NSString(format: "%d", model.buyerClosedOrderCount) as String
        }
        confirmingLable.hidden = (confirmingLable.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 || confirmingLable.text == "0")
        paymentingLabel.hidden = (paymentingLabel.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 || paymentingLabel.text == "0")
        receiveGooded.hidden = (receiveGooded.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 || receiveGooded.text == "0")
        sendgooded.hidden = (sendgooded.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 || sendgooded.text == "0")
        sendGoodingLabel.hidden = (sendGoodingLabel.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0 || sendGoodingLabel.text == "0")
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
