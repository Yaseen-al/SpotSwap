import Foundation

class DateProvider {
//    static let manager = DateProvider()
    static let dateFormatter = DateFormatter()
    
//    private init() {
//        dateFormatter = DateFormatter()
//    }
    
    static public func currentTime() -> String {
        let date = Date()
        dateFormatter.dateFormat = "h:mm a"
        let timeString = dateFormatter.string(from: date)
        return timeString
    }

    static func currentTimeSince1970()->TimeInterval{
        let date = Date()
        return date.timeIntervalSince1970
    }
        
    static func randomTimeForSpot(_ upperlimit: Int = 5) -> String {

        let seconds = ["05", "15", "30", "45"]
        let randomIndex = Int(arc4random_uniform(4))
        
        let randomMinute = arc4random_uniform(4) + 1
        let randomSeconds = seconds[randomIndex]
        
        let time = "\(randomMinute):\(randomSeconds)"
        return time
    }
    
    static func parseIntoSeconds(duration: String) -> TimeInterval {
        let components = duration.components(separatedBy: ":")
        if let minutes = components.first, let seconds = components.last {
            if let minutes = Int(minutes), let seconds = Int(seconds) {
                let minutesInSeconds = minutes * 60
                let totalDurationInSeconds = minutesInSeconds + seconds
                return TimeInterval(totalDurationInSeconds)
            }
        }
        return 0.0
    }
    
    static func parseIntoFormattedString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let formattedString = String(format:"%02i:%02i", minutes, seconds)
        return formattedString
    }
}
