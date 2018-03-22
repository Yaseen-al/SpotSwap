//
//  RegisterCarViewController.swift
//  SpotSwap
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit
import ImagePicker

class RegisterCarViewController: UIViewController, UIImagePickerControllerDelegate {
    
    let registerCarView = RegisterCarView()
    
    
    var images = [UIImage]() {
        didSet {
            registerCarView.carImageView.image = images.first
        }
    }
    
    var imagePickerController: ImagePickerController!
    private let imagePickerViewController = UIImagePickerController()
    
    var carModelOptions = ["Hello", "Hola", "Bonjour", "Nihao"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(registerCarView)
        setupNavBar()
        registerCarView.cameraButton.addTarget(self, action: #selector(cameraButtonPressed), for: .touchUpInside)
        imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        registerCarView.tableView.delegate = self
        registerCarView.tableView.dataSource = self
        registerCarView.dropDownButton.addTarget(self, action: #selector(dropDownList), for: .touchUpInside)
        
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(goToMapViewController))
    }
    
    @objc private func goToMapViewController() {
         navigationController?.pushViewController(MapViewController(), animated: true)
    }
    
    @objc func cameraButtonPressed() {
        //        open up camera and photo gallery
        self.images = []
        present(imagePickerController, animated: true, completion: {
            self.imagePickerController.collapseGalleryView({
            })
        })
    }
    
    var isOpen = false // dropDownList is close
    @objc private func dropDownList() {
        if isOpen == false {
            
            isOpen = true
            
            NSLayoutConstraint.deactivate([registerCarView.height])
            self.registerCarView.height.constant = 100
            NSLayoutConstraint.activate([registerCarView.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.registerCarView.tableView.layoutIfNeeded()
                self.registerCarView.tableView.center.y += self.registerCarView.tableView.frame.height / 2
            }, completion: nil)
        } else {
            isOpen = false
            NSLayoutConstraint.deactivate([registerCarView.height])
            self.registerCarView.height.constant = 0
            NSLayoutConstraint.activate([registerCarView.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.registerCarView.tableView.center.y -= self.registerCarView.tableView.frame.height / 2
                self.registerCarView.tableView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        registerCarView.carMakeTextField.resignFirstResponder()
    }
}

extension RegisterCarViewController: ImagePickerDelegate{
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.images = images
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

extension RegisterCarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carModelOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let model = carModelOptions[indexPath.row]
        cell.textLabel?.text = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = carModelOptions[indexPath.row]
        registerCarView.dropDownButton.setTitle(" \(model)", for: .normal)
        isOpen = false
        NSLayoutConstraint.deactivate([registerCarView.height])
        self.registerCarView.height.constant = 0
        NSLayoutConstraint.activate([registerCarView.height])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.registerCarView.tableView.center.y -= self.registerCarView.tableView.frame.height / 2
            self.registerCarView.tableView.layoutIfNeeded()
        }, completion: nil)
    }
    
}

