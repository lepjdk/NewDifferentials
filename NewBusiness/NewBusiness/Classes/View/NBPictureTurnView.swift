//
//  NBPictureTurnView.swift
//  NewBusiness
//
//  Created by lepjdk on 16/5/6.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBPictureTurnView: UIView {

    private var timer : NSTimer!
    private var timerFlag : Bool = true
    private let sectionNum = 20
    private let cellID = "pictureCell"
    var pictureArr = NSArray()
    var dataItem : NBProductListModel? {
        didSet{
            guard let data = dataItem?.bannelThumbImgs else
            {
                return
            }
            pictureArr = data
            pageView.numberOfPages = pictureArr.count <= 1 ? 0 : pictureArr.count
            pictureContentView.reloadData()
            //开启定时器
            startTimer()
        }
        
    }
    //MARK: -初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化操作
        setUpView()
        
        //注册cell
        pictureContentView.registerClass(NBPictureCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellID)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit
    {
        endTimer()
    }
    //MARK: -内部方法
    private func setUpView()
    {
        flowLayout.itemSize = self.frame.size
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.scrollDirection = .Horizontal
        pictureContentView.frame = self.bounds
        pageView.center = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.9)
        self.addSubview(pictureContentView)
        self.addSubview(pageView)
    }

    //定时器
    private func startTimer()
    {
        if pictureArr.count <= 1
        {
            return
        }
        endTimer()
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("changePicture"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    func endTimer()
    {
//        guard let time = timer else
//        {
//            return
//        }
        timer?.invalidate()
    }
    @objc private func changePicture()
    {
        let offsetX = pictureContentView.contentOffset.x
        var index = Int(offsetX / pictureContentView.bounds.size.width)
        index++
        let indexRow = index % pictureArr.count
        let indexSection = index / pictureArr.count
        if indexSection >= sectionNum
        {
            let indexPath = NSIndexPath(forItem: 0, inSection: Int(sectionNum / 2))
            pictureContentView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
        }
        else
        {
            let indexPath = NSIndexPath(forItem: indexRow, inSection: indexSection)
            pictureContentView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        }
        
    }
    
    //MARK: -懒加载
    private lazy var flowLayout : UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        return flow
    }()
    private lazy var pictureContentView : UICollectionView = {
        let view = UICollectionView(frame: CGRectZero, collectionViewLayout: self.flowLayout)
        view.backgroundColor = UIColor.whiteColor()
        view.pagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var pageView : UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 0
        page.currentPageIndicatorTintColor = UIColor.orangeColor()
        page.pageIndicatorTintColor = UIColor.whiteColor()
        return page
    }()
//    private lazy var timer : NSTimer = {
//        let time = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("changePicture"), userInfo: nil, repeats: true)
//        NSRunLoop.mainRunLoop().addTimer(time, forMode: NSRunLoopCommonModes)
//        return time
//    }()
}
//数据源
extension NBPictureTurnView : UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return pictureArr.count <= 1 ? 1 : sectionNum
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureArr.count == 0 ? 1 : pictureArr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
//        cell.backgroundColor = UIColor.whiteColor()
        let pictureCell = cell as! NBPictureCollectionViewCell
        pictureCell.dataStr = pictureArr[indexPath.item] as? String
        return pictureCell
    }
}
//代理
extension NBPictureTurnView : UICollectionViewDelegate
{
    //开始滚动
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        endTimer()
        timerFlag = false
    }
    //停止滚动
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        timerFlag = true
        weak var wkself = self
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            if wkself?.timerFlag == true {
                wkself?.startTimer()
            }
        }
    }
    //停止拖拽
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    //滚动就会触发
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x
        let index = Int(offsetX / pictureContentView.bounds.size.width)
        let indexRow = index % pictureArr.count
        let indexSection = index / pictureArr.count
        pageView.currentPage = indexRow
        if timerFlag == false
        {
            if indexSection >= sectionNum - 1 && indexRow >= pictureArr.count - 1
            {
                let indexPath = NSIndexPath(forItem: 0, inSection: Int(sectionNum / 2))
                weak var wkself = self
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                    wkself!.pictureContentView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
                }
            }
            else if indexSection <= 0 && indexRow <= 0
            {
                let indexPath = NSIndexPath(forItem: pictureArr.count - 1, inSection: Int(sectionNum / 2))
                weak var wkself = self
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                    wkself!.pictureContentView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: false)
                }
            }
        }
    }
}
