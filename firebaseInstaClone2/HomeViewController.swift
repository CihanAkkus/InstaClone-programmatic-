//
//  HomeViewController.swift
//  firebaseInstaClone2
//
//  Created by Cihan Akkuş on 23.12.2025.
//

import UIKit
import FirebaseFirestore


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userEmailArray = [String]( )
    var userCommentArray = [String]( )
    var likeArray = [Int]( )
    var userImageArray = [String]( )
    var documentIdArray = [String]( )
    
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.bounds
        
        tableView.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        view.addSubview(tableView)
        
        getDataFromFirestore()
        
        

    }
    
    
    func getDataFromFirestore(){
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").addSnapshotListener { snapshot, error in
            
            //addSnapshotListener bu hep dinliyor database'de bir değişiklik olduğunda closure bloğunu tekrar çalıştırır
            
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.userImageArray.removeAll(keepingCapacity: false)
                    
                    
                    
                    for document in snapshot!.documents{
                        
                        self.documentIdArray.append(document.documentID)
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                    
                        
                    }
                    self.tableView.reloadData()/*ViewDidLoad hemen çalışır ama internetten veriler hemen çekilmeyebilir listeler boş olabilir o yüzden burda bunu yazıyoruz tableView oluşturulurken daha veriler çekilmemiş olabilir ve array'ler boş olabilir*/
                }
            }
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        
        
        
        
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: UIControl.Event.touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonTapped(_ sender: UIButton  ){
        
        let tappedIndex = sender.tag
        
        let documentId = documentIdArray[tappedIndex]
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").document(documentId).updateData(["Likes" : FieldValue.increment(Int64(1))]){
            
            error in
            
            if let error = error {
                print(error.localizedDescription)
            }else{
                print("success")
            }
        }
        
        
    }
    
    
    func makeAlert(titleInput: String, messageInput: String ){
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okbutton)
        
        self.present(alert, animated: true, completion: nil)
    }
    


}
