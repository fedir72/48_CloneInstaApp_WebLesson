 //
//  Userprofileheader.swift
//  48_cloneInstaWEbLessonApp
//
//  Created by fedir on 20.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import UIKit

class Userprofileheader: UICollectionViewCell {
    
    var user : User? {
        didSet{
            let fullname = user?.name
            nameLabel.text = fullname
        }
    }
    
    //MARK: - properties
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Avtondill"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let atributedText = NSMutableAttributedString(string: "0\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        atributedText.append(NSAttributedString(string: "Посты", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = atributedText
        return label
    }()
    
    lazy var followerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let atributedText = NSMutableAttributedString(string: "0\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        atributedText.append(NSAttributedString(string: "Подписчики", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = atributedText
        return label
    }()
    
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let atributedText = NSMutableAttributedString(string: "0\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        atributedText.append(NSAttributedString(string: "Подписи", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = atributedText
        return label
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "thumbnails"), for: .normal)
        return button
    }()
    
     let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ingredients-list-1"), for: .normal)
        //button.imageView.
        button.tintColor = UIColor(white: 0, alpha: 0.2)
           return button
       }()
    
     let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "label__tag__bookmark__badge-512"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
      
           return button
       }()
    
    let editProfileButton: UIButton = {
        
        let buton = UIButton(type: .system)
        buton.setTitle("Редактировать профиль", for: .normal)
        buton.layer.cornerRadius = 5
        buton.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        buton.layer.borderWidth = 1
        buton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        buton.setTitleColor(.black, for: .normal)
        //buton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        return buton
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        configureUI()
    }
    //MARK: - конфигурирование элементов хедера на вью
    
    fileprivate func configureUI() {
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 12, bottom: 0, right: 0), size: .init(width: 80, height: 80))
        
         addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        
        configureUserStatistiss()
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postLabel.bottomAnchor, leading: postLabel.leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 12), size: .init(width: 0, height: 30))
        
        configureBottomToolBar()
    }
    
    fileprivate func configureUserStatistiss() {
        let stackView = UIStackView(arrangedSubviews: [postLabel,followerLabel,followingLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: topAnchor,leading: profileImageView.trailingAnchor, bottom: nil,trailing: trailingAnchor,padding: .init(top: 20, left: 12, bottom: 0, right: 12),size: .init(width: 0, height: 50))
    }
    
    fileprivate func configureBottomToolBar() {
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        
        let stack = UIStackView(arrangedSubviews: [gridButton,listButton,bookmarkButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        addSubview(stack)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))
        topDividerView.anchor(top: stack.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        bottomDividerView.anchor(top: stack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
