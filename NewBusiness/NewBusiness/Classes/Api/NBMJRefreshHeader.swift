//
//  NBMJRefreshHeader.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/23.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBMJRefreshHeader: MJRefreshGifHeader {

    //设置准备初始化信息
    override func prepare() {
        super.prepare()
        //普通闲置状态
        let idleImages = addImages(1, endNum: 50)
        self.setImages(idleImages as [AnyObject], forState: .Idle)
        self.setTitle("下拉刷新", forState: .Idle)
        //松开就可以进行刷新的状态
        let refreshingImages = addImages(50, endNum: 50)
        self.setImages(refreshingImages as [AnyObject], forState: .Pulling)
        self.setTitle("松手刷新", forState: .Pulling)
        //正在刷新中的状态
        let startImages = addImages(50, endNum: 77)
        self.setImages(startImages as [AnyObject], forState: .Refreshing)
        self.setTitle("正在加载..", forState: .Refreshing)
        
        self.stateLabel?.textColor = UIColor.blackColor()
        self.lastUpdatedTimeLabel?.textColor = UIColor.blackColor()
        self.stateLabel?.font = UIFont(name: "PingFangSC-light", size: 13)
        self.lastUpdatedTimeLabel?.font = UIFont(name: "PingFangSC-light", size: 12)
        
    }
    // 设置刷新动图的位置
    override func placeSubviews() {
        super.placeSubviews()
        if self.gifView!.constraints.count == 0 {
            return
        }
        self.gifView!.frame = self.bounds;
        if self.stateLabel!.hidden && self.lastUpdatedTimeLabel!.hidden {
            self.gifView?.contentMode = .Center
        }
        else
        {
            self.gifView?.contentMode = .Right
            self.gifView?.mj_w = self.mj_w * 0.5 - 70
        }
    }
    
    //添加图片
    private func addImages(startNum : Int, endNum : Int) -> NSMutableArray
    {
        let images = NSMutableArray()
        for var i = startNum ; i <= endNum ; ++i {
            let imageName = NSString(format: "loading_0%02zd", i)
            let image = UIImage(named: imageName as String)
            if image != nil {
                let newImage = scallImage(image!, imageSize: CGSizeMake(40, 40))
                images.addObject(newImage)
            }
        }
        return images
    }
    //设置图片的大小
    private func scallImage(imageName : UIImage, imageSize : CGSize) -> UIImage
    {
        /*
        UIImage *sourceImage = image;
        UIImage *newImage = nil;
        CGSize imageSize = sourceImage.size;
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        CGFloat targetWidth = targetSize.width;
        CGFloat targetHeight = targetSize.height;
        CGFloat scaleFactor = 0.0;
        CGFloat scaledWidth = targetWidth;
        CGFloat scaledHeight = targetHeight;
        CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
        if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
        scaleFactor = widthFactor;
        else
        scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor < heightFactor) {
        
        thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
        thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
        }
        // this is actually the interesting part:
        UIGraphicsBeginImageContext(targetSize);
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        [sourceImage drawInRect:thumbnailRect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if(newImage == nil)
        NSLog(@"could not scale image");
        return newImage ;
        */
        let sourceImage = imageName
        var newImage = UIImage()
        UIGraphicsBeginImageContext(imageSize)
        var rect = CGRect()
        rect.size = imageSize
        rect.origin = CGPointMake(0.0, 0.0)
        sourceImage.drawInRect(rect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

}
