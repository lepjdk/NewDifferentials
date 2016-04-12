//
//  NBShopTittleView.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/12.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBShopTittleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpChildView()
        setUpChildLayout(frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpChildView() {
        self.addSubview(shopView)
        self.addSubview(activityView)
        self.addSubview(lineView)
    }
    private func setUpChildLayout(frame: CGRect)
    {
        shopView.frame = CGRect(x: 0, y: 0, width: frame.size.width * 0.5, height: frame.size.height - 10)
        activityView.frame = CGRect(x: frame.size.width * 0.5, y: 0, width: frame.size.width * 0.5, height: frame.size.height - 10)
        lineView.frame = CGRect(x: 0, y: CGRectGetMaxY(shopView.frame) + 2, width: frame.size.width * 0.5, height: 3)
    }
    
    private lazy var shopView : UIButton = {
        let btn = UIButton()
        btn.setTitle("商品", forState: .Normal)
        btn.tag = 0
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.addTarget(self, action: Selector("btnClick:"), forControlEvents: .TouchUpInside)
        return btn
    }()
    private lazy var activityView : UIButton = {
        let btn = UIButton()
        btn.setTitle("活动", forState: .Normal)
        btn.tag = 1
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.addTarget(self, action: Selector("btnClick:"), forControlEvents: .TouchUpInside)
        return btn
    }()
    lazy var lineView : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 255.0/256.0, green: 159.0/256.0, blue: 0.0, alpha: 1)
        return line
    }()
    
    func btnClick(btn : UIButton)
    {
        let dict = NSDictionary(dictionary: ["btnTag" : btn.tag])
        NSNotificationCenter.defaultCenter().postNotificationName("keyNotifyShop", object: nil, userInfo: dict as [NSObject : AnyObject])
    }

}
