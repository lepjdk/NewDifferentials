//
//  NBSearchView.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/11.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

protocol SearchViewDelegate : class {
    func didClickSearchBtn()
}
class NBSearchView: UIView {

    var placeholderText : String? {
        didSet{
            searchBar.placeholder = placeholderText
        }
        
    }
    
    weak var delegate : SearchViewDelegate?
   
    //MAKR :--生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        // 初始化子控件
        setUpChildView()
        // 布局子控件
        setUPLayoutChild(frame)
        
        button.addTarget(self, action: Selector("searchClick"), forControlEvents: .TouchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MAKR:--内部方法
    private func setUpChildView()
    {
        self.addSubview(searchBar)
        self.addSubview(button)
    }
    private func setUPLayoutChild(frame: CGRect)
    {
        searchBar.frame = self.bounds
        button.frame = self.bounds
        
    }
    func searchClick()
    {
        NSLog("正在搜索中。。。")
        self.delegate?.didClickSearchBtn()
    }
    
    //MAKR:--懒加载
    private lazy var searchBar : UISearchBar = {
    
        let search = UISearchBar()
        search.placeholder = "输入查询信息"
        search.searchBarStyle = .Minimal
        search.setImage(UIImage(named: "ic_search"), forSearchBarIcon: .Search, state: .Normal)
        return search
     
    }()
    private lazy var button : UIButton = UIButton()

}
