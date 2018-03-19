//
//  DataBaseService+Spots.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/15/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
import Firebase
extension DataBaseService{
    //This function will read all the spots from the dataBase
    func retrieveAllSpots(completion: @escaping([Spot])->Void, errorHandler: @escaping(Error)->Void){
        let spotsRef = self.getSpotsRef()
        spotsRef.observe(.value) { (snapShot) in
            guard let snapshots = snapShot.children.allObjects as? [DataSnapshot] else{
                errorHandler(DataBaseReferenceErrors.spotsNodeHasNoChildren)
                return
            }
            var allSpots = [Spot]()
            for snapShot in snapshots {
                guard let json = snapShot.value else{
                    errorHandler(DataBaseReferenceErrors.errorGettingSpotsJSON)
                    return
                }
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let spot = try JSONDecoder().decode(Spot.self, from: jsonData)
                    allSpots.append(spot)
                }
                catch{
                    print("Dev: \(error)")
                    errorHandler(DataBaseReferenceErrors.errorDecodingSpot)
                }
            }
            completion(allSpots)
        }
        
    }
    //This function will add a new spot to the dataBase
    func addSpot(spot: Spot){
        let child  = self.getSpotsRef().childByAutoId()
        spot.spotUID = child.key
        child.setValue(spot.toJSON())
    }
    //This function will remove a spot from the dataBase
    func removeSpot(spotId: String){
        let spotRef = self.getSpotsRef().child(spotId)
        spotRef.removeValue()
    }
    
}
