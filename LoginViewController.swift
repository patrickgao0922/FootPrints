//
//  LoginViewController.swift
//  JournalApp
//
//  Created by Patrick Gao on 26/01/2016.
//  Copyright © 2016 Patrick Gao. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.addTarget(self, action: Selector("loginBehavior"), forControlEvents: UIControlEvents.TouchUpInside)

        // Do any additional setup after loading the view.
    }
    
    func loginBehavior(){
        self.performSegueWithIdentifier("loginSegue", sender:self)
    }
    

    
    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
