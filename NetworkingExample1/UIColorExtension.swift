//
//  UIColorExtension.swift
//  NetworkingExample1
//
//  Created by TomoyaIgarashi on 8/18/15.
//  Copyright (c) 2015 Couger Inc. All rights reserved.
//

import UIKit

extension UIColor {
    static func randomRGB() -> UIColor {
        let r = CGFloat(arc4random_uniform(256)) / 255.0
        let g = CGFloat(arc4random_uniform(256)) / 255.0
        let b = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    func blackOrWhiteByLuminance() -> UIColor {
        if (self.luminance() > 0.4) {
            return UIColor.blackColor()
        } else {
            return UIColor.whiteColor()
        }
    }
    
    func luminance() -> Double {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (0.299 * Double(r)) + (0.587 * Double(g)) + (0.114 * Double(b))
    }
    
    func toHexString() -> String {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        r *= 255.0
        g *= 255.0
        b *= 255.0
        return String(format:"%02X", Int(r)) + String(format:"%02X", Int(g)) + String(format:"%02X", Int(b))
    }
}
