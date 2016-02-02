//
//  RegisterViewController.swift
//  FootPrints
//
//  Created by Patrick Gao on 2/02/2016.
//  Copyright © 2016 Patrick Gao. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var comfirmPasswordInput: UITextField!
    
    var email:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if email != nil {
            emailInput.text = email
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var Register: NSLayoutConstraint!
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    @IBAction func registerButton(sender: AnyObject) {
        if passwordInput.text == comfirmPasswordInput.text {
            ref.createUser(emailInput.text, password: passwordInput.text,
                withValueCompletionBlock: { error, result in
                    
                    if error != nil {
                        // There was an error creating the account
                    } else {
                        let uid = result["uid"] as? String
                        print("Successfully created user account with uid: \(uid)")
                    }
            })
        } else {
            let popAlert = UIAlertController(title: "Passwords are not same!", message: "Please re-enter the password", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            popAlert.addAction(cancelAction)
            self.presentViewController(popAlert, animated: true, completion: nil)
        }
    }
        
}
