import UIKit
import SnapKit
import ImagePicker


final class ProfileViewControleller: UIViewController {
    
    //    MARK: - Properties
    private var vehicleOwnerService: VehicleOwnerService!
    var profileView = ProfileView()
    private var imagePickerController: ImagePickerController!
    
    //    MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        vehicleOwnerService = VehicleOwnerService(self)
        setupImagePicker()
    }
    private func setupImagePicker() {
        imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
    }
    
    func setupProfileView() {
        guard let vehicleOwner = vehicleOwnerService.getVehicleOwner() else {return}
        profileView = ProfileView(vehicleOwner)
        self.profileView.profileViewDelegate = self
        view.addSubview(profileView)
        profileView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(view.snp.edges)
        }
    }
  
    func goToPreviousView() {
        dismiss(animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


extension ProfileViewControleller: VehicleOwnerServiceDelegate{
    func vehicleOwnerRetrieved() {
        setupProfileView()
    }
    
    func vehicleOwnerSpotReserved(reservationId: String, currentVehicleOwner: VehicleOwner) {
        
    }
    
    func vehiclOwnerRemoveReservation(_ reservationId: Reservation) {
        
    }
    
    func vehiclOwnerHasNoReservation() {
        
    }
    
    
}

//MARK: ProfileViewDelegate
extension ProfileViewControleller: ProfileViewDelegate{
    func backButton() {
        goToPreviousView()
    }
    func profileImageTapGesture() {
        print("ProfileImage gesture fired")
        //        open up camera and photo gallery
        present(imagePickerController, animated: true, completion: {
            self.imagePickerController.collapseGalleryView({
            })
        })
    }
   
}


//MARK: ImagePickerDelegate
extension ProfileViewControleller: UIImagePickerControllerDelegate, ImagePickerDelegate{
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.profileView.profileImage.image = images.first
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
