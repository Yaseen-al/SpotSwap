//
//  SignUpViewController.swift
//  SpotSwap
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    let signUpView = SignUpView()

    private var tapGesture: UITapGestureRecognizer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signUpView)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        setupNavBar()
        
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(goToNextView))
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.isNavigationBarHidden = false
    }
    
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
    
    
    
    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
}





