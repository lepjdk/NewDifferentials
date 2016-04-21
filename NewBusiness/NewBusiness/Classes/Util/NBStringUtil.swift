//
//  NBStringUtil.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/19.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBStringUtil: NSObject {
    
    //MD5 （32位小写）加密
    class func MD5Encrypt(str : String) -> String
    {
        let cString = str.cStringUsingEncoding(NSUTF8StringEncoding)
        let length = CUnsignedInt(
            str.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        )
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(
            Int(CC_MD5_DIGEST_LENGTH)
        )
        
        CC_MD5(cString!, length, result)
        
        return String(format:
            "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]).lowercaseString
    }

}
