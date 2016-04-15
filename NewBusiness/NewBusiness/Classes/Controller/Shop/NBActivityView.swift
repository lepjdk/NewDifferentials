//
//  NBActivityView.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/12.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBActivityView: UIView {

    //MAKR:--生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SetUpChildView()
        SetUpchildLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MAKR:--内部控制方法
    private func SetUpChildView()
    {
        self.addSubview(emptyImage)
        self.addSubview(emptyLabel)
    }
    private func SetUpchildLayout()
    {
        emptyImage.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
        emptyImage.center = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5 - 35)
        emptyLabel.center = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5 + 35)
    }
    
    //MAKR:--懒加载
    private lazy var emptyImage : UIImageView = {
       let imageV = UIImageView()
        imageV.image = UIImage(named: "img_nothing")
        return imageV
    }()
    private lazy var emptyLabel : UILabel = {
        let label = UILabel()
        label.text = "暂时没有活动噢"
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(13)
        label.sizeToFit()
        return label
    }()

}
