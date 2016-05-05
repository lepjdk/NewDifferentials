//
//  NBShopRightCell.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/12.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBShopRightCell: UITableViewCell {

    let screenW = UIScreen.mainScreen().bounds.size.width
    //MAKR:--xib属性
    @IBOutlet weak var productIcon: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var addNumber: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productNumber: UILabel!
    @IBOutlet weak var productName: UILabel!
    var dataItem : NBProductListModel? {
        didSet
        {
            NBWebImageTool.shareTool.setImageViewWithImage(productIcon, urlStr: dataItem?.thumbImg, placeholderImage: "img_default_product")
            productName.text = dataItem?.name
            //"¥ " 库存: 10000
            productPrice.text = NSString(format: "¥ %.1lf", (dataItem?.price)!) as String
            productNumber.text = NSString(format: "库存: %d", (dataItem?.stock)!) as String
            let num =  NBProductDataUtil.shareUtil.searchProduct(dataItem!)
            if num <= 0
            {
                deleteBtn.hidden = true
                addNumber.hidden = true
            }
            else
            {
                deleteBtn.hidden = false
                addNumber.hidden = false
            }
            dataItem?.addNumber = num
            addNumber.text = NSString(format: "%d", num) as String
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
        deleteBtn.hidden = true
        addNumber.hidden = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MAKR:--内部控制方法
    @IBAction func deleteBtnClick(sender: UIButton) {
        //更新数据操作
        updateData(sender)
     }
    
    @IBAction func addBtnClick(sender: UIButton) {
        //更新数据操作
        addChangeAnimation(sender)
    }
    //更新数据操作
    private func updateData(sender: UIButton)
    {
        if sender == addBtn
        {
            deleteBtn.hidden = false
            addNumber.hidden = false
            dataItem?.addNumber += 1
            if dataItem?.addNumber >= dataItem?.stock
            {
                addBtn.hidden = true
            }
            else
            {
                addBtn.hidden = false
            }
        NSNotificationCenter.defaultCenter().postNotificationName("keyAddProductNotify", object: nil, userInfo: ["number" : (dataItem?.addNumber)!, "cell" : self])
        }
        else if sender == deleteBtn
        {
            addBtn.hidden = false
            dataItem?.addNumber -= 1
            if dataItem?.addNumber <= 0
            {
                deleteBtn.hidden = true
                addNumber.hidden = true
            }
            else
            {
                deleteBtn.hidden = false
                addNumber.hidden = false
            }
        NSNotificationCenter.defaultCenter().postNotificationName("keyDelProductNotify", object: nil, userInfo: ["number" : (dataItem?.addNumber)!])
        }
        addNumber.text = NSString(format: "%d", (dataItem?.addNumber)!) as String
        //更新数据
        NBProductDataUtil.shareUtil.updateProductData(dataItem!)
    }
    
    //动画
    private func addChangeAnimation(sender: UIButton)
    {
        let imageV = self.productIcon
        let newIamgeV = UIImageView()
        var rect = imageV.frame
        rect.origin.x -= 8
        rect.origin.y -= 8
        let newRect = imageV.convertRect(rect, toView: nil)
        newIamgeV.image = imageV.image
        newIamgeV.contentMode = .ScaleAspectFill
        newIamgeV.clipsToBounds = true
        newIamgeV.frame = newRect
        UIApplication.sharedApplication().keyWindow?.addSubview(newIamgeV)
        
        let fromePoint = newIamgeV.center
        let toPoint = CGPointMake(screenW - 35, 49)
        let curPoint = CGPointMake((toPoint.x - fromePoint.x) * 1.4, toPoint.y - fromePoint.y)
        let path = UIBezierPath()
        path.moveToPoint(fromePoint)
        path.addQuadCurveToPoint(toPoint, controlPoint: curPoint)
        
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        animation1.path = path.CGPath
        let animation2 = CABasicAnimation(keyPath: "transform.rotation")
        animation2.toValue = M_PI * 2
        let animation3 = CABasicAnimation(keyPath: "transform.scale")
        animation3.toValue = 0
        let grounp = CAAnimationGroup()
        grounp.duration = 0.5
        grounp.animations = [animation1, animation2, animation3]
        grounp.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        newIamgeV.layer.addAnimation(grounp, forKey: nil)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            newIamgeV.removeFromSuperview()
            self.updateData(sender)
        }
    }
    
}
