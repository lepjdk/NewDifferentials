//
//  NBShopLRView.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/11.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBShopLRView: UIView {

    private let leftCell = "shopLeft"
    private let rightCell = "shopRight"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 224 / 255.0, green: 224 / 255.0, blue: 224 / 255.0, alpha: 1)
        //加载子控件
        setUpChildView()
        //设置控件约束
        setUpChildLayout()
//        leftTableView.registerNib(NSBundle.mainBundle().loadNibNamed("NBShopLeftCell", owner: nil, options: nil), forCellReuseIdentifier:leftCell)
        leftTableView.registerNib(UINib.init(nibName: "NBShopLeftCell", bundle: nil), forCellReuseIdentifier: leftCell)
        rightTableView.registerNib(UINib.init(nibName: "NBShopRightCell", bundle: nil), forCellReuseIdentifier: rightCell)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MAKR:--内部控制方法
    private func setUpChildView()
    {
        self.addSubview(leftTableView)
        self.addSubview(rightTableView)
    }
    private func setUpChildLayout()
    {
        leftTableView.frame = CGRect(x: 0, y: 1, width: self.frame.size.width * 0.25, height: self.frame.size.height - 1)
        rightTableView.frame = CGRect(x: CGRectGetMaxX(leftTableView.frame), y: 1, width: self.frame.size.width * 0.75, height: self.frame.size.height - 1)
    }
    
    //MAKR:--懒加载
    //左边图
    private lazy var leftTableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self;
        tableView.separatorStyle = .None
        tableView.rowHeight = 65
        tableView.backgroundColor = UIColor(red: 241 / 255.0, green: 241 / 255.0, blue: 241 / 255.0, alpha: 1)
        return tableView
    }()
    //右边图
    private lazy var rightTableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self;
        tableView.separatorStyle = .None
        tableView.rowHeight = 90
        tableView.backgroundColor = UIColor(red: 234 / 255.0, green: 234 / 255.0, blue: 234 / 255.0, alpha: 1)
        return tableView
    }()

}

extension NBShopLRView : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView == self.leftTableView)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(leftCell, forIndexPath: indexPath)
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(rightCell, forIndexPath: indexPath)
            return cell
        }
    }
}
