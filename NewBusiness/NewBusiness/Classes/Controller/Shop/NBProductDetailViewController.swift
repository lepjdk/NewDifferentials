//
//  NBProductDetailViewController.swift
//  NewBusiness
//
//  Created by lepjdk on 16/5/5.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

class NBProductDetailViewController: NBBaseViewController {
    //图片轮播view
    @IBOutlet weak var pictuerShowView: UIView!
    //产品详细名称
    @IBOutlet weak var productDetailName: UILabel!
    //VIP价格
    @IBOutlet weak var vipPriceLabel: UILabel!
    //库存
    @IBOutlet weak var stockLabel: UILabel!
    //市场价
    @IBOutlet weak var salePriceLabel: UILabel!
    //添加的商品数量
    @IBOutlet weak var addNumberLabel: UILabel!
    //品牌
    @IBOutlet weak var productMarkLabel: UILabel!
    //产品规格
    @IBOutlet weak var productRankLabel: UILabel!
    //下滑线
    @IBOutlet weak var lowLineView: UIView!
    //web View
    @IBOutlet weak var webProductView: UIWebView!
    //减号按钮
    @IBOutlet weak var delProductBtn: UIButton!
    //加号按钮
    @IBOutlet weak var addProductBtn: UIButton!
    //scrollview
    @IBOutlet weak var scrollProductView: UIScrollView!
    //内容view的高
    @IBOutlet weak var webViewConstrantH: NSLayoutConstraint!
    //购物车产品数量
    @IBOutlet weak var chatNumberLabel: UILabel!
    //总价格
    @IBOutlet weak var tottalPriceLabel: UILabel!
    
    var productData : NBProductListModel = NBProductListModel()

    //MARK: -生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "产品详情"
        
        //加载图片轮播界面
        setUpPictureView()
        
        webProductView.delegate = self
        webProductView.scrollView.scrollEnabled = false
        
        chatNumberLabel.layer.cornerRadius = 9
        chatNumberLabel.layer.masksToBounds = true
        
       NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeProductClick:"), name: "keyChangeProductNotify", object: nil)
        
        //更新详情界面
//        updateDetail()
        //加载数据
        loadProductDetail()
    }
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        pictureView.endTimer()
    }
    
    //MARK: -内部方法
    private func setUpPictureView()
    {
        pictuerShowView.addSubview(pictureView)
        pictureView.dataItem = productData
    }
    private func loadProductDetail()
    {
        weak var wkself = self
        let dictM = NSMutableDictionary()
        dictM["id"] = productData.id
        dictM["version_code"] = "20160426"
        NBAFNManagerTool.shareInstance.productDetail(dictM) { (task, result, error) -> () in
            if error == nil{
                let requestData = result as! NSDictionary
                NSLog("%@", requestData)
                let data = requestData["data"]
                let message = requestData["message"]
                let code = requestData["code"]?.integerValue
                if code == 0 {
                    wkself?.productData = NBModelTool.modelObjectWithKeyValues(NBProductListModel.classForCoder(), keyValues: data!) as! NBProductListModel
                    wkself?.updateDetail()
                }
                else
                {
                     NSLog("%@", message as! String)
                }
            }
        }
    }
    //更新详情数据
    private func updateDetail()
    {
        updateProductInfo()
        updateWebView()
    }
    private func updateProductInfo()
    {
        productDetailName.text = productData.name
        vipPriceLabel.text = NSString(format: "¥ %0.0lf", productData.price) as String
        let priceStr = NSString(format: "¥ %0.0lf", productData.marketPrice) as String

        let attributeStr = NSAttributedString(string: priceStr, attributes: [NSFontAttributeName : salePriceLabel.font, NSForegroundColorAttributeName : salePriceLabel.textColor, NSStrikethroughStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue | NSUnderlineStyle.PatternSolid.rawValue, NSStrikethroughColorAttributeName : salePriceLabel.textColor])
        salePriceLabel.attributedText = attributeStr
        
        stockLabel.text = NSString(format: "库存：%d", productData.stock) as String
        productMarkLabel.text = NSString(format: "品牌：%@", productData.brand!) as String
        productRankLabel.text = NSString(format: "商品规格：%d盒/箱", productData.boxNum) as String
        
        let num =  NBProductDataUtil.shareUtil.searchProduct(productData)
        updateBtnInfo(num)
        updateChatInfo()
        
    }
    private func updateChatInfo()
    {
        let allDataArr = NBProductDataUtil.shareUtil.getShopChatData()
        var number = 0
        var allPrice = 0.0
        if allDataArr.count > 0
        {
            let modelArr = NBModelTool.modelObjectArrayWithKeyValuesArray(NBChatSQLDataModel.classForCoder(), keyValuesArray: allDataArr)
            for var i = 0; i < modelArr.count; i++
            {
                let model = modelArr[i] as! NBChatSQLDataModel
                let price = model.price
                let num = model.amount
                number += num
                allPrice += Double(num) * price
            }
        }
        if number > 99
        {
            var rect = chatNumberLabel.frame
            rect.size.width = 25
            chatNumberLabel.frame = rect
            chatNumberLabel.text = "99+"
        }
        else
        {
            var rect = chatNumberLabel.frame
            rect.size.width = 18
            chatNumberLabel.frame = rect
            chatNumberLabel.text = NSString(format: "%d", number) as String
        }

        tottalPriceLabel.text = NSString(format: "¥ %0.0lf", allPrice) as String
    }
    private func updateWebView()
    {
        let htmlStr = NSString(format:"<!DOCTYPE html><html><head lang=\"en\"><meta charset=\"UTF-8\"><style>img{width: 100%%;}</style></head><body><div>%@</div></body></html>", productData.detail!) as String
        NSLog("%@", htmlStr)
        webProductView.loadHTMLString(htmlStr, baseURL: nil)
    }
    
    private func updateBtnInfo(number : Int)
    {
        if number <= 0
        {
            delProductBtn.hidden = true
            addNumberLabel.hidden = true
        }
        else
        {
            delProductBtn.hidden = false
            addNumberLabel.hidden = false
            
        }
        productData.addNumber = number
        addNumberLabel.text = NSString(format: "%d", number) as String
    }
    @objc private func changeProductClick(notify : NSNotification)
    {
        
        let info = notify.userInfo! as NSDictionary
        guard let number = info["number"]?.integerValue else
        {
            return
        }
        updateData(number)

//        let num =  NBProductDataUtil.shareUtil.searchAllProduct()
//        updateData(num)
    }
    //添加
    @IBAction func addProductClick(sender: UIButton) {
        productData.addNumber += 1
        //更新数据
        NBProductDataUtil.shareUtil.updateProductData(productData)
     NSNotificationCenter.defaultCenter().postNotificationName("keyChangeProductNotify", object: nil, userInfo: ["number" : productData.addNumber, "productId" : productData.id!])
    }
    //减少
    @IBAction func delProductClick(sender: UIButton) {
//        updateData(sender)
        productData.addNumber -= 1
        //更新数据
        NBProductDataUtil.shareUtil.updateProductData(productData)
     NSNotificationCenter.defaultCenter().postNotificationName("keyChangeProductNotify", object: nil, userInfo: ["number" : productData.addNumber, "productId" : productData.id!])
    }
    //去购物车
    @IBAction func tobuyChatClick(sender: AnyObject) {
        let chatShopVC = NBShopChatViewController()
        self.navigationController?.pushViewController(chatShopVC, animated: true)
    }

    //更新数据操作
    private func updateData(num: Int)
    {
        if num > 0
        {
            delProductBtn.hidden = false
            addNumberLabel.hidden = false
            if num >= productData.stock
            {
                addProductBtn.hidden = true
            }
            else
            {
                addProductBtn.hidden = false
            }
        }
        else
        {
            delProductBtn.hidden = true
            addNumberLabel.hidden = true
        }
        addNumberLabel.text = NSString(format: "%d", num) as String
        updateChatInfo()
        //更新数据
        productData.addNumber = num
    }

    //MARK: -懒加载
    private lazy var pictureView : NBPictureTurnView = NBPictureTurnView.init(frame: self.pictuerShowView.bounds)
}

extension NBProductDetailViewController : UIWebViewDelegate
{
    func webViewDidStartLoad(webView: UIWebView) {
        NSLog("1...%@", NSStringFromCGSize(webView.scrollView.contentSize))
    }
    func webViewDidFinishLoad(webView: UIWebView) {
//        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "WebKitCacheModelPreferenceKey")
        var rect = webView.frame
        rect.size.height = 1
        webView.frame = rect
        
        let sizeWeb = webView.sizeThatFits(CGSizeZero)
        let more = sizeWeb.height - webViewConstrantH.constant
        webViewConstrantH.constant = sizeWeb.height
        NSLog("%@", NSStringFromCGSize(sizeWeb))
        var size = scrollProductView.contentSize
        size.height += more
        scrollProductView.contentSize = size
        
    }
}
