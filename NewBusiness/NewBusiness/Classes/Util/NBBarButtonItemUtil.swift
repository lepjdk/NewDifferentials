//
//  NBBarButtonItemUtil.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/14.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBBarButtonItemUtil: UIBarButtonItem {

    convenience init(tittle: String, color: UIColor, target: AnyObject?, action: Selector) {
        let btn = UIButton()
        btn.setTitle(tittle, forState: .Normal)
        btn.setTitleColor(color, forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(13)
        btn.sizeToFit()
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        self.init(customView: btn)
    }
}
