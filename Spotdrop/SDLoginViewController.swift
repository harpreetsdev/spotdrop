//
//  SDLoginViewController.swift
//  Spotdrop
//
//  Created by Erik Koebke on 4/14/16.
//  Copyright © 2016 Erik Koebke. All rights reserved.
//

import Foundation
import UIKit

class SDLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if FBSDKAccessToken.currentAccessToken() == nil {
            let loginBtn = FBSDKLoginButton()
            loginBtn.delegate = self
            loginBtn.center = self.view.center
            loginBtn.readPermissions = ["public_profile", "email", "user_friends"]
            self.view.addSubview(loginBtn)
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        if FBSDKAccessToken.currentAccessToken() != nil {
            self.performSegueWithIdentifier("identifiedUser", sender: nil)
        }
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error != nil {
            
        } else if result.isCancelled {
            
        } else {
            if FBSDKAccessToken.currentAccessToken() != nil {
                self.performSegueWithIdentifier("identifiedUser", sender: nil)
            } else {
                self.performSegueWithIdentifier("unidentifiedUser", sender: nil)
            }
        }
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // nothing - logout not implemented yet
    }
    
    
}
