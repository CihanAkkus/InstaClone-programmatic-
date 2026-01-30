//
//  FeedCell.swift
//  firebaseInstaClone2
//
//  Created by Cihan Akkuş on 1.01.2026.
//

import UIKit

class FeedCell: UITableViewCell {

    let userEmailLabel = UILabel()
    let commentLabel = UILabel()
    let likeLabel = UILabel()
    let userImageView = UIImageView()
    let likeButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI( ){
        
        userEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        userEmailLabel.numberOfLines = 0
        userEmailLabel.text = "testMail"
        contentView.addSubview(userEmailLabel)
        
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.numberOfLines = 0//metin ne kadar uzunsa o kadar aşağıya in demek
        commentLabel.text = "Comment"
        contentView.addSubview(commentLabel)
        
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        likeLabel.text = "0"
        contentView.addSubview(likeLabel)
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        contentView.addSubview(userImageView)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setTitle("Like", for: UIControl.State.normal)
        likeButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        contentView.addSubview(likeButton)
        
        
    }
    
    private func setupConstraints( ){
        
        NSLayoutConstraint.activate([
            
            userEmailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userEmailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userEmailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            userImageView.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 8),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            userImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor),
            
            commentLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likeButton.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 16),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            likeLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 16),
            likeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            likeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
            
        ])
        
    }
    
    
    
    

}
