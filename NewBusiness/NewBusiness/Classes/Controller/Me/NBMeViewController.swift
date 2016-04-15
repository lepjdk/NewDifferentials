//
//  NBMeViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBMeViewController: NBBaseViewController {

    //MAKR:--属性参数
    private let screenW = UIScreen.mainScreen().bounds.size.width
    private let screenH = UIScreen.mainScreen().bounds.size.height
    
    @IBOutlet weak var userNameLabel: UILabel!      //用户名
    @IBOutlet weak var avatarIcon: UIImageView!     //用户头像
    @IBOutlet weak var phoneNumberLabel: UILabel!   //用户手机号码
    @IBOutlet weak var differStandLabel: UILabel!   //积分相差值
    @IBOutlet weak var standingLabel: UILabel!      //积分
    @IBOutlet weak var dealerRankLabel: UILabel!    //经销商排名
    @IBOutlet weak var sealerInfoBtn: UIButton!     //经销商信息
    @IBOutlet weak var orderListView: UIView!
    
    //MAKR:--生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化控件
        setUpView()
       
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //设置导航条
        setUpNavigationView()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        //还原导航条
        returnOriginalNavigationView()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MAKR:--内部控制方法
    private func setUpView()
    {
        //导航条右边item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightSignInBtn)
        
        orderListView.addSubview(orderView)
        orderView.frame = orderListView.bounds
    }
    //设置导航条视图
    private func setUpNavigationView()
    {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.insertSubview(backView, atIndex: 0)
    }
    //还原导航条视图
    private func returnOriginalNavigationView()
    {
        //隐藏backView
        backView.hidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "na_backImage"), forBarMetrics: .Default)
        let rect = CGRect(x: 0, y: 0, width: self.screenW, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor(red: 163 / 255.0, green: 163 / 255.0, blue: 163 / 255.0, alpha: 1).CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.navigationController?.navigationBar.shadowImage = image
    }
    private func signInClick()
    {
        NSLog("签到")
    }
    //MAKR:--事件处理方法
    //用户详情点击
    @IBAction func userInfoBtnClick() {
    }
    //积分详情点击
    @IBAction func standingDetailClick(sender: AnyObject) {
    }
    //经销商点击
    @IBAction func dealerBtnClick() {
    }
    //地址管理
    @IBAction func addressManageClick() {
    }
    //授权证书
    @IBAction func autorCertificateClick() {
    }
    //在线客服
    @IBAction func onlineCustomerClcik() {
    }
    //400客服
    @IBAction func customer400Click() {
    }
    //网页版
    @IBAction func webPageClick() {
    }
    //更多设置
    @IBAction func moreSettingClick() {
    }
    //MAKR:--懒加载
    private lazy var backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 1/64.0)
        view.frame = CGRect(x: 0, y: 0, width: self.screenW, height: 44)
        return view
    }()
    private lazy var orderView = NBOrderListView.orderListView()
    private lazy var rightSignInBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ic_nav_signin"), forState: .Normal)
        btn.addTarget(self, action: Selector("signInClick"), forControlEvents: .TouchUpInside)
        btn.sizeToFit()
        return btn
    }()
}
