//
//  NBShopRightCell.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/12.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBShopRightCell: UITableViewCell {

    //MAKR:--xib属性
    @IBOutlet weak var productIcon: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var addNumber: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productNumber: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MAKR:--内部控制方法
    @IBAction func deleteBtnClick(sender: AnyObject) {
        
     }
    
    @IBAction func addBtnClick(sender: AnyObject) {
    }
    
}
