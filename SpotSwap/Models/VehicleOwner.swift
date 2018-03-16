//
//  CarOwners.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/14/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation

struct VehicleOwner: Codable {
    let userName: String
    let userImage: String?
    let userUID: String
    let car: Car
    let rewardPoints: Int
    var swapUserUID: String?
    func toJSON() -> Any {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: [])
    }
}
