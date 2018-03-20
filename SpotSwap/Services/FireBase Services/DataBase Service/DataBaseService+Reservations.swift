//
//  DataBaseService+Reservations.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/20/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
extension DataBaseService{
    //MARK: - Public Functions
    //This funciton will add a reservation for a vehicleOwner
    func addReservation(reservation: Reservation, to vehicleOwner: VehicleOwner) {
        let child  = self.getReservationsRef().childByAutoId()
        reservation.reservationUID = child.key
        child.setValue(reservation.toJSON())
        
        let currentUserReservingSpot = vehicleOwner
        currentUserReservingSpot.reservationUID = child.key
    }
    //This function will retrieve all reservations 
    public func retrieveReservations(reservationID: String, completion: @escaping (Reservation)->Void , errorHandler: @escaping (Error)->Void) {
        let reservationRef = self.getReservationsRef().child(reservationID)
        reservationRef.observe(.value) { (snapShot) in
            if let json = snapShot.value as? NSDictionary {
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let reservation = try JSONDecoder().decode(Reservation.self, from: jsonData)
                    completion(reservation)
                }
                catch{
                    print(#function, error)
                    errorHandler(DataBaseReferenceErrors.errorDecodingVehicleOwner)
                }
            }
        }
        
    }
}
