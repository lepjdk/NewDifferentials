//
//  NBShopChatCell.swift
//  NewBusiness
//
//  Created by lepjdk on 16/5/11.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBShopChatCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var tottalPriceLabel: UILabel!
    @IBOutlet weak var numberTextF: UITextField!
    @IBOutlet weak var selectBtn: UIButton!
    
    var dataItem : NBChatSQLDataModel? {
        didSet
        {
            NBWebImageTool.shareTool.setImageViewWithImage(iconView, urlStr: dataItem?.image, placeholderImage: "img_default_product")
            productNameLabel.text = dataItem?.name
            //"¥ " 库存: 10000
            priceLabel.text = NSString(format: "¥ %.1lf", (dataItem?.price)!) as String
            numberLabel.text = NSString(format: "x %d", (dataItem?.amount)!) as String
            numberTextF.text = NSString(format: "%d", (dataItem?.amount)!) as String
            let tottalP = (dataItem?.price)! * Double((dataItem?.amount)!)
            tottalPriceLabel.text = NSString(format: "合计：¥%.1lf", tottalP) as String
        }
    }
    
    var allChecked : Bool?
        {
        didSet
        {
            selectBtn.selected = allChecked!
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func selectBtnClick(sender: UIButton) {
        selectBtn.selected = !selectBtn.selected
        
        NSNotificationCenter.defaultCenter().postNotificationName("kCheckedNotify", object: nil, userInfo: ["data" : dataItem!, "isCheck" : selectBtn.selected])
    }
    @IBAction func delNemberClcik(sender: UIButton) {
        //更新数据
        dataItem?.amount -= 1
        if dataItem?.amount <= 0
        {
            NSLog("空空如也")
            addAlertView()
            return
        }
        NBProductDataUtil.shareUtil.updateProductDataSql(dataItem!)
        updatData()
    }
    @IBAction func addNumberClick(sender: UIButton) {
        //更新数据
        dataItem?.amount += 1
        NBProductDataUtil.shareUtil.updateProductDataSql(dataItem!)
        updatData()
    }
    //更新数据
    private func updatData()
    {
        NBProductDataUtil.shareUtil.updateProductDataSql(dataItem!)
        numberLabel.text = NSString(format: "x %d", (dataItem?.amount)!) as String
        numberTextF.text = NSString(format: "%d", (dataItem?.amount)!) as String
        let tottalP = (dataItem?.price)! * Double((dataItem?.amount)!)
        tottalPriceLabel.text = NSString(format: "合计：¥%.1lf", tottalP) as String
     NSNotificationCenter.defaultCenter().postNotificationName("keyChangeProductNotify", object: nil, userInfo: ["number" : (dataItem?.amount)!, "productId" : (dataItem?.productId)!])
    }
    //创建警示框
    private func addAlertView()
    {
        weak var wkself = self
        let alertV = UIAlertController(title: "确定要移除吗", message: nil, preferredStyle: .Alert)
        let alertAction1 = UIAlertAction(title: "取消", style: .Default) { (action : UIAlertAction) -> Void in
            
        }
        let alertAction2 = UIAlertAction(title: "确定", style: .Default) { (action : UIAlertAction) -> Void in
            NBProductDataUtil.shareUtil.updateProductDataSql(wkself!.dataItem!)
            wkself!.updatData()
        }
        alertV.addAction(alertAction1)
        alertV.addAction(alertAction2)
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertV, animated: true, completion: nil)
    }
    
}
