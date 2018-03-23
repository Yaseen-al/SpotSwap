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
        let username = signUpView.usernameTextField.text
        let email = signUpView.emailTextField.text
        let password = signUpView.passwordTextField.text
        AuthenticationService.manager.createUser(email: email!, password: password!, completion: { (user) in
                let myCar = Car(carMake: "Rimac Automobili", carModel: "Concept One", carYear: "2018", carImageId: nil)
        
            let vehicleOwner = VehicleOwner(user: user, car: myCar, userName: username!)
                DataBaseService.manager.addNewVehicleOwner(vehicleOwner: vehicleOwner, user: user, completion: {
                    let registerCarVC = RegisterCarViewController(vehicleOwner: vehicleOwner)
                    self.navigationController?.pushViewController(registerCarVC, animated: true)
                    print("dev: added vehicle owner to the dataBase")
                }, errorHandler: { (error) in
                    print("error in adding a vehicle owner to the data base")
                })
            }) { (error) in
                print(error)
            }
        
        
    }
    
    
    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
}





