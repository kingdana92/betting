//
//  LoginViewController.swift
//  Betting
//
//  Created by Myantel on 5/27/15.
//  Copyright (c) 2015 Myantel. All rights reserved.
//

import UIKit
import Parse
import Foundation
import SystemConfiguration


class LoginViewController: UIViewController {


    //Login
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginWithFacebook: UIButton!
    
    //Sign Up
    @IBOutlet weak var usernameSignup: UITextField!
    @IBOutlet weak var passwordSignup: UITextField!
    
    
    @IBAction func login(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(usernameText.text, password:passwordText.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.performSegueWithIdentifier("primary", sender: self)
                println("login")
            } else {
                println("wrong")
            }
        }
        
    }
    @IBAction func facebookLogin(sender: AnyObject) {
        self.performSegueWithIdentifier("primary", sender: self)
    }
    
    @IBAction func signUp(sender: AnyObject) {
        var user = PFUser()
        user.username = usernameSignup.text
        user.password = passwordSignup.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                println(error)
            } else {
                println("Hooray! Let them use the app now.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
