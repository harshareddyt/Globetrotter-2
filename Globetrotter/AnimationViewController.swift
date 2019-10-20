//
//  AnimationViewController.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 17/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var globemove: UIImageView!
    @IBOutlet weak var backgroundImg: UIImageView!
    var myTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") == true{
            let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! TabBar
            self.present( VC1, animated:false, completion:nil)
        }else{
            UIView.animate(withDuration: 10.0, animations: { () -> Void in
                // ROTATE ANIMATION
                let rotate = CGAffineTransform(rotationAngle: 360)
                //circle.transform = rotate
                // SCALE ANIMATION
                let scale = CGAffineTransform(scaleX: 2.0, y: 2.0)
                //circle.transform = scale
                // ROTATE AND SCALE ANIMATION
                self.globemove.transform = rotate.concatenating(scale)
                self.logoImg.alpha = 0.0
            },
                           completion: ({finished in
                            if (finished) {
                                UIView.animate(withDuration: 2.0, animations: {
                                    self.globemove.alpha = 0.0
                                })
                            }})
            )
            myTimer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector:  #selector(AnimationViewController.OfterDuration), userInfo: nil, repeats: false)
        }
    }
    @objc func OfterDuration(){
        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        self.present( VC1, animated:false, completion:nil)
    }
}
