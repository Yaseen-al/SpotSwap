
import Foundation
enum UserDefaultsKeys: String {
    case DisplayedWalkthrough
}
class DataPersistence {
    private let userDefaults = UserDefaults.standard
    static let manager = DataPersistence()
    private init() {}
    public func addStateToDefaults(state: Bool, _ key: UserDefaultsKeys){
        userDefaults.set(state, forKey: key.rawValue)
    }
    public func retrieveStateFromDefaults(_ key: UserDefaultsKeys)->Bool?{
        return userDefaults.value(forKey: key.rawValue) as? Bool
    }
}
