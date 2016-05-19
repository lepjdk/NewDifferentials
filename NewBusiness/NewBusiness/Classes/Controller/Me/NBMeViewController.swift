//
//  NBMeViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBMeViewController: NBBaseViewController {

    //MARK:--属性参数
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
    
    var userInfo : NBUserModel?
        {
        didSet
        {
            NBWebImageTool.shareTool.setImageViewWithImage(avatarIcon, urlStr: userInfo?.head, placeholderImage: "img_default_avatar")
            userNameLabel.text = userInfo?.nickName
            phoneNumberLabel.text = userInfo?.phone
            differStandLabel.text = updateDifferStandText()
            standingLabel.text = NSString(format: "%d", userInfo?.credit == nil ? "" : userInfo!.credit) as String
            dealerRankLabel.text = NSString(format: "%d", (userInfo?.rank)!) as String
            sealerInfoBtn.setTitle(userInfo?.levelName, forState: .Normal)
            sealerInfoBtn.setImage(updateLevelIcon(), forState: .Normal)
            orderView.updateView((userInfo?.orderStat)!, isSeller: false)
        }
    }
    
    //MARK:--生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化控件
        setUpView()
        //获取用户数据
        userInfo = NBUserUtil.shareUser.getUserModelInfo()
       
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
    
    //MARK:--内部控制方法
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
    private func updateLevelIcon() -> UIImage?
    {
        /*
        #define KWMLevelId_PartnerCore                        @"4e3e2973-26ce-47cf-9854-aef62df4f3cb"     //核心合伙人
        #define KWMLevelId_Partner                            @"e8b067ee-eaed-44dd-a934-008316e37a2b"     //合伙人
        #define KWMLevelId_OperationalDepartment              @"43e54225-9c94-4086-8120-f01b6d684ee4"     //运营部
        #define KWMLevelId_SoleDistributorGeneral             @"0d04070b-f8da-4168-952b-e54eee6880ab"     //总经销商
        #define KWMLevelId_SoleDistributorCore                @"06249f0e-d645-4330-b7f8-95225fe7bc48"     //核心经销商
        #define KWMLevelId_SoleDistributorSpecial             @"07438e7e-ac33-45f5-b1ec-03ac3be1c4d9"     //特约经销商
        #define KWMLevelId_SoleDistributorAuthorization       @"b742aada-44a5-49a0-a053-e84520bb0835"     //授权经销商
        */
        let iconDict = ["4e3e2973-26ce-47cf-9854-aef62df4f3cb" : "ic_corepartner", "e8b067ee-eaed-44dd-a934-008316e37a2b" : "ic_partner", "43e54225-9c94-4086-8120-f01b6d684ee4" : "ic_operation", "0d04070b-f8da-4168-952b-e54eee6880ab" : "ic_alldealer", "06249f0e-d645-4330-b7f8-95225fe7bc48" : "ic_coredealers", "07438e7e-ac33-45f5-b1ec-03ac3be1c4d9" : "ic_dealer", "b742aada-44a5-49a0-a053-e84520bb0835" : "ic_authorized"] as NSDictionary
        guard let levelStr = userInfo?.levelId else
        {
            return nil
        }
        guard let imageStr = iconDict.valueForKey(levelStr) else
        {
            return nil
        }
        guard let image = UIImage(named: imageStr as! String) else
        {
            return nil
        }
        return image
    }
    private func updateDifferStandText() -> String
    {
        var text = "积分数据出错,请重新登录"
        let creditBalance = (userInfo?.nextCredit)! - (userInfo?.credit)!
        if creditBalance <= 0
        {
            text = NSString(format: "已达到%@的积分", (userInfo?.nextLevelName)!) as String
            return text
        }
        text = NSString(format: "距离升级到%@还差%lld个积分", (userInfo?.nextLevelName)!, creditBalance) as String
        return text
    }
    @objc private func signInClick()
    {
        NSLog("签到")
        NSLog("hello")
    }
    //MARK:--事件处理方法
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
    //MARK:--懒加载
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
