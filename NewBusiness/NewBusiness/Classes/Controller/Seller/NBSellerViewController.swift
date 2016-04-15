//
//  NBSellerViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBSellerViewController: NBBaseViewController {

    let screenW = UIScreen.mainScreen().bounds.size.width
    let screenH = UIScreen.mainScreen().bounds.size.height
    //MAKR:--生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        
        //初始化导航控制器控件
        setUpNavgationView()
        
        //初始化子控件
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MAKR:--内部控制方法
    private func setUpNavgationView()
    {
        //left
        self.navigationItem.leftBarButtonItem = NBBarButtonItemUtil.init(tittle: "我的上级", color: UIColor.darkGrayColor(), target: self, action: Selector("upLevelClick"))
        //right
        self.navigationItem.rightBarButtonItem = NBBarButtonItemUtil.init(tittle: "邀请经销商", color: UIColor.darkGrayColor(), target: self, action: Selector("inviteBtnClick"))
    }
    private func setUpView()
    {
        self.view.addSubview(searchView)
        self.view.addSubview(contentSellerView)
        self.contentSellerView.addSubview(emptyImageV)
        self.contentSellerView.addSubview(emptyLabel)
        self.contentSellerView.addSubview(inviteBtn)
        emptyLabel.center = CGPoint(x: contentSellerView.bounds.size.width * 0.5, y: contentSellerView.bounds.size.height * 0.5)
        emptyImageV.center = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y - 70)
        inviteBtn.center = CGPoint(x: emptyLabel.center.x, y: emptyLabel.center.y + 50)
    
    }
    func upLevelClick()
    {
        NSLog("upLevelClick")
    }
    func inviteBtnClick()
    {
    
        NSLog("inviting")
    }
   //MAKR:--懒加载
    private lazy var searchView : NBSearchView = {
        
        let search = NBSearchView.init(frame: CGRect(x: 0, y: 64, width: self.screenW, height: 44))
        search.delegate = self
        search.placeholderText = "搜索经销商"
        return search
    }()
    private lazy var contentSellerView : UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 108, width: self.screenW, height: self.screenH - 64 - 44 - 49)
        view.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 241/255.0, alpha: 1)
        return view
    }()
    private lazy var emptyImageV : UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "img_invitepartner")
        imageV.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
        return imageV
    }()
    private lazy var emptyLabel : UILabel = {
        let label = UILabel()
        label.text = "您当前还没有经销商，邀请经销商一赚钱"
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(13)
        label.textAlignment = .Center
        label.sizeToFit()
        return label
    }()
    private lazy var inviteBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("去邀请", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(13)
        btn.backgroundColor = UIColor.orangeColor()
        btn.bounds = CGRect(x: 0, y: 0, width: 200, height:40)
        btn.addTarget(self, action: Selector("inviteBtnClick"), forControlEvents: .TouchUpInside)
        return btn
    }()

}
/** SearchViewDelegate代理方法*/
extension NBSellerViewController : SearchViewDelegate
{
    func didClickSearchBtn() {
        
    }
}
