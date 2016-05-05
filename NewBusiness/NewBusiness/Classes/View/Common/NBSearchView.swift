//
//  NBSearchView.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/11.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol SearchViewDelegate : NSObjectProtocol {
    @objc optional func didClickSearchBtn()
    @objc optional func SearchButtonClicked(searchBar: UISearchBar)
}
class NBSearchView: UIView {

    var placeholderText : String? {
        didSet{
            searchBar.placeholder = placeholderText
        }
        
    }
    var hideBtn : Bool? {
        didSet{
            button.hidden = hideBtn!
        }
    }
    weak var delegate : SearchViewDelegate?
   
    //MARK :--生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        //初始化操作
        setUpView()
        
    }
    
    private func setUpView()
    {
        self.backgroundColor = UIColor.whiteColor()
        // 初始化子控件
        setUpChildView()
        // 布局子控件
        setUPLayoutChild(frame)
        
        button.addTarget(self, action: Selector("searchClick"), forControlEvents: .TouchUpInside)
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setUpView()
    }

//    required init?(coder aDecoder: NSCoder) {
////        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
//        
//    }
    //MARK:--内部方法
    private func setUpChildView()
    {
        self.addSubview(searchBar)
        self.addSubview(button)
    }
    private func setUPLayoutChild(frame: CGRect)
    {
        searchBar.frame = self.bounds
        button.frame = self.bounds
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.whiteColor().CGColor;
        self.layer.borderWidth = 8;
        
    }
    func searchClick()
    {
        NSLog("正在搜索中。。。")
        self.delegate?.didClickSearchBtn!()
    }
    
    //MARK:--懒加载
    private lazy var searchBar : UISearchBar = {
    
        let search = UISearchBar()
        search.delegate = self
        search.placeholder = "输入查询信息"
        search.searchBarStyle = .Minimal
        search.setImage(UIImage(named: "ic_search"), forSearchBarIcon: .Search, state: .Normal)
        return search
     
    }()
    private lazy var button : UIButton = UIButton()

}

extension NBSearchView : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.delegate?.SearchButtonClicked!(searchBar)
    }
}
