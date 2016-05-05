//
//  NBLoginViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBLoginViewController: NBBaseViewController {

    /*
    private lazy var appDelegate : AppDelegate = {
        let delegate = AppDelegate()
        return delegate
    }()
    */
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    //密码
    @IBOutlet weak var pwdTF: UITextField!
    //手机号
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置代理
        scrollView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //添加点按手势
        let tap = UITapGestureRecognizer.init(target: self, action:Selector("tapclick"))
        self.contentView.addGestureRecognizer(tap)
        //设置按钮圆角
        loginBtn.layer.cornerRadius = 20.0
        loginBtn.layer.masksToBounds = true
        
        /*
        if !NBUserUtil.shareUser.isLogin() {
            return
        }

        toMainView()
        */
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    

    // MAKR: - 内部控制方法
    
    func tapclick()
    {
        self.pwdTF.resignFirstResponder()
        self.phoneNumberTF.resignFirstResponder()
    }
    /*
    func toMainView()
    {
        let tabbarVC = NBTabBarController()
        self.appDelegate.window?.rootViewController = tabbarVC
    }
    */
    //登录点击
    @IBAction func loginClick() {
        
        guard let phoneT = phoneNumberTF.text else
        {
            return
        }
        guard let pwdT = pwdTF.text else
        {
            return
        }
        NSLog("%d", (phoneT as NSString).length)
        if (phoneT as NSString).length <= 0 || (pwdT as NSString).length <= 0
        {
            NSLog("请输入手机号或者密码！")
        }
        else
        {
            let strPhoneN = phoneNumberTF.text
            let strPWD = pwdTF.text
            let strMD5 = NBStringUtil.MD5Encrypt(strPWD!)
            NSLog("%@", strMD5)
            let dictM = NSMutableDictionary()
            dictM["account"] = strPhoneN
            dictM["password"]  = strMD5
            dictM["version_code"] = "20160426"
            NBAFNManagerTool.shareInstance.loginSession(dictM) { (task, result, error) -> () in
                if error != nil {
                    NSLog("登录失败!")
                }
                else
                {
                    let resultData = result as! NSDictionary
                    NSLog("%@", resultData)
                    let code = resultData["code"]?.integerValue
                    if code == 0 {
                       let userData = resultData["data"] as! NSDictionary
                       let dataTask = task! as NSURLSessionDataTask
                       let reponseData = dataTask.response as! NSHTTPURLResponse
                        NBUserUtil.shareUser.feachSession(reponseData, value: userData)
                        
                    }
                    else
                    {
                        NSLog("%@", resultData["message"] as! NSString)
                    }
                }
            }
        }
        
    }
    //忘记密码
    @IBAction func forgetPwdClick() {
        NSLog("forgetPwdClick")
    }
    //使用帮助
    @IBAction func helpClick() {
        NSLog("helpClick")
    }

}

extension NBLoginViewController : UIScrollViewDelegate
{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.pwdTF.resignFirstResponder()
        self.phoneNumberTF.resignFirstResponder()
    }
}
