import Foundation

class DateProvider {
    static let manager = DateProvider()
    let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
    }
    
    public func currentTime() -> String {
        let date = Date()
        dateFormatter.dateFormat = "h:mm a"
        let timeString = dateFormatter.string(from: date)
        return timeString
    }
    
    public func randomTimeForSpot(_ upperlimit: Int = 5) -> String {
        let seconds = ["05", "15", "30", "45"]
        let randomIndex = Int(arc4random_uniform(4))
        
        let randomMinute = arc4random_uniform(4) + 1
        let randomSeconds = seconds[randomIndex]
        
        let time = "\(randomMinute):\(randomSeconds)"
        return time
    }
}
