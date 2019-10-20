//
//  TabBar.swift
//  Globe Trotter
//
//  Created by Sunny Reddy on 16/04/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {

    var tabBarIteem = UITabBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedImage = UIImage(named: "home (1)")?.withRenderingMode(.alwaysOriginal)
        let deselctedImage = UIImage(named: "home (2)")?.withRenderingMode(.alwaysOriginal)
        tabBarIteem = self.tabBar.items![0]
        tabBarIteem.image = deselctedImage
        tabBarIteem.selectedImage = selectedImage
        let selectedImage1 = UIImage(named: "add")?.withRenderingMode(.alwaysOriginal)
        let deselctedImage1 = UIImage(named: "add (1)")?.withRenderingMode(.alwaysOriginal)
        tabBarIteem = self.tabBar.items![2]
        tabBarIteem.image = deselctedImage1
        tabBarIteem.selectedImage = selectedImage1
        let selectedImage2 = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        let deselctedImage2 = UIImage(named: "profile (1)")?.withRenderingMode(.alwaysOriginal)
        tabBarIteem = self.tabBar.items![3]
        tabBarIteem.image = deselctedImage2
        tabBarIteem.selectedImage = selectedImage2
        let selectedImage3 = UIImage(named: "magnifier 2")?.withRenderingMode(.alwaysOriginal)
        let deselctedImage3 = UIImage(named: "magnifier (1) 2")?.withRenderingMode(.alwaysOriginal)
        tabBarIteem = self.tabBar.items![1]
         tabBarIteem.image = deselctedImage3
        tabBarIteem.selectedImage = selectedImage3
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for:.selected)
        
        self.selectedIndex = 0
    }
}
