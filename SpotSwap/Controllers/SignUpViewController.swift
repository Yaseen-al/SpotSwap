//
//  SignUpViewController.swift
//  SpotSwap
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit
import ImagePicker
import Firebase

class SignUpViewController: UIViewController{
    // MARK: - Properties
    private let signUpView = SignUpView()
    var keyboardHeight: CGFloat = 0
    private var imagePickerController: ImagePickerController!
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Stylesheet.Colors.OrangeMain
        self.signUpView.signUpViewDelegate = self
        setupNavBar()
        setupSignUpView()
    }
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        setupSignUpView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        setupImagePicker()
    }
    private func setupImagePicker() {
        imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
    }
    
    // MARK: - Setup NavigationBar
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(goToNextView))
        navigationController?.navigationBar.barTintColor = Stylesheet.Contexts.NavigationController.BarColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.isNavigationBarHidden = false
    }
    private func setupSignUpView(){
        view.addSubview(signUpView)
        signUpView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }

    
    //MARK:  Acitons
    @objc private func goToNextView() {
        guard let username = signUpView.usernameTextField.text, let email = signUpView.emailTextField.text, let password = signUpView.passwordTextField.text else{
            showAlert(title: "Please enter a valid email, username, and password", message: nil)
            return
        }
        guard username != "", email != "",  password != "" else {
            showAlert(title: "Please enter a valid email, username, and password", message: nil)
            return
        }
        guard email.contains("@"), email.contains(".") else {
            showAlert(title: "Please enter a valid email", message: nil)
            return
        }
        guard let image = signUpView.profileImage.image else{
            showAlert(title: "Please select a valid picture", message: nil)
            return
        }
        let registerCarVC = RegisterCarViewController(userName: username, email: email, password: password, profileImage: image)
        self.navigationController?.pushViewController(registerCarVC, animated: true)
        
        
    }
    //MARK: Prvate Functions
    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: - Setup Keyboard Handling
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardHeight == 0 {
                keyboardHeight = keyboardSize.height
            }else{
                return
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.view.frame.origin.y -= self.keyboardHeight
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.view.frame = self.view.bounds
        }) { (animated) in
            self.keyboardHeight = 0
        }
    }
    

    
}

//MARK: ImagePickerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate, ImagePickerDelegate{
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.signUpView.profileImage.image = images.first
        dismiss(animated: true, completion: nil)
        return
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.resetAssets()
        return
    }
    
}


//MARK: SignUpViewDelegate
extension SignUpViewController: SignUpViewDelegate{
    func profileImageTapGesture() {
        print("ProfileImage gesture fired")
        //        open up camera and photo gallery
        present(imagePickerController, animated: true, completion: {
            self.imagePickerController.collapseGalleryView({
            })
        })
    }
    func dismissKeyBoard() {
        view.endEditing(true)
    }
    
}




