//
//  FirstViewController.swift
//  NetworkingExample1
//
//  Created by TomoyaIgarashi on 8/13/15.
//  Copyright (c) 2015 Couger Inc. All rights reserved.
//

import UIKit
import Alamofire
import SSKeychain
import SwiftyJSON
import Kingfisher

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    private var permanence = [String: (String, CGFloat)]()
    
    private let kCellIdentifier = "MyTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let _ = SSKeychain.passwordForService("SwiftSample1", account: "DeviceToken")

        
        self.tableView.registerNib(UINib(nibName: kCellIdentifier, bundle: nil), forCellReuseIdentifier: kCellIdentifier)
        self.tableView.rowHeight = UITableViewAutomaticDimension

        struct Static {
            static var sizingCell: MyTableViewCell?
        }
        if Static.sizingCell == nil {
            Static.sizingCell = self.tableView.dequeueReusableCellWithIdentifier(self.kCellIdentifier) as? MyTableViewCell
        }
        let baseHeight = Static.sizingCell!.frame.height
        var params = [String: String]()
        let urls = MyLibs.instance.randomDummyImageURLs(1, limit: 5)
        for (i, e) in urls.enumerate() {
            params["image_url_\(i)"] = e
        }
        let get = "http://httpbin.org/get"
        Alamofire.request(.GET, get, parameters: params).responseJSON(completionHandler: { (request, response, result) -> Void in
            switch result {
            case .Success:
                let json = SwiftyJSON.JSON(result.value!)
                MyLibs.instance.DebugLog(json)
                self.permanence = [String: (String, CGFloat)]()
                for (key, subJson): (String, JSON) in json["args"] {
                    let url = (subJson.string ?? "")
                    self.permanence[key] = (url, baseHeight)
                }
                self.tableView.reloadData()
            case .Failure(_, let e):
                assertionFailure("HTTP Error: \(e)")
            }
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
                    cell.imageView1!.kf_showIndicatorWhenLoading = false
                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                }
                let size = image!.size
                self.permanence[imageURLKey]!.1 = size.height
            }
        )
        return cell
    }
}

