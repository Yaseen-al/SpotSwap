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
    
    private var tapGesture: UITapGestureRecognizer!
    
    var images = [UIImage]() {
        didSet {
            registerCarView.carImageView.image = images.first
        }
    }
    
    var imagePickerController: ImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(registerCarView)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        setupNavBar()
        registerCarView.cameraButton.addTarget(self, action: #selector(cameraButtonPressed), for: .touchUpInside)
        imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(goToMapViewController))
    }
    
    @objc private func goToMapViewController() {
        //TODO: got to the mapViewController
    }
    
    @objc func cameraButtonPressed() {
        //        open up camera and photo gallery
        self.images = []
        present(imagePickerController, animated: true, completion: {
            self.imagePickerController.collapseGalleryView({
            })
        })
    }
    private let imagePickerViewController = UIImagePickerController()
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

