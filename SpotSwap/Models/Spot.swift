//
//  Spot.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/15/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
class Spot: Codable {
    var spotUID: String
    let longitude: Double
    let latitude: Double
    let timeStamp: String
    var userUID: String //this is the user who created the spot
    func toJSON() -> Any {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
    init(spotUID: String, longitude: Double, latitude: Double, timeStamp: String,userUID: String) {
        self.spotUID = spotUID
        self.longitude = longitude
        self.latitude = latitude
        self.timeStamp = timeStamp
        self.userUID = userUID
    }
}
