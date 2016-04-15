//
//  NBMarkLabel.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/14.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBMarkLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    private func setUpView()
    {
        self.layer.cornerRadius = self.frame.size.width * 0.5
        self.layer.masksToBounds = true
    }

}
