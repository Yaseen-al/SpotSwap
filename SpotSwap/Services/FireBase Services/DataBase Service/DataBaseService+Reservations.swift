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
