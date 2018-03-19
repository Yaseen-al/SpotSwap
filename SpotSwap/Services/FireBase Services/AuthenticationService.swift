//
//  AuthenticationService.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/14/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
import FirebaseAuth

enum AuthenticationServiceErrors: Error{
    case signInError
    case invalidEmail
    case weakPassword
    case signOutError
    case noSignedInUser
}
class AuthenticationService {
    private init(){}
    //This function will get the current user
    static let manager = AuthenticationService()
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    //This function will create a new user
    func createUser(email: String, password: String, completion: @escaping (User)->Void, errorHandler: @escaping (Error)->Void){

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error{
                //TODO  handle the error
                print(#function, error)
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    switch errCode {
                    case .emailAlreadyInUse:
                        print("invalid email")
                        errorHandler(AuthenticationServiceErrors.invalidEmail)
                    case .weakPassword:
                        print("weak pass")
                        errorHandler(AuthenticationServiceErrors.weakPassword)
                    default:
                        print("Create User Error: \(error)")
                    }
                }
                errorHandler(error)
            }
            if let user = user{
                completion(user)
            }
        }
    }
    //This function will let you sign in
    func signIn(email: String, password: String, completion: @escaping (User) -> Void, errorHandler: @escaping(Error)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Dev: \(error)")
                errorHandler(AuthenticationServiceErrors.signInError)
            } else if let user = user {
                completion(user)
            }
        }
    }
    
    //this function will sign the user out
    func signOut(errorHandler: @escaping(Error)->Void) {
        do {
            try Auth.auth().signOut()
        } catch {
            errorHandler(AuthenticationServiceErrors.signOutError)
        }
    }
}
