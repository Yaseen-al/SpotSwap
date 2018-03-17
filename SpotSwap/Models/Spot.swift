import Foundation
import CoreLocation
import MapKit

struct Reservation: Codable {
    let userUID: String
}

class Spot: NSObject, Codable {
    var spotUID: String
    var userUID: String //this is the user who created the spot
    var reservation: Reservation?
    let longitude: Double
    let latitude: Double
    let timeStamp: String
    let duration: String
    func toJSON() -> Any {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
    
    init(location: CLLocationCoordinate2D) {
        self.spotUID = ""
        self.reservation = nil
        self.longitude = location.longitude
        self.latitude = location.latitude
        self.duration = DateProvider.manager.randomTimeForSpot()
        self.timeStamp = DateProvider.manager.currentTime()
        self.userUID = AuthenticationService.manager.getCurrentUser()?.uid ?? "NotLoggedIn"
    }
}

extension Spot: MKAnnotation {
    
    // Type must conform to MKAnnotation in order to be used a map pin.
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? {
        return self.duration.description
    }
    
}
