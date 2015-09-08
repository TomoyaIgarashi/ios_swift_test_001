//
//  UIImageExtension.swift
//  NetworkingExample1
//
//  Created by TomoyaIgarashi on 8/18/15.
//  Copyright (c) 2015 Couger Inc. All rights reserved.
//

import UIKit

extension UIImage {
    static func imageRandomColorAndFixWidth(fixWidth: UInt32, randomHeight: UInt32) -> UIImage {
        let height = fixWidth + arc4random_uniform(randomHeight)
        let rect = CGRectMake(0.0, 0.0, CGFloat(fixWidth), CGFloat(height))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.randomRGB().CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        MyLibs.instance.DebugLog(image)
        return image
    }
}
