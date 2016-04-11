//
//  NBLoginViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBLoginViewController: NBBaseViewController {

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
    }
    

    // MAKR: - 内部控制方法
    
    func tapclick()
    {
        self.pwdTF.resignFirstResponder()
        self.phoneNumberTF.resignFirstResponder()
    }
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
            if phoneNumberTF.text == "13145803218" && pwdTF.text == "123456"
            {
                NSUserDefaults.standardUserDefaults().setObject(phoneNumberTF.text, forKey: "userPhone")
                NSUserDefaults.standardUserDefaults().setObject(pwdTF.text, forKey: "userPWD")
                NSUserDefaults.standardUserDefaults().setObject("lepjdk", forKey: "userName")
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isLogin")
                NSLog("登录成功")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NBLoginViewController : UIScrollViewDelegate
{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.pwdTF.resignFirstResponder()
        self.phoneNumberTF.resignFirstResponder()
    }
}
