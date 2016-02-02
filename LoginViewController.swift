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
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
        loginButton.addTarget(self, action: Selector("loginBehavior"), forControlEvents: UIControlEvents.TouchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        let email = emailInput.text
        let password = passwordInput.text
        ref.authUser(email, password: password, withCompletionBlock: {error,authData in
            if error != nil {
                // Initialize
                let popUpAlert = UIAlertController(title: "\(email) does not exist!", message: "Do you want to register an account?", preferredStyle: UIAlertControllerStyle.Alert)
                // Alert Actions
                let registerAction = UIAlertAction(title: "Register", style: .Default, handler: {
                    (action:UIAlertAction) in
                        self.performSegueWithIdentifier("registerSegue", sender: self)
                    
                })
                let cancelAction = UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel,handler:nil)
                
                popUpAlert.addAction(registerAction)
                popUpAlert.addAction(cancelAction)
                self.presentViewController(popUpAlert, animated: true, completion: nil)
    
            } else {
                print("Successful")
            }
        })
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let registerViewController = segue.destinationViewController as! RegisterViewController
        registerViewController.email = self.emailInput!.text
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
