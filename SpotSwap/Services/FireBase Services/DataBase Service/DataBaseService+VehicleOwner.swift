//
//  DataBaseService+CarOwners.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/14/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
import Firebase
enum UserDataBaseErrors: Error{
    case noSignedUser
    case errorDecodingVehicleOwner
}
extension DataBaseService{
    //This will add a new vehicleOwner to the dataBase using the user UID
    func addNewVehicleOwner(vehicleOwner: VehicleOwner, user: User, completion: ()->Void, errorHandler: (Error)->Void){
        let child = self.getCarOwnerRef().child(user.uid)
        child.setValue(vehicleOwner.toJSON())
    }
    //this function will retrieve the vehicleOwner from the data base
    func retrieveVehicleOwner(completion: @escaping(VehicleOwner)->Void, errorHandler: @escaping(Error)->Void) {
        // this will make sure that you have signed up user
        guard let user = AuthenticationService.manager.getCurrentUser() else{
            errorHandler(UserDataBaseErrors.noSignedUser)
            return
        }
        let carOwnerRef = self.getCarOwnerRef().child(user.uid)
        carOwnerRef.observe(.value) { (snapShot) in
            if let json = snapShot.value{
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let vehicleOwner = try JSONDecoder().decode(VehicleOwner.self, from: jsonData)
                    completion(vehicleOwner)
                }
                catch{
                    print("Dev", error)
                    errorHandler(UserDataBaseErrors.errorDecodingVehicleOwner)
                }
            }
        }
        
    }
    // this function will updated a certain user 'A' with a connected user 'B' who is looking for a spot as well as update user 'B' with user 'A'
    
}
