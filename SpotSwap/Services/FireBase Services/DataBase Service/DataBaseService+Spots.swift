import Foundation
import Firebase
enum SpotsDataBaseErrors: Error{
    case errorDecodingSpot
    case errorGettingSpotsJSON
    case spotsNodeHasNoChildren
}

extension DataBaseService {
    func addReservation(reservation: Reservation, to vehicleOwner: VehicleOwner) {
        let child  = self.getReservationsRef().childByAutoId()
        reservation.reservationUID = child.key
        child.setValue(reservation.toJSON())
        
        let currentUserReservingSpot = vehicleOwner
        currentUserReservingSpot.reservationUID = child.key
    }
}

extension DataBaseService{
    //This function will read all the spots from the dataBase
    func retrieveAllSpots(completion: @escaping([Spot])->Void, errorHandler: @escaping(Error)->Void){
        let spotsRef = self.getSpotsRef()
        spotsRef.observe(.value) { (snapShot) in
            guard let snapshots = snapShot.children.allObjects as? [DataSnapshot] else{
                errorHandler(SpotsDataBaseErrors.spotsNodeHasNoChildren)
                return
            }
            var allSpots = [Spot]()
            for snapShot in snapshots {
                guard let json = snapShot.value else{
                    errorHandler(SpotsDataBaseErrors.errorGettingSpotsJSON)
                    return
                }
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let spot = try JSONDecoder().decode(Spot.self, from: jsonData)
                    allSpots.append(spot)
                }
                catch{
                    print("Dev: \(error)")
                    errorHandler(SpotsDataBaseErrors.errorDecodingSpot)
                }
            }
            completion(allSpots)
        }
        
    }
    //This function will add a new spot to the dataBase
    func addSpot(spot: Spot){
        let child  = self.getSpotsRef().childByAutoId()
        spot.spotUID = child.key
        child.setValue(spot.toJSON())
    }
    //This function will remove a spot from the dataBase
    func removeSpot(spotId: String){
        let spotRef = self.getSpotsRef().child(spotId)
        spotRef.removeValue()
    }
    
}
