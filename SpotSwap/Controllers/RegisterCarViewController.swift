//
//  RegisterCarViewController.swift
//  SpotSwap
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
import UIKit
import ImagePicker
import Toucan

class RegisterCarViewController: UIViewController, UIImagePickerControllerDelegate {
    // MARK: - Properties
    private var email: String
    private var password: String
    private var userName: String
    private var profileImage: UIImage
    private var imagePickerController: ImagePickerController!
    private let registerCarView = RegisterCarView()
    private var carDict = [String:[String]]()
    private  var carModelOptions = [String]()
    private var isOpen = false // dropDownList is close
    var keyboardHeight: CGFloat = 0

    //MARK: Inits
    init(userName:String, email: String, password: String, profileImage: UIImage) {
        self.email = email
        self.password = password
        self.userName = userName
        self.profileImage = profileImage
        super.init(nibName: nil, bundle: nil)
        
    }
    // MARK: - View Life Cycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Stylesheet.Colors.GrayMain
        setupNavBar()
        setupRegisterCarView()
        setupImagePicker()
        configureSimpleInLineSearchTextField()
        registerCarView.tableView.delegate = self
        registerCarView.tableView.dataSource = self
        registerCarView.carMakeTextField.delegate = self
        registerCarView.dropDownButton.addTarget(self, action: #selector(dropDownList), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    // MARK: - Setup NavBar and Views
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:
            #selector(goToMapViewController))
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    private func setupRegisterCarView(){
        view.addSubview(registerCarView)
        registerCarView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    private func setupImagePicker() {
        imagePickerController = ImagePickerController()
        registerCarView.cameraButton.addTarget(self, action: #selector(cameraButtonPressed), for: .touchUpInside)
        registerCarView.addImageButton.addTarget(self, action: #selector(cameraButtonPressed), for: .touchUpInside)
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
    }
    
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc private func goToMapViewController() {
        guard let make = registerCarView.carMakeTextField.text, let model = registerCarView.dropDownButton.titleLabel?.text else {
            Alert.present(title: "Please enter a valid car make and model", message: nil)
            return
        }
        guard make != "", model != "" else {
            Alert.present(title: "Please enter a valid car make and model", message: nil)
            return
        }
        guard let vehicleImage = registerCarView.carImageView.image , registerCarView.carImageView.image != #imageLiteral(resourceName: "defaultVehicleImage") else{
            Alert.present(title: "Please select a valid car image, so others will be able to swap easily with you", message: nil)
            return
        }
        //Compress the images for the storage
        let profileImageSize: CGSize = CGSize(width: 300, height: 300)
        guard let toucanProfileImage = Toucan.Resize.resizeImage(self.profileImage, size: profileImageSize) else{
            Alert.present(title: "error uploading your image please try again", message: nil)
            return
        }
        let vehicleImageSize: CGSize = CGSize(width: 300, height: 300)
        guard let tocanVehicleImage = Toucan.Resize.resizeImage(vehicleImage, size: vehicleImageSize) else{
            Alert.present(title: "There was an error uploading your image please try again", message: nil)
            return
        }
        
        AuthenticationService.manager.createUser(email: email, password: password, completion: { (user) in
            let newCar = Car(carMake: make, carModel: model, carYear: "2018")
            let newVehicleOwner = VehicleOwner(user: user, car: newCar, userName: self.userName)
            DataBaseService.manager.addNewVehicleOwner(vehicleOwner: newVehicleOwner, userID: user.uid)
            StorageService.manager.storeImage(imageType: .vehicleOwner, uid: user.uid, image: toucanProfileImage, errorHandler: { (error) in
                print(#function, error)
                Alert.present(title: "There was an error adding your images to the data base \(error.localizedDescription)", message: nil)
            })
            StorageService.manager.storeImage(imageType: .vehicleImage, uid: user.uid, image: tocanVehicleImage, errorHandler: { (error) in
                print(#function, error)
                Alert.present(title: "There was an error adding your images to the data base \(error.localizedDescription)", message: nil)
            })
            let mapViewController = ContainerViewController.storyBoardInstance()
            self.present(mapViewController, animated: true, completion: nil)
        }) { (error) in
             Alert.present(title: error.localizedDescription, message: nil)
        }
    }
    
    @objc func cameraButtonPressed() {
        //        open up camera and photo gallery
        present(imagePickerController, animated: true, completion: {
            self.imagePickerController.collapseGalleryView({
            })
        })
    }
    
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
    
    // Configure a simple inline search text view
    private func configureSimpleInLineSearchTextField() {
        // Define the inline mode
        registerCarView.carMakeTextField.inlineMode = true
        
        // Set data source
        DataBaseService.manager.retrieveAllCarMakes(completion: { (carMakeDict:[String:[String]]) in
            self.carDict = carMakeDict
            var carMakeKey: [String] {
                var arr: [String] = []
                for (key, _) in carMakeDict {
                    arr.append(key)
                }
                return arr
            }
            self.registerCarView.carMakeTextField.filterStrings(carMakeKey)
        }, errorHandler: {(error: Error) in
            Alert.present(title: "There was an error retrieving car makes \(error.localizedDescription)", message: nil)
        })
        
    }
    
}
//MARK: - Image Picker Delegates
extension RegisterCarViewController: ImagePickerDelegate {
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard !images.isEmpty else { return }
        let selectedImage = images.first!
        registerCarView.carImageView.image = selectedImage
        profileImage = selectedImage
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
//MARK: - TableView Delegates

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
        cell.textLabel?.text = String(describing: model)
        cell.textLabel?.textColor = .black
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
//MARK: - TextField Delegates

extension RegisterCarViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let carMake = textField.text else {
            resignFirstResponder()
            return
        }
        guard let carModelOptions = carDict[carMake] else{
            Alert.present(title: "We are sorry this car make doesn't exist on our dataBase,", message: " we really appreciate you patience ")
            return
        }
        self.carModelOptions = carModelOptions
        registerCarView.tableView.reloadData()
        resignFirstResponder()
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
