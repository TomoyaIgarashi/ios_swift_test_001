//
//  SecondViewController.swift
//  NetworkingExample1
//
//  Created by TomoyaIgarashi on 8/13/15.
//  Copyright (c) 2015 Couger Inc. All rights reserved.
//

import TwitterKit
import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let logInButton = TWTRLogInButton { (session, error) in
            // play with Twitter session
            if let session = session {
                MyLibs.instance.DebugLog(session.userName)
            }
        }
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

