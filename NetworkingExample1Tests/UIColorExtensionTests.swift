//
//  UIColorExtensionTests.swift
//  NetworkingExample1
//
//  Created by TomoyaIgarashi on 8/19/15.
//  Copyright (c) 2015 Couger Inc. All rights reserved.
//

import UIKit
import XCTest

class UIColorExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testToHexString() {
        let white = UIColor.whiteColor()
        XCTAssertEqual(white.toHexString(), "FFFFFF")
    }
    
    func testBlackOrWhiteByLuminance() {
        XCTAssertEqual(UIColor.whiteColor().blackOrWhiteByLuminance(), UIColor.blackColor())
        XCTAssertEqual(UIColor.blackColor().blackOrWhiteByLuminance(), UIColor.whiteColor())
    }

}
