//
//  YRImageViewController.swift
//  JokeClient
//
//  Created by 陈伟浩 on 16/1/15.
//  Copyright © 2016年 陈伟浩. All rights reserved.
//

import UIKit

class YRImageViewController: UIViewController {
    
    var imageURL:String = ""
    var imageZoongView:YRImageZoomingView!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.title = "图片"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    func setupViews()
    {
        self.imageZoongView = YRImageZoomingView(frame:self.view.frame)
        self.imageZoongView.imageURL = self.imageURL
        self.view.addSubview(self.imageZoongView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}

