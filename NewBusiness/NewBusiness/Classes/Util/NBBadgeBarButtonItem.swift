//
//  NBBadgeBarButtonItem.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/12.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBBadgeBarButtonItem: UIBarButtonItem {
    
    func badgeItemWithView(view : UIView) -> NBBadgeBarButtonItem
    {
//        self.dynamicType.init(customView : view)
        self.customView?.addSubview(view)
        self.customView?.addSubview(badgeLabel)
        badgeLabel.frame = CGRect(x: 7 , y: -9, width: 5, height: 5)
        badgeLabel.layer.cornerRadius = 2.5
        badgeLabel.layer.masksToBounds = true
        return self
    }
    
    override init() {
        super.init()
        
    }
    
//    convenience init(view : UIView , label : UILabel)
//    {
//        self.init(customView: view)
//        self.customView?.addSubview(badgeLabel)
//        badgeLabel.frame = CGRect(x: 7 , y: -9, width: 5, height: 5)
//        badgeLabel.layer.cornerRadius = 2.5
//        badgeLabel.layer.masksToBounds = true
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var badgeLabel : UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.redColor()
        return label
    }()
    
    

}
