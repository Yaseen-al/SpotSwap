import Foundation

class VehicleOwnerServices {
    private var vehicleOwner: VehicleOwner! {
        didSet {
//            if previousReservationID != vehicleOwner.reservationUID {
//                print("New reservation made")
//            }
//            previousReservationID = oldValue?.reservationUID
            print("Vehicle owner updated. Reservation \(vehicleOwner.reservationUID ?? "No reservation made yet.")")
        }
    }
    
//    static let manager = VehicleOwnerServices()
//    private init() {}
    
    init() {
        DataBaseService.manager.retrieveCurrentVehicleOwner(completion: { vehicleOwner in
            self.vehicleOwner = vehicleOwner
        }) { error in
            print(#function, error)
        }
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
