//
//  DataBaseService+EndUsers.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/14/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
import Firebase
extension DataBaseService{
    //This will add a new EndUser to the dataBase using the user UID
    func addNewEndUser(endUser: EndUser, user: User, completion: ()->Void, errorHandler: (Error)->Void){
        let child = self.getUserRef().child(user.uid)
        child.setValue(endUser.toJSON())
    }
    
}
