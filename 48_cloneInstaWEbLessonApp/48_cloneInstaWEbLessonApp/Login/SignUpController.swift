//
//  SignUpController.swift
//  48_cloneInstaWEbLessonApp
//
//  Created by fedir on 15.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK: - переменная контроля выбора фото профиля
    var imageSelected = false
    
    //MARK: - Properties
    
    fileprivate let selectPhotoButton: UIButton = {
        let buton = UIButton(type: .system)
        buton.setTitle("Select Photo", for: .normal)
        buton.setTitleColor(.black, for: .normal)
        buton.backgroundColor = .white
        buton.layer.cornerRadius = buton.frame.width/2
        buton.layer.borderWidth = 3
        buton.layer.borderColor = UIColor.rgb(red: 149, green: 204, blue: 244).cgColor
        buton.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside )
        return buton
        }()
    //MARK: -  переход к выбору фото for profile
    
      @objc fileprivate  func selectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker,animated: true,completion: nil)
    }
    
    fileprivate let userNameTextField = UITextField.setupTextField(plaseholder: "Name...", secureTextEnry: false)
    fileprivate let emailTextField = UITextField.setupTextField(plaseholder: "Email...", secureTextEnry: false)
    fileprivate let fullNameTextField = UITextField.setupTextField(plaseholder: "Full name...", secureTextEnry: false)
    fileprivate let passwordTextField = UITextField.setupTextField(plaseholder: "Password...", secureTextEnry: false)
    
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
    
    
    //MARK: - viewDidLoad()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureViewComponents()
        setupNotificationObserver()
        setupTapGesture()
        handleres()
    }
    
//MARK: - UIImagepicker ()
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        
//MARK: - изменение настроек кнопки после выбора фото профиля
        imageSelected = true
        selectPhotoButton.layer.cornerRadius = selectPhotoButton.frame.width/2
        selectPhotoButton.layer.masksToBounds = true
        selectPhotoButton.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        selectPhotoButton.layer.borderWidth = 2
        // selectPhotoButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        selectPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -
    
    fileprivate func handleres() {
      
        emailTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        sighnUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    //
    @objc fileprivate func handleSignUp() {
      //print("signUp")
        self.handletaDismiss() //убрать клаву
        
        //MARK: - значения для сохранения
        
        guard let email = emailTextField.text?.lowercased() else {return}
        guard let password = passwordTextField.text else {return}
        guard let username = userNameTextField.text else {return}
        guard let fullname = fullNameTextField.text?.lowercased() else  {return}
        
        //MARK: - авторизация пользователя в фаербейс
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            print("Пользователь успешно создан")
            
    //MARK: - загрузка пользователей в базу данных firebase
            guard let profileImage = self.selectPhotoButton.imageView?.image else {return}
            guard let uploaddata = profileImage.jpegData(compressionQuality: 0.3) else{return}
            let filename = NSUUID().uuidString//рандомное имя файла пользователя
            let storageRef = Storage.storage().reference().child("Profile_image").child(filename)
          
            storageRef.putData(uploaddata, metadata: nil) { (_, err) in
                if let err = err {
                    print("не удалось загрузить фото: " ,err.localizedDescription)
                    return
                }
                print("Load sucsecfuly")
                
                //MARK: - загрузка данных в сеть
                
                storageRef.downloadURL { (downloadUrl, err) in
                    guard let profileImageURL = downloadUrl?.absoluteString else {return}
                    if let err = err {
                        print("profile imageis nil" , err.localizedDescription)
                        return
                    }
                    
                print("ссылка на картинку получена")
                
                guard let uid = user?.user.uid else { return }
                let dictionaryValues = ["name": fullname, "username": username ,"profileImageUrl": profileImageURL]
                let values = [uid: dictionaryValues]
                    Firestore.firestore().collection("users").document(uid).setData(values) { (error) in
                        if let eror  = error {
                            print("Failed ", eror.localizedDescription)
                            return
                        }
                        print("данные   сохранены")
                    }
                   
                }
            }
        }
    }
    //MARK: - функция контроля заполнения полей формы пользователя для активации кнопки регистрации
    @objc fileprivate func formValidation() {
    guard emailTextField.hasText,
          fullNameTextField.hasText,
        userNameTextField.hasText,
        passwordTextField.hasText,
        imageSelected == true else {
            sighnUpButton.isEnabled = false
            sighnUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            return
        }
        sighnUpButton.isEnabled = true
        sighnUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        
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
