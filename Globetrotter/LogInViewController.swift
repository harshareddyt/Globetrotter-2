//
//  LogInViewController.swift
//  
//
//  Created by Sunny Reddy on 17/04/19.
import UIKit
import GoogleSignIn

class LogInViewController: UIViewController,GIDSignInUIDelegate {
    
    
    @IBOutlet weak var ButtonView: UIView!
    
    @IBOutlet var googleButton: UIButton!
    @IBOutlet weak var globetroterImg: UIImageView!
    @IBAction func googleButton(_ sender: UIButton) {
    }
    @IBOutlet weak var backgroundImg: UIImageView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            ButtonView.layer.cornerRadius = 25
//            googleButton.layer.cornerRadius = 10.0
            
            var error : NSError?
            if error != nil{
                print(error)
                return
            }
    }

    @IBAction func googlePlusButtonTouchUpInside(sender: GIDSignInButton) {
         GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
}
//    @IBAction func googleButton(sender: GIDSignInButton) {
//
//    }
//
//
    
                
    
//
        

