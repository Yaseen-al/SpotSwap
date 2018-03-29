//
//  AuthenticationService.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/14/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
import FirebaseAuth

// MARK: - AuthenticationService Errors
public enum AuthenticationServiceErrors: Error{
    case signInError
    case invalidEmail
    case weakPassword
    case signOutError
    case noSignedInUser
    public var errorDescription: String? {
        switch self {
        case .signInError:
            return NSLocalizedString("There was an error in signing in ", comment: "My error")
        case .invalidEmail:
            return NSLocalizedString("A user-friendly description of the error.", comment: "My error")
        case .weakPassword:
            return NSLocalizedString("A user-friendly description of the error.", comment: "My error")
        case .signOutError:
            return NSLocalizedString("A user-friendly description of the error.", comment: "My error")
        case .noSignedInUser:
            return NSLocalizedString("A user-friendly description of the error.", comment: "My error")
        }
    }
}

class AuthenticationService {
    static let manager = AuthenticationService()
    private init(){}
    //MARK: - Public Functions
    
    //This function will get the current user
    public func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    //This function will create a new user
    public func createUser(email: String, password: String, completion: @escaping (User)->Void, errorHandler: @escaping (Error)->Void){
        
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
   public func signIn(email: String, password: String, completion: @escaping (User) -> Void, errorHandler: @escaping(Error)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(#function, AuthenticationServiceErrors.signInError)
                errorHandler(error)
            } else if let user = user {
                completion(user)
            }
        }
    }
    
    //This function will sign the user out
    public func signOut(errorHandler: @escaping(Error)->Void) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(#function, AuthenticationServiceErrors.signOutError)
            errorHandler(error)
        }
    }
}
