//
//  NBWebImageTool.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/26.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBWebImageTool: NSObject {

    static let shareTool : NBWebImageTool = {
        let share = NBWebImageTool()
        return share
    }()
    func setImageViewWithImage(imageV : UIImageView!, urlStr : String?, placeholderImage : String?){
        if urlStr == nil
        {
            return
        }
        let urlS = urlStr!.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        if (urlS! as NSString).length <= 0
        {
            return
        }
        let url = NSURL(string: urlS!)
        if placeholderImage == nil {
            imageV.sd_setImageWithURL(url)
            return
        }
        let image = UIImage(named: placeholderImage!)
        imageV.sd_setImageWithURL(url, placeholderImage: image)
        
    }
}
