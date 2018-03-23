import Foundation
import MapKit

class Reservation: NSObject, Codable {
    var spotOwnerId: String
    var userUID: String //This is the user who created the spot
    var takerId: String
    var reservationId: String?
    let longitude: Double
    let latitude: Double
    let timeStamp: String
    let duration: String
    
    func toJSON() -> Any {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return try JSONSerialization.jsonObject(with: jsonData, options: [])
        } catch  {
            print(error)
            fatalError("Could not encode ReservedSpot")
        }
    }
    
    init(makeFrom availableSpot: Spot, reservedBy: VehicleOwner) {
        self.spotOwnerId = availableSpot.userUID
        self.takerId = reservedBy.userUID
        self.reservationId = ""
        self.userUID = reservedBy.userUID
        //        self.userUID = AuthenticationService.manager.getCurrentUser()?.uid ?? "NotLoggedIn"
        self.longitude = availableSpot.longitude
        self.latitude = availableSpot.latitude
        self.timeStamp = availableSpot.timeStamp
        self.duration = availableSpot.duration
    }
    
    //    init(location: CLLocationCoordinate2D) {
    //        self.spotUID = ""
    //        self.reservationUID = nil
    //        self.longitude = location.longitude
    //        self.latitude = location.latitude
    //        self.duration = DateProvider.manager.randomTimeForSpot()
    //        self.timeStamp = DateProvider.manager.currentTime()
    //        self.userUID = AuthenticationService.manager.getCurrentUser()?.uid ?? "NotLoggedIn"
    //    }
}

extension Reservation: MKAnnotation {
    
    // Type must conform to MKAnnotation in order to be used a map pin.
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? {
        return self.duration.description
    }
    
}

