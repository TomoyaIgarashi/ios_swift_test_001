//
//  FirstViewController.swift
//  NetworkingExample1
//
//  Created by TomoyaIgarashi on 8/13/15.
//  Copyright (c) 2015 Couger Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON
import Kingfisher

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    private var permanence = [String: (String, CGFloat)]()
    
    private let kCellIdentifier = "MyTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.registerNib(UINib(nibName: kCellIdentifier, bundle: nil), forCellReuseIdentifier: kCellIdentifier)
        self.tableView.rowHeight = UITableViewAutomaticDimension

        var params = [String: String]()
        let urls = MyLibs.instance.randomDummyImageURLs(1, limit: 5)
        for (i, e) in enumerate(urls) {
            params["image_url_\(i)"] = e
        }
        let get = "http://httpbin.org/get"
        Alamofire.request(.GET, get, parameters: params).responseSwiftyJSON({ (request, response, json, error) in
            response.map { (r: NSHTTPURLResponse) -> Void in
                MyLibs.instance.DebugLog("StatusCode: \(r.statusCode)")
                if let e = error {
                    MyLibs.instance.DebugLog(e)
                } else {
                    MyLibs.instance.DebugLog(json)
                    self.permanence = [String: (String, CGFloat)]()
                    for (key: String, subJson: JSON) in json["args"] {
                        let url = (subJson.string ?? "")
                        self.permanence[key] = (url, 0)
                    }
                    self.tableView.reloadData()
                }
            }
            ()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return permanence.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let imageURLKey = "image_url_\(indexPath.row)"
        let imageHeight = permanence[imageURLKey]!.1
        return imageHeight
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! MyTableViewCell
        
        let imageURLKey = "image_url_\(indexPath.row)"
        let imageURLValue = permanence[imageURLKey]!.0
        MyLibs.instance.DebugLog("\(imageURLKey): \(imageURLValue)")
        
        cell.imageView1!.kf_showIndicatorWhenLoading = true
        cell.imageView1!.kf_setImageWithURL(NSURL(string: imageURLValue)!,
            placeholderImage: nil,
            optionsInfo: nil,
            progressBlock: nil,
            completionHandler: { (image, error, cacheType, imageURL) -> () in
                if cacheType == CacheType.None {
                    self.tableView.reloadData()
                    cell.imageView1!.kf_showIndicatorWhenLoading = false
                }
                let size = image!.size
                self.permanence[imageURLKey]!.1 = size.height
            }
        )
        return cell
    }
}

