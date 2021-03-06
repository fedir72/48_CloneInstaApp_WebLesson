//
//  LoginViewController.swift
//  48_cloneInstaWEbLessonApp
//
//  Created by fedir on 14.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: - properties
    
    private let logoContainerView: UIView = {
        
        let view = UIView()
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "fase") .withRenderingMode(.alwaysOriginal) )
        logoImageView.contentMode = .scaleToFill
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 70))
        logoImageView.centerInSuperView()
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        return view
      
    }()
    
    //MARK: - textfields
    
    fileprivate let mailTextField = UITextField.setupTextField(plaseholder: "Enter mail...", secureTextEnry: false)
    fileprivate let passwordTextField = UITextField.setupTextField(plaseholder: "Password...", secureTextEnry: false)
    
    //MARK: - Button
     
    private let loginButton = UIButton.setupButton(title: "Login", color: UIColor.rgb(red: 149, green: 204, blue: 244))
    
     //MARK: - Button "Do not have account"
    
    private let doNotHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        //первая часть кнопки c разным цвето текста
        var attributetitle = NSMutableAttributedString(string: "  Dont h ave an account ?", attributes: [.font: UIFont.systemFont(ofSize: 18),.foregroundColor: UIColor.lightGray])
        //вторая часть
        attributetitle.append(NSAttributedString(string: "Sign UP", attributes: [.font: UIFont.systemFont(ofSize: 18 , weight: .heavy), .foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(attributetitle, for: .normal)
        button.addTarget(self, action: #selector(goToSignUPController), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.loginButton.isEnabled = true
        configureViewComponents()
        setupTapGesture()
        handlers()
    }
    
    //MARK: - функция контроля заполнения полей и активации сохранения пользователя
    
    fileprivate func handlers() {
        
        mailTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        loginButton.addTarget(self, action:#selector(handleLogin), for: .touchUpInside)
    }
    
    //MARK: - функция активаци кнопки  loginButton
    
    @objc fileprivate func formValidation() {
        
        guard mailTextField.hasText,
            passwordTextField.hasText else {
                self.loginButton.isEnabled = false
                self.loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
                return
        }
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        
    }
    
    //MARK: - функция срабатывает при нажатии на логинбатон(сохранение пользователя)
    
    @objc fileprivate func handleLogin() {
        
        print("handle login")
        guard let email = mailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("failed to login with eror:",error.localizedDescription)
                return
            }
            //переход на майнтабВС
             
            print("Sucsesfuly signed user in")
            let maintabVC = MainTabVC()
            maintabVC.modalPresentationStyle = .fullScreen
            self.present(maintabVC,animated: true,completion: nil)
        }
        
        
        
        
    }
    //MARK: - переход на сигнапконтроллер
    
    @objc fileprivate func goToSignUPController() {
        
        let vc = SignUpController()
        let navcontroll = UINavigationController(rootViewController: vc)
        //navigationController?.pushViewController(vc, animated: true)
        navcontroll.modalPresentationStyle = .fullScreen
        present(navcontroll,animated: true,completion: nil)
        
    }
    
    //MARK: - конфигурация элементов контроллера
    
    fileprivate func configureViewComponents() {
       
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.isHidden = true//сокрытие навбара навигейшена
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        
        //MARK: - stackView settings
        
        let stackView = UIStackView(arrangedSubviews: [mailTextField,passwordTextField,loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 180))
        
        view.addSubview(doNotHaveAccountButton)
        doNotHaveAccountButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 50, right: 40))
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
