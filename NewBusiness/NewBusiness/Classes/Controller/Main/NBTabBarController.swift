//
//  NBTabBarController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //添加子控制器
        setUpAddChildViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - 内部控制方法
    private func setUpAddChildViewController()
    {
        addChildVC(shopVC, tittleName: "商城", imageName: "ic_tab_shop")
        addChildVC(saleVC, tittleName: "销售", imageName: "ic_tab_sale")
        addChildVC(messageVC, tittleName: "消息", imageName :"ic_tab_message")
        addChildVC(sellVC, tittleName: "经销商", imageName:"ic_tab_partner")
        addChildVC(meVc, tittleName: "我",  imageName: "ic_tab_psn")
    }
    private func addChildVC(viewController : UIViewController, tittleName : String?, imageName : String?){
        let nav = UINavigationController.init(rootViewController: viewController)
        
        viewController.title = tittleName
        if let image = imageName where image != ""
        {
            viewController.tabBarItem.image = UIImage(named: image)
            viewController.tabBarItem.selectedImage = UIImage(named: image + "_hover")
        }
         self.addChildViewController(nav)
    }
    
    
    // MARK: - 懒加载方法
    private lazy var meVc : NBMeViewController = NBMeViewController()
    private lazy var shopVC : NBShopViewController = NBShopViewController()
    private lazy var sellVC : NBSellerViewController = NBSellerViewController()
    private lazy var saleVC : NBSaleViewController = NBSaleViewController()
    private lazy var messageVC : NBMessageViewController = NBMessageViewController()


}
