//
//  MainTabBarController.swift
//  firebaseInstaClone2
//
//  Created by Cihan Akkuş on 23.12.2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setuptabs()
        

    }
    
    
    private func setuptabs( ){
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)//setting a property yapıyoruz
        
        
        let uploadVC = UploadViewController()
        uploadVC.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "plus.circle.fill"), tag: 1)
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        self.viewControllers = [homeVC, uploadVC , settingsVC]
        
        
    }
    

 

}
