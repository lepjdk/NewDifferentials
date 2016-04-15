//
//  NBShopViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBShopViewController: NBBaseViewController {

    let screenW = UIScreen.mainScreen().bounds.size.width
    let screenH = UIScreen.mainScreen().bounds.size.height
    //MAKR:--生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        
        //设置导航条tittle视图
        self.navigationItem.titleView = shopTitleView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightItemView)
        
        //添加子控件
        setUpChildView()
        
        //监听通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("tittleViewBtnChanged:"), name: "keyNotifyShop", object: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit
   {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
    }
    
    //MAKR ：－－内部方法
    private func setUpChildView()
    {
        //添加搜索视图
        self.view.addSubview(scrollContentView)
        self.scrollContentView.addSubview(searchView)
        self.scrollContentView.addSubview(shopLRView)
        self.scrollContentView.addSubview(activityView)
    
    }
    //监听头部按钮切换点击事件
    func tittleViewBtnChanged(notify : NSNotification)
    {
        let info = notify.userInfo! as NSDictionary
        let tag = CGFloat((info["btnTag"]?.floatValue)!)
        var offset = scrollContentView.contentOffset
        offset.x = screenW * tag
        var lineRect = shopTitleView.lineView.frame
        lineRect.origin.x = tag * (shopTitleView.frame.size.width * 0.5)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.scrollContentView.contentOffset = offset
            self.shopTitleView.lineView.frame = lineRect
            }) { (Bool) -> Void in
                
        }
    }
    
    //MAKR ：－－懒加载
    private lazy var shopTitleView : NBShopTittleView = {
        let view = NBShopTittleView.init(frame: CGRect(x: 0, y: 0, width: 180, height: 44))
        return view
    }()
    /*
    private lazy var badgeItem : NBBadgeBarButtonItem = {
        let barItem = NBBadgeBarButtonItem()
        let chatBtn = UIButton()
        chatBtn.setImage(UIImage(named: "ic_nav_cart"), forState: .Normal)
        barItem.badgeItemWithView(chatBtn)
        chatBtn.sizeToFit()
        return barItem
    }()
*/
    private lazy var rightItemView : UIView = {
        let bgView = UIView()
        bgView.bounds = CGRect(x: 0, y: 0, width: 35, height: 35)
        let chatBtn = UIButton()
        chatBtn.setImage(UIImage(named: "ic_nav_cart"), forState: .Normal)
        chatBtn.setImage(UIImage(named: "ic_nav_cart"), forState: .Highlighted)
        chatBtn.frame = bgView.bounds
        chatBtn.sizeToFit()
        bgView.addSubview(chatBtn)
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.redColor()
        label.frame = CGRect(x: 20 , y: -5, width: 20, height: 20)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        bgView.addSubview(label)
        return bgView
    }()
    
    private lazy var scrollContentView : UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.frame = CGRect(x: 0, y: 64, width: self.screenW, height: self.screenH - 49 - 64)
        scrollV.contentSize = CGSize(width: self.screenW * 2, height: self.screenH - 49 - 64)
        scrollV.backgroundColor = UIColor.whiteColor()
        scrollV.pagingEnabled = true
        scrollV.delegate = self
        scrollV.showsHorizontalScrollIndicator = false
        return scrollV
    }()
    
    private lazy var searchView : NBSearchView = {
    
        let search = NBSearchView.init(frame: CGRect(x: 0, y: 0, width: self.screenW, height: 44))
//        search.layer.cornerRadius = 22
//        search.layer.masksToBounds = true
//        search.layer.borderColor = UIColor.whiteColor().CGColor;
//        search.layer.borderWidth = 8;
        search.delegate = self
        search.placeholderText = "输入商品名称搜索"
        return search
    }()
    
    private lazy var shopLRView : NBShopLRView = {
       let shopTbView = NBShopLRView.init(frame: CGRect(x: 0, y: 44, width: self.screenW, height: self.screenH - 64 - 44 - 49))
        return shopTbView
    }()
    
    private lazy var activityView : NBActivityView = {
        let activityV = NBActivityView.init(frame: CGRect(x: self.screenW, y: 0, width: self.screenW, height: self.screenH - 49 - 64))
        activityV.backgroundColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1)
        return activityV
    }()

}

//MAKR : -- searchViewDelegate代理
extension NBShopViewController : SearchViewDelegate
{
    func didClickSearchBtn() {
        let VC = UIViewController()
        VC.view.backgroundColor = UIColor.purpleColor()
        self.presentViewController(VC, animated: true, completion: nil)
    }
}
//MAKR : -- UIScrollViewDelegate代理
extension NBShopViewController : UIScrollViewDelegate
{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = scrollContentView.contentOffset.x
        if(offsetX < 0 || offsetX > screenW)
        {
            return
        }
        let offsetFloat = offsetX / screenW
        var lineRect = shopTitleView.lineView.frame
        lineRect.origin.x = offsetFloat * (shopTitleView.frame.size.width * 0.5)
        self.shopTitleView.lineView.frame = lineRect
    }
}
