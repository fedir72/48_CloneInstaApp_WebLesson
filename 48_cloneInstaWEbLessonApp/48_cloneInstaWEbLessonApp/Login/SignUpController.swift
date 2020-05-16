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
    
    fileprivate let selectPhotoButton: UIButton = {
        let buton = UIButton(type: .system)
        buton.setTitle("Select Photo", for: .normal)
        buton.setTitleColor(.black, for: .normal)
        buton.backgroundColor = .white
        buton.layer.cornerRadius = buton.frame.width/2
        buton.layer.borderWidth = 3
        buton.layer.borderColor = UIColor.rgb(red: 149, green: 204, blue: 244).cgColor
        return buton
        }()
    
    private let userNameTextField = UITextField.setupTextField(plaseholder: "Name...", secureTextEnry: false)
    private let emailTextField = UITextField.setupTextField(plaseholder: "Email...", secureTextEnry: false)
    private let fullNameTextField = UITextField.setupTextField(plaseholder: "Full name...", secureTextEnry: false)
    private let passwordTextField = UITextField.setupTextField(plaseholder: "Password...", secureTextEnry: false)
    
    private let sighnUpButton = UIButton.setupButton(title: "Sign Up", color: UIColor.rgb(red: 149, green: 204, blue: 244))
    
        
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
        setupNotificationObserver()
        setupTapGesture()
    }
    //MARK: stackview
     lazy var stackView = UIStackView(arrangedSubviews: [emailTextField,
                                                         fullNameTextField,
                                                         userNameTextField,
                                                         passwordTextField,
                                                         sighnUpButton])
    
    @objc fileprivate func goToSignInController() {
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - configure components
    
    func configureViewComponents() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.isHidden = true // MARK: - навбар не виден
        view.addSubview(selectPhotoButton)
       
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 250, height: 250))
         selectPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectPhotoButton.layer.cornerRadius = 250/2
        
       
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top:  selectPhotoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 280))
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 40, right: 40))
    }
    
    //MARK: - Keyboard   Settings
    
    fileprivate func setupNotificationObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
         NotificationCenter.default.removeObserver(self)
    }
        
    
    
    
     @objc fileprivate func handleKeyboardShow(notification: Notification ) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardframe = value.cgRectValue
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        let difference = keyboardframe.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 10)
           }
     @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration:  0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
        
    }
    //MARK: -  tapgesturerecogniser (убрать клаву по нажатию на вью)
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handletaDismiss)))
        
    }
    //MARK: - убрать клавиатуру
    
    @objc func handletaDismiss() {
        view.endEditing(true)
    }
    
    
}
