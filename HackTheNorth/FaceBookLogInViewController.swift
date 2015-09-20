//
//  FaceBookLogInViewController.swift
//  HackTheNorth
//
//  Created by Shuangshuang Zhao on 2015-09-20.
//  Copyright © 2015 Shuangshuang Zhao. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
class FaceBookLogInViewController: UIViewController,FBSDKLoginButtonDelegate {

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            let params = ["fields": "email, friends"]
            let fbRequest = FBSDKGraphRequest(graphPath:"me", parameters: params);
            fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
                if error == nil {
                    //print(result.valueForKey("fields"))
                    
                } else {
                    print("Error Getting Info \(error)");
                }
            }

            
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                
            }
        }
        performSegueWithIdentifier("MainSegue", sender: nil)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
