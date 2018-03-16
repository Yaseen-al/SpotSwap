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
    case failedToUpdateVehicleOwner
}
extension DataBaseService{
    //This will add a new vehicleOwner to the dataBase using the user UID
    func addNewVehicleOwner(vehicleOwner: VehicleOwner, user: User, completion: ()->Void, errorHandler: (Error)->Void){
        let child = self.getCarOwnerRef().child(user.uid)
        child.setValue(vehicleOwner.toJSON())
    }
    //This function will retrieve the vehicleOwner from the data base
    func retrieveCurrentVehicleOwner(completion: @escaping(VehicleOwner)->Void, errorHandler: @escaping(Error)->Void) {
        // This will make sure that you have signed up user
        guard let user = AuthenticationService.manager.getCurrentUser() else{
            errorHandler(UserDataBaseErrors.noSignedUser)
            return
        }
        let vehicleOwnerRef = self.getCarOwnerRef().child(user.uid)
        vehicleOwnerRef.observe(.value) { (snapShot) in
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
    // This function will retrieve a vehicleOwner using user UID
    func retrieveVehicleOwner(vehicleOwner: String, completion: @escaping(VehicleOwner)->Void, errorHandler: @escaping(Error)->Void) {
        let vehicleOwnerRef = self.getCarOwnerRef().child(vehicleOwner)
        vehicleOwnerRef.observe(.value) { (snapShot) in
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
    //This function will update vehiclOwner on the dataBase
    func updateVehicleOwner(vehicleOwner: VehicleOwner, errorHandler: @escaping (Error)->Void){
        let vehicleOwnerRef = self.getCarOwnerRef().child(vehicleOwner.userUID)
        
        vehicleOwnerRef.setValue(vehicleOwner.toJSON()) { (error, dataBaseRef) in
            if let error =  error{
                print("dev: \(error)")
                errorHandler(UserDataBaseErrors.failedToUpdateVehicleOwner)
                return
            }
            print("Dev: this is the refrence key for the updated vehicle owner", dataBaseRef.key)
        }
    }
    // This function will updated a certain user 'A' with a connected user 'B' who is looking for a spot as well as update user 'B' with user 'A'
    func connectCarOwnersAfterReservation(spot: Spot, completion:(Bool)->Void, erroHandler:@escaping (Error)->Void) {
        guard let currentUser = AuthenticationService.manager.getCurrentUser() else{
            erroHandler(AuthenticationServiceErrors.noSignedInUser)
            return
        }
        retrieveCurrentVehicleOwner(completion: { (vehicleOwner) in
            var currentVehicleOwner = vehicleOwner
            currentVehicleOwner.swapUserUID = spot.userUID
            self.updateVehicleOwner(vehicleOwner: currentVehicleOwner, errorHandler: { (error) in
                erroHandler(error)
                return
            })
        }) { (error) in
            erroHandler(error)
            return
        }
        self.retrieveVehicleOwner(vehicleOwner: spot.userUID, completion: { (vehicleOwner) in
            var connectedVehicleOwner = vehicleOwner
            connectedVehicleOwner.swapUserUID = currentUser.uid
        }) { (error) in
            erroHandler(error)
        }
    }
    
}
