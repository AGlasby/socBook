//
//  ViewController.swift
//  socBook
//
//  Created by Alan Glasby on 16/07/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fbkBtnPressed(sender: AnyObject!) {
        let facebookLogin = FBSDKLoginManager()

        facebookLogin.logInWithReadPermissions(["email"], fromViewController: nil, handler: { (facebookResult: FBSDKLoginManagerLoginResult!, faceBookError: NSError!) -> Void in
            if faceBookError != nil {
                print("Facebook login failed. Error \(faceBookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with Facebook \(accessToken)")
            }
        })
    }

}

