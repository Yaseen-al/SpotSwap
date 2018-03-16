import Foundation
import CoreLocation
import MapKit

class Spot: NSObject, Codable {
    var spotUID: String
    let longitude: Double
    let latitude: Double
    let timeStamp: String
    var userUID: String //this is the user who created the spot
    func toJSON() -> Any {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
    
    init(location: CLLocationCoordinate2D,  userUID: String) {
        self.spotUID = ""
        self.longitude = location.longitude
        self.latitude = location.latitude
        self.timeStamp = DateProvider.manager.randomTimeForSpot()
        self.userUID = userUID
    }
}

extension Spot: MKAnnotation {
    
    // Type must conform to MKAnnotation in order to be used a map pin.
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var title: String? {
        return timeStamp
    }
    
    private func randomTimeForSpot(_ upperlimit: Int = 5) -> String {
        let seconds = ["05", "15", "30", "45"]
        let randomIndex = Int(arc4random_uniform(4))
        
        let randomMinute = arc4random_uniform(4) + 1
        let randomSeconds = seconds[randomIndex]
        
        let time = "\(randomMinute):\(randomSeconds)"
        return time
    }
    
}
