//
//  NBPictureCollectionViewCell.swift
//  NewBusiness
//
//  Created by lepjdk on 16/5/6.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBPictureCollectionViewCell: UICollectionViewCell {
    
    var dataStr : String? {
       didSet
       {
          guard let url = NSURL(string: dataStr!) else
          {
            return
          }
          imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "ic_default_detail"))
       }
    }
    
    //MARK: -初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化操作
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -内部方法
    private func setUpView()
    {
        imageView.frame = self.contentView.bounds
        self.contentView.addSubview(imageView)
    }
    //MARK: -懒加载
    private lazy var imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "ic_default_detail")
        return imageV
    }()
    
}
