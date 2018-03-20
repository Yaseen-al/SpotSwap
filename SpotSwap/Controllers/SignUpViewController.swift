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
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc private func goToNextView() {
        navigationController?.pushViewController(RegisterCarViewController(), animated: true)
    }
    
}





