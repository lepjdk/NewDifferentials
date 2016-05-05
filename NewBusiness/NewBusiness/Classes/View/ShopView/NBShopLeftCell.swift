//
//  NBShopLeftCell.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/12.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBShopLeftCell: UITableViewCell {

    @IBOutlet weak var indicatorV: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productIcon: UIImageView!
    
    var dataItem : NBCategoryModel? {
        didSet
            {
//                indicatorV.backgroundColor = UIColor.whiteColor()
                NBWebImageTool.shareTool.setImageViewWithImage(productIcon, urlStr: dataItem?.image, placeholderImage: "img_default_product")
                productName.text = dataItem?.name
                
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
