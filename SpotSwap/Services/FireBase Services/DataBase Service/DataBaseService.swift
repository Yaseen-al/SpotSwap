//
//  DataBaseService.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/14/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataBaseService {
    static let manager = DataBaseService()
    var dataBaseRef: DatabaseReference
    var carOwnerRef: DatabaseReference
    var carMakes: DatabaseReference
    var spotRef: DatabaseReference
    var reservationRef: DatabaseReference
    
    private init(){
        // this will intialize the reference of the data base to the root of the FireBase dataBase
        self.dataBaseRef = Database.database().reference()
        self.carOwnerRef = dataBaseRef.child("carOwners")
        self.carMakes = dataBaseRef.child("carMakes")
        self.spotRef = dataBaseRef.child("spots")
        self.reservationRef = dataBaseRef.child("reservations")
    }
    
    func getDataBaseRef()-> DatabaseReference {return dataBaseRef}
    func getCarOwnerRef()-> DatabaseReference {return carOwnerRef}
    func getCarMakesRef()-> DatabaseReference {return carMakes}
    func getSpotsRef() -> DatabaseReference {return spotRef}
    func getReservationsRef() -> DatabaseReference {return reservationRef}
}
