//
//  CarMake.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/14/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
struct CarMake: Codable {
    let makeID: String
    let makeName: String
    enum CodingKeys: String, CodingKey {
        case makeID = "Make_ID"
        case makeName = "Make_Name"
    }
}
