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
import Firebase


class ViewController: UIViewController {

    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }

    @IBAction func fbkBtnPressed(sender: AnyObject!) {
        let facebookLogin = FBSDKLoginManager()

        facebookLogin.logInWithReadPermissions(["email"], fromViewController: nil, handler: { (facebookResult: FBSDKLoginManagerLoginResult!, faceBookError: NSError!) -> Void in
            if faceBookError != nil {
                print("Facebook login failed. Error \(faceBookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with Facebook \(accessToken)")

                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                FIRAuth.auth()?.signInWithCredential(credential, completion: { (user, error) in
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        print("Logged in. \(user)")
                        let userData = ["Provider": credential.provider]
                        DataService.ds.createFirebaseUser(user!.uid, user: userData)
                        NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                })
            }
        })
    }

    @IBAction func loginPressed(sender: UIButton!) {

        if let email = emailTxtFld.text where email != "", let pwd = passwordTxtFld.text where pwd != "" {

            FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: { (user, error) in

                if error != nil {

                    print(error)

                    if error!.code == STATUS_ACCOUNT_NONEXIST {

                        FIRAuth.auth()?.createUserWithEmail(email, password: pwd, completion: { (user, error) in
                            if error != nil {

                                self.showErrorAlert("Could not create account", msg: "Problem creating accont. Try something else")

                            } else {

                                NSUserDefaults.standardUserDefaults().setValue(user!.uid, forKey: KEY_UID)
                                let userData = ["provider": "email"]
                                DataService.ds.createFirebaseUser(user!.uid, user: userData)
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                        })

                    } else {

                        self.showErrorAlert("Could not log in", msg: "Please check your username and password")
                    }
                }
            })
        } else {
            self.showErrorAlert("Email and password required", msg: "You must enter a valid email and password")
        }
    }


    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "ok" , style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)

    }

}

