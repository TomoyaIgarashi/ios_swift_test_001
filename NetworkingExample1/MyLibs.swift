//
//  MyLibs.swift
//  NetworkingExample1
//
//  Created by TomoyaIgarashi on 8/18/15.
//  Copyright (c) 2015 Couger Inc. All rights reserved.
//

import UIKit

final class MyLibs {
    private init() {}
    static let instance = MyLibs()

    func randomDummyImageURLs(currentPage: Int, limit: Int) -> [String] {
        let base = "http://dummyimage.com/"
        let xs = [String](count: limit, repeatedValue: "")
        return xs.map { (String) -> String in
            let bg = UIColor.randomRGB()
            let fg = bg.blackOrWhiteByLuminance()
            let x1 = 16
            let x2 = 10 + Int(arc4random_uniform(13))
            return base + "320x\(x1):\(x2)/\(bg.toHexString())/\(fg.toHexString())"
        }
    }
    
    func DebugLog(object: Any) -> Void {
        #if DEBUG
            Swift.println(object)
        #endif
    }
}

