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

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate{
    // MARK: - Properties
    private let signUpView = SignUpView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Stylesheet.Colors.OrangeMain
        self.signUpView.signUpViewDelegate = self
        setupNavBar()
        setupSignUpView()
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
        let registerCarVC = RegisterCarViewController(userName: username, email: email, password: password)
        self.navigationController?.pushViewController(registerCarVC, animated: true)
        
        
    }
    //MARK: Pirvate Functions
    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
//MARK: SignUpViewDelegate
extension SignUpViewController: SignUpViewDelegate{
    func profileImageTapGesture() {
        print("ProfileImage gesture fired")
    }
    func dismissKeyBoard() {
        view.endEditing(true)
        print("it is working")
    }
    
    
}




