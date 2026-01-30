//
//  SettingsViewController.swift
//  firebaseInstaClone2
//
//  Created by Cihan Akkuş on 23.12.2025.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    let logoutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        

    }
    
    
    func setupUI( ){
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("logout", for: UIControl.State.normal)
        logoutButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        view.addSubview(logoutButton)
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: UIControl.Event.touchUpInside)
        
        
    }
    
    
    func setupConstraints( ){
        
        NSLayoutConstraint.activate([
            
            
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            
        ])
        
    }
    
    
    @objc func logoutButtonTapped( ){
        
        do{
            try Auth.auth().signOut()
            
            let loginVC = ViewController()
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let delegate = windowScene.delegate as? SceneDelegate,
               let window = delegate.window{
                
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
                    window.rootViewController = loginVC
                }
                
            }
            
        }catch{
            print("Error")
        }
        

        
    }
    
    
    
    

}
