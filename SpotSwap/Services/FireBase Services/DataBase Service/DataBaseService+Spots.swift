//
//  DataBaseService+Spots.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/15/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
import Firebase
enum SpotsDataBaseErrors: Error{
    case errorDecodingSpot
    case errorGettingSpotsJSON
    case spotsNodeHasNoChildren
}
extension DataBaseService{
    //TODO
    //    read spots functions
    func retrieveAllSpots(completion: @escaping([Spot])->Void, errorHandler: @escaping(Error)->Void){
        let spotsRef = self.getSpotsRef()
        spotsRef.observe(.value) { (snapShot) in
            guard let snapshots = snapShot.children.allObjects as? [DataSnapshot] else{
                errorHandler(SpotsDataBaseErrors.spotsNodeHasNoChildren)
                return
            }
            var allSpots = [Spot]()
            for snapShot in snapshots {
                guard let json = snapShot.value else{
                    errorHandler(SpotsDataBaseErrors.errorGettingSpotsJSON)
                    return
                }
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let spot = try JSONDecoder().decode(Spot.self, from: jsonData)
                    allSpots.append(spot)
                }
                catch{
                    print("Dev: \(error)")
                    errorHandler(SpotsDataBaseErrors.errorDecodingSpot)
                }
            }
            completion(allSpots)
        }
        
    }
    // reserve spots
    func addSpot(spot: Spot){
        let child  = self.getSpotsRef().childByAutoId()
        spot.spotUID = child.key
        child.setValue(spot.toJSON())
    }
    //this function will remove a spot from the dataBase
    
    
}
