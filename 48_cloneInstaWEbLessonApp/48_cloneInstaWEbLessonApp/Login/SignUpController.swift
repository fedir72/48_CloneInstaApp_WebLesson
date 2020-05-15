//
//  SignUpController.swift
//  48_cloneInstaWEbLessonApp
//
//  Created by fedir on 15.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
    //MARK: - Properties
    
    fileprivate let plusFotoButton: UIButton = {
        let buton = UIButton(type: .system)
        buton.setImage(#imageLiteral(resourceName: "plusred") .withRenderingMode(.alwaysOriginal), for: .normal)
        buton.layer.cornerRadius = buton.frame.width/3
        return buton
        }()
    
     private let userNameTextField: UITextField = {
           let tf = UITextField()
           tf.placeholder = "Name ..."
           tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
           tf.borderStyle = .roundedRect
           tf.font = UIFont.systemFont(ofSize: 18)
           return tf
       }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email ..."
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 18)
        return tf
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full Name ..."
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 18)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter p asword ..."
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 18)
        return tf
    }()
    
     private let sighnUpButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Sign Up", for: .normal)
           button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
           button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
           button.layer.cornerRadius = 6
           return button
       }()
    
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        //первая часть кнопки c разным цвето текста
        var attributetitle = NSMutableAttributedString(string: "Already have an account ?", attributes: [.font: UIFont.systemFont(ofSize: 18),.foregroundColor: UIColor.lightGray])
        //вторая часть
        attributetitle.append(NSAttributedString(string: "Sign UP", attributes: [.font: UIFont.systemFont(ofSize: 18 , weight: .heavy), .foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(attributetitle, for: .normal)
        button.addTarget(self, action: #selector(goToSignInController), for: .touchUpInside)
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureViewComponents()
    }
    
    @objc fileprivate func goToSignInController() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - configure components
    
    func configureViewComponents() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(plusFotoButton)
        plusFotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom:0, right: 40))
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField,fullNameTextField,userNameTextField
                                                       ,passwordTextField,sighnUpButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top:  plusFotoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 280))
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 40, right: 40))
    }
}
