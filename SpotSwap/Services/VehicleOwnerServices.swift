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
    
    private weak var delegate: VehicleOwnerServiceDelegate!
    
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
    
    public func reserveSpot(_ spot: Spot) {
        let currentUserReservingASpot = getVehicleOwner()
        let reservation = Reservation(makeFrom: spot, reservedBy: currentUserReservingASpot)
        
        //        contentView.mapView.removeAnnotation(spot)
        DataBaseService.manager.removeSpot(spotId: spot.spotUID)
        
        spot.reservationUID = spot.spotUID
        DataBaseService.manager.addSpot(spot: spot)
        DataBaseService.manager.addReservation(reservation: reservation, to: currentUserReservingASpot)
        DataBaseService.manager.addNewVehicleOwner(vehicleOwner: currentUserReservingASpot, userID: currentUserReservingASpot.userUID)
    }
}
