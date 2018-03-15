//
//  DataBaseService+Spots.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/15/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
extension DataBaseService{
    //TODO read spots
    // reserve spots
    //
    
    func addSpot(spot: Spot){
        let child  = self.getSpotsRef().childByAutoId()
        spot.spotUID = child.key
        child.setValue(spot.toJSON())
    }
    
    
}
