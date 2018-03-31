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
    private var selectedCarMake = ""{
        didSet{
            self.registerCarView.modelsPickerView.reloadAllComponents()
        }
    }
    private var selectedModel = ""
    private var carDict = [String:[String]](){
        didSet{
            self.selectedModel = "Mercedes-Benz"
            self.registerCarView.makesPickerView.reloadAllComponents()
        }
    }

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
        setupNavBar()
        loadCarMakes()
        setupRegisterCarView()
        loadCarMakes()
        registerCarView.pastelView.startAnimation()
        registerCarView.modelsPickerView.dataSource = self
        registerCarView.makesPickerView.dataSource = self
        registerCarView.modelsPickerView.delegate = self
        registerCarView.makesPickerView.delegate = self
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
            make.edges.equalTo(view.snp.edges)
        }
    }

    // MARK: - Private functions
    func loadCarMakes(){
        DataBaseService.manager.retrieveAllCarMakes(completion: { (carmakesModelsDict) in
            self.carDict = carmakesModelsDict
        }) { (error) in
            Alert.present(title: "There was an error retrieving care makes", message: error.localizedDescription)
        }
    }
    // MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc private func goToMapViewController() {
        guard let make = carDict["Honda"]?.first, let model = carDict["Honda"]?.first else {
            Alert.present(title: "Please enter a valid car make and model", message: nil)
            return
        }

        guard let vehicleImage = registerCarView.carImageView.image , registerCarView.carImageView.image != #imageLiteral(resourceName: "defaultVehicleImage") else{
            Alert.present(title: "Please select a valid car image, so others will be able to swap easily with you", message: nil)
            return
        }

        let vehicleImageSize: CGSize = CGSize(width: 300, height: 300)
        guard let tocanVehicleImage = Toucan.Resize.resizeImage(vehicleImage, size: vehicleImageSize) else{
            Alert.present(title: "There was an error uploading your image please try again", message: nil)
            return
        }
        //Compress the images for the storage
        let profileImageSize: CGSize = CGSize(width: 300, height: 300)
        guard let toucanProfileImage = Toucan.Resize.resizeImage(self.profileImage, size: profileImageSize) else{
            Alert.present(title: "error uploading your image please try again", message: nil)
            return
        }
        self.registerCarView.carImageView.image = vehicleImage
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
    
    private func cameraButtonPressed() {
        //        open up camera and photo gallery
        present(imagePickerController, animated: true, completion: {
            self.imagePickerController.collapseGalleryView({
            })
        })
    }
    

   
    
}
//MARK: - Picker View data source
extension RegisterCarViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return carDict.keys.count
        default:
            return carDict[selectedCarMake]?.count ?? 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            let arrayOfCarMakesNames = Array(carDict.keys)
            return arrayOfCarMakesNames[row]
        default:
            guard let carModels = carDict[selectedCarMake]  else{return "BMX"}
            return carModels[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch pickerView.tag {
        case 0:
            let arrayOfCarMakesNames = Array(carDict.keys)
            let attributedString = NSAttributedString(string: arrayOfCarMakesNames[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            return attributedString
        default:
            guard let carModels = carDict[selectedCarMake]  else {return nil}
            let attributedString = NSAttributedString(string: carModels[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
            return attributedString
        }
    }
}
//MARK: - Picker View data source
extension RegisterCarViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            self.selectedCarMake = Array(carDict.keys)[row]
            pickerView.view(forRow: row, forComponent: component)?.backgroundColor = .white
            
        default:
            guard let carModels = carDict[selectedCarMake]  else{return}
            self.selectedModel = carModels[row]
        }
    }
}
//MARK: - Image Picker Delegates
extension RegisterCarViewController: ImagePickerDelegate {
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard !images.isEmpty else { return }
        let selectedImage = images.first!
        registerCarView.carImageView.image = selectedImage
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


