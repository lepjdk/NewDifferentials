//
//  NBSearchViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/5/4.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBSearchViewController: NBBaseViewController {

    let screenW = UIScreen.mainScreen().bounds.size.width
    let screenH = UIScreen.mainScreen().bounds.size.height
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        //添加子控件
        setUpChildView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK ：－－内部方法
    private func setUpChildView()
    {
        //添加搜索视图
        self.view.addSubview(searchView)
        self.view.addSubview(searchContentView)
        
    }

    //MARK:--懒加载
    private lazy var searchView : NBSearchView = {
        
        let search = NBSearchView.init(frame: CGRect(x: 0, y: 64, width: self.screenW, height: 44))
        search.delegate = self
        search.hideBtn = true
        search.placeholderText = "请输入商品名称搜索"
        return search
    }()
    private lazy var searchContentView : UITableView = {
        let tableV = UITableView()
        tableV.frame = CGRect(x: 0, y: 108, width: self.screenW, height: self.screenH - 108)
        tableV.backgroundColor = UIColor.orangeColor()
        return tableV
    }()
    
    

}

extension NBSearchViewController : SearchViewDelegate
{
    func SearchButtonClicked(searchBar: UISearchBar) {
        
    }
}
