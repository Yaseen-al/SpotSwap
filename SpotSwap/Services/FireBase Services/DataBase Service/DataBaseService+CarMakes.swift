//
//  DataBaseService+CarMakes.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/14/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
extension DataBaseService{
    func addAllCarMakes(carMakesDict: [String: [String]]){
        self.getCarMakesRef().setValue(carMakesDict)
    }
}
