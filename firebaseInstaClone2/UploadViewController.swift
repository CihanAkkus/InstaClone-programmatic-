//
//  UploadViewController.swift
//  firebaseInstaClone2
//
//  Created by Cihan Akkuş on 30.12.2025.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth

class UploadViewController: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    let postImageView = UIImageView( )
    let commentTextView = UITextView()
    let placeHolderLabel = UILabel()
    let uploadButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()

    }
    
    private func setupUI( ){
        
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.image = UIImage(named: "selectimage")
        view.addSubview(postImageView)
        
        postImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        postImageView.addGestureRecognizer(gestureRecognizer)
        
        
        commentTextView.delegate = self
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.isScrollEnabled = true
        commentTextView.textContainer.lineBreakMode = .byWordWrapping
        commentTextView.font = UIFont.systemFont(ofSize: 16)
        commentTextView.layer.cornerRadius = 8
        commentTextView.layer.borderWidth = 2
        commentTextView.clipsToBounds = true
        view.addSubview(commentTextView)
        
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeHolderLabel.text = "Write a caption..."
        placeHolderLabel.numberOfLines = 1
        placeHolderLabel.textColor = UIColor.lightGray
        commentTextView.addSubview(placeHolderLabel)
        
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.setTitle("Upload", for: UIControl.State.normal)
        uploadButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        view.addSubview(uploadButton)
        
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: UIControl.Event.touchUpInside)
        
    }
    
    private func setupConstraints( ){
        
        NSLayoutConstraint.activate([
            
            postImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            postImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            postImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: 1),
            
            commentTextView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 20),
            commentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            commentTextView.heightAnchor.constraint(equalTo: commentTextView.widthAnchor, multiplier: 0.5),
            
            placeHolderLabel.topAnchor.constraint(equalTo: commentTextView.topAnchor, constant: 8),
            placeHolderLabel.leadingAnchor.constraint(equalTo: commentTextView.leadingAnchor, constant: 5),
            placeHolderLabel.trailingAnchor.constraint(equalTo: commentTextView.trailingAnchor, constant: -5),
            
            uploadButton.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 30),
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            
            
        ])
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !textView.text.isEmpty
    }
    
    
    
    @objc func uploadButtonTapped( ){
        
        let storage = Storage.storage()//Singleton instance yaratımı
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")//klasör oluşturma işlemi
        
        if let data = postImageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")//dosya isimleri farklı olmalı o yüzden uuıd kullandık
            
            imageReference.putData(data, metadata: nil) { metadata, error in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            
                            //stringe çeviriyoruz çünkü firebase veya internet ilkel veri tiplerini kabul ediyor
                            if let imageUrl = url?.absoluteString{
                                
                                let firestoreDatabase = Firestore.firestore()
                                
                                let firestorePost = ["imageUrl": imageUrl, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.commentTextView.text!,"date": FieldValue.serverTimestamp(), "likes": 0] as [String: Any]
                                
                                
                            
                                
                                let firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost) { error in
                                    
                                    
                                    if error != nil {
                                        self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                    }else{
                                                                                
                                        
                                        self.resetUI()
                                        
                                        self.tabBarController?.selectedIndex = 0

                                        
                                    }
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                        }
                    }
                }
                
                
            }
        }
        
    }
    
    func resetUI( ){
        
        self.commentTextView.text = ""
        self.postImageView.image = UIImage(named: "selectimage")
        view.endEditing(true)
        
        self.placeHolderLabel.isHidden = false
    }
    
    
    
    @objc func selectImage( ){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        postImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    func makeAlert(titleInput: String, messageInput: String ){
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okbutton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    



}
