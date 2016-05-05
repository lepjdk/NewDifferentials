//
//  NBUserUtil.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/22.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBUserUtil: NSObject {
    private let keyUserInfo  = "keyUserInfo"
    private let keySessionId  = "keySessionId"
    private let sessId = "__auth"
    private let apiHost = "sibuwesaleapi.orangebusiness.com.cn"
    private var sessionId : String?
    //单例
    static let shareUser : NBUserUtil = {
        let user = NBUserUtil()
        return user
    }()
    
    //登录保存用户信息到偏好设置中
    func saveUserInfo(value : AnyObject?)
    {
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: keyUserInfo)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    func saveSession(session : String?)
    {
        sessionId = session
        NSUserDefaults.standardUserDefaults().setValue(session, forKey: keySessionId)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    func setLoginInfo(value : AnyObject?, session : String?)
    {
        saveUserInfo(value)
        saveSession(session)
    }
    //退出登录
    func setLogoutInfo()
    {
        sessionId = nil
        NSUserDefaults.standardUserDefaults().removeObjectForKey(keyUserInfo)
        NSUserDefaults.standardUserDefaults().removeObjectForKey(keySessionId)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    //获取用户信息
    func getUserInfo() -> AnyObject?
    {
        let value = NSUserDefaults.standardUserDefaults().valueForKey(keyUserInfo)
        return value
    }
    //判断用户是否已经登录
    func isLogin() -> Bool
    {
        return getUserInfo() != nil &&  checkSession() ? true : false
    }
    //设置session
    func feachSession(httpRespodse : NSHTTPURLResponse, value : AnyObject?)
    {
        let cookiestorge = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        let cookies = cookiestorge.cookies
        for cookie in cookies! {
            if sessId == cookie.name
            {
                let cookicValue = cookie.value
//                saveSession(cookicValue)
                setLoginInfo(value, session: cookicValue)
                break
            }
        }
    }
    //检查session
    func checkSession() -> Bool
    {
        if sessionId == nil
        {
            let value = NSUserDefaults.standardUserDefaults().valueForKey(keySessionId)
            sessionId = value as? String
        }
        updateSession(sessionId)
        return sessionId != nil ? true : false
    }
    //更新session
    func updateSession(session : String?)
    {
        if session == nil {
            return
        }
        var isExists : Bool = true
        let cookiestorge = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        var cookies = cookiestorge.cookies
        for cookie in cookies! {
            if sessId == cookie.name
            {
                let value = cookie.value
                if session == value {
                    isExists = true
                }
                else
                {
                    isExists = false
                }
                break
            }
        }
        if !isExists {
            cookies?.removeAll()

            let newCookie = NSHTTPCookie(properties: [NSHTTPCookieName : sessId , NSHTTPCookieValue : session!, NSHTTPCookieDomain : apiHost, NSHTTPCookiePath : "/"])
            cookiestorge.setCookie(newCookie!)
            
        }
    }

}
