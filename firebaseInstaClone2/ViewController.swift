//
//  ViewController.swift
//  firebaseInstaClone2
//
//  Created by Cihan Akkuş on 23.12.2025.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    let appNameLabel = UILabel()
    let emailText = UITextField()
    let passwordText = UITextField()
    
    let signInButton = UIButton()
    let signUpButton = UIButton()
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupConstraints()
      
        
    }
    
    
    
    
    func setupUI( ){
        
        appNameLabel.numberOfLines = 0
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.text = "Instagram Clone"
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        appNameLabel.textAlignment = .center
        view.addSubview(appNameLabel)
        
        emailText.translatesAutoresizingMaskIntoConstraints = false
        emailText.placeholder = "email:"
        emailText.layer.cornerRadius = 8
        emailText.layer.borderWidth = 2
        emailText.clipsToBounds = true
        emailText.layer.sublayerTransform = CATransform3DMakeTranslation(12,0,0)
        view.addSubview(emailText)
        
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.placeholder = "password:"
        passwordText.layer.cornerRadius = 8
        passwordText.layer.borderWidth = 2
        passwordText.clipsToBounds = true
        passwordText.layer.sublayerTransform = CATransform3DMakeTranslation(12,0,0)
        view.addSubview(passwordText)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: UIControl.State.normal)
        signInButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        view.addSubview(signInButton)
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: UIControl.Event.touchUpInside)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up", for: UIControl.State.normal)
        signUpButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        view.addSubview(signUpButton)
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: UIControl.Event.touchUpInside)
        
        
    }
    
    @objc func signInButtonTapped( ){
        
        if (emailText.text != "" && passwordText.text != ""){
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    let mainTabBar = MainTabBarController()
                    
                    if let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let delegate = windowsScene.delegate as? SceneDelegate,
                       let window = delegate.window{
                        
                        UIView.transition(with: window, duration: 0.5,options: .transitionCrossDissolve) {
                            window.rootViewController = mainTabBar
                        }
                    }
                    
                }
            }
            
        }else{
            
            makeAlert(titleInput: "Error", messageInput: "Username/Password?")
        }
        
        
    }
    
    
    
    @objc func signUpButtonTapped( ){
        
        if (emailText.text != "" && passwordText.text != ""){
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    let mainTabBar = MainTabBarController()
                    
                    if let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let delegate = windowsScene.delegate as? SceneDelegate,
                       let window = delegate.window{
                        
                        
                        UIView.transition(with: window, duration: 0.5,options: .transitionCrossDissolve) {
                            window.rootViewController = mainTabBar
                        }
                        
                    }
                    
                }
                
            }
            
        }else{
            
            makeAlert(titleInput: "Error", messageInput: "Username/Password?")
        }
        
        
    }
    
    
    
    
    
    func setupConstraints( ){
        
        NSLayoutConstraint.activate([
            
            
            appNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            emailText.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 200),
            emailText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailText.heightAnchor.constraint(equalToConstant: 48),
            
            passwordText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 20),
            passwordText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordText.heightAnchor.constraint(equalToConstant: 48),
            
            signInButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 25),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 25),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            
        ])
        
    }
    
    
    func makeAlert(titleInput: String, messageInput: String ){
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    


}

