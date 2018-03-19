import Foundation

protocol VehicleOwnerServiceDelegate: class {
    func vehicleOwnerReservationDidUpdate(_ reservation: String)
}

class VehicleOwnerServices {
    private var vehicleOwner: VehicleOwner! {
        didSet {
//            if previousReservationID != vehicleOwner.reservationUID {
//                print("New reservation made")
//            }
//            previousReservationID = oldValue?.reservationUID
            print("Vehicle owner updated. Reservation \(vehicleOwner.reservationUID ?? "No reservation made yet.")")
            delegate.vehicleOwnerReservationDidUpdate(vehicleOwner.reservationUID ?? "No reservation made yet.")
        }
    }
    
    weak var delegate: VehicleOwnerServiceDelegate!
    
//    static let manager = VehicleOwnerServices()
//    private init() {}
    
    init(_ viewController: VehicleOwnerServiceDelegate) {
        DataBaseService.manager.retrieveCurrentVehicleOwner(completion: { vehicleOwner in
            self.vehicleOwner = vehicleOwner
        }) { error in
            print(#function, error)
        }
        delegate = viewController
    }
    
    public func fetchVehicleOwnerFromFirebase() {
        DataBaseService.manager.retrieveCurrentVehicleOwner(completion: { vehicleOwner in
            self.vehicleOwner = vehicleOwner
        }) { error in
            print(#function, error)
        }
    }
    
    public func getVehicleOwner() -> VehicleOwner {
        return vehicleOwner // app should crash if we dont have a vehicle owner
    }
    
    public func hasReservation() -> Bool {
        return vehicleOwner.reservationUID != nil
    }
}
