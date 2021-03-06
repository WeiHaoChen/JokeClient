//
//  YRJokeTableViewController.swift
//  JokeClient
//
//  Created by 陈伟浩 on 16/1/11.
//  Copyright © 2016年 陈伟浩. All rights reserved.
//

import UIKit

enum YRJokeTableViewControllerType : Int {
    case HotJoke
    case NewestJoke
    case ImageTruth
}

class  YRJokeTableViewController:UIViewController,YRRefreshViewDelegate,UITableViewDelegate,UITableViewDataSource
{
    let identifier = "YRJokeCellIdentifier"
    var jokeType:YRJokeTableViewControllerType = .HotJoke
    var tableView:UITableView?
    var dataArray = NSMutableArray()
    var page :Int = 1
    var refreshView:YRRefreshView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        loadData()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "imageViewTapped", object:nil)
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
     NSNotificationCenter.defaultCenter().addObserver(self, selector: "imageViewTapped:", name: "imageViewTapped", object: nil)
    }
    
    func setupViews()
    {
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        self.tableView = UITableView(frame:CGRectMake(0,64,width,height-49-64))
        self.tableView?.delegate = self;
        self.tableView?.dataSource = self;
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        let nib = UINib(nibName:"YRJokeCell", bundle: nil)
        
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)
        var arr =  NSBundle.mainBundle().loadNibNamed("YRRefreshView" ,owner: self, options: nil) as Array
        self.refreshView = arr[0] as? YRRefreshView
        self.refreshView!.delegate = self
        
        self.tableView!.tableFooterView = self.refreshView
        self.view.addSubview(self.tableView!)
    }
    
    
    func loadData()
    {
        let url = urlString()
        self.refreshView!.startLoading()
        YRHttpRequest.requestWithURL(url,completionHandler:{ data in
            
            if data as! NSObject == NSNull()
            {
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            
            let arr = data["items"] as! NSArray
            //println(data)
            for data : AnyObject  in arr
            {
                self.dataArray.addObject(data)
            }
            self.tableView!.reloadData()
            self.refreshView!.stopLoading()
            self.page++
        })
    }
    
    
    func urlString()->String
    {
        if jokeType == .HotJoke //最热糗事
        {
            return "http://m2.qiushibaike.com/article/list/suggest?count=20&page=\(page)"
        }
        else if jokeType == .NewestJoke //最新糗事
        {
            return "http://m2.qiushibaike.com/article/list/latest?count=20&page=\(page)"
        }
        else//有图有真相
        {
            return "http://m2.qiushibaike.com/article/list/imgrank?count=20&page=\(page)"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataArray.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? YRJokeCell
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        cell!.data = data
        return cell!;
    }
    
    //    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
    //
    //        var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath!) as? YRJokeCell
    //        var index = indexPath!.row
    //        var data = self.dataArray[index] as NSDictionary
    //        cell!.data = data
    //        return cell!
    //    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        return  YRJokeCell.cellHeightByData(data)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        let commentsVC = YRCommentsViewController(nibName : nil, bundle: nil)
        commentsVC.jokeId = data.stringAttributeForKey("id")
        self.navigationController!.pushViewController(commentsVC, animated: true)
    }
    
    func refreshView(refreshView:YRRefreshView,didClickButton btn:UIButton)
    {
        loadData()
    }
    
    func imageViewTapped(noti:NSNotification)
    {
        
        let imageURL = noti.object as! String
        let imgVC = YRImageViewController(nibName: nil, bundle: nil)
        imgVC.imageURL = imageURL
        self.navigationController!.pushViewController(imgVC, animated: true)
        
        
    }
    
}

