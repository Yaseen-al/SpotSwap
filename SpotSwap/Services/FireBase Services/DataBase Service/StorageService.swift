//
//  StorageService.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/22/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

enum ImageType {
    case vehicleOwner
    case vehicleImage
}

class FirebaseStorageManager {
    static let shared = FirebaseStorageManager()
    private var storage: Storage
    private var storageRef: StorageReference
    private var vehicleOwnerImageRef: StorageReference
    private var vehicleImageRef: StorageReference
    
    private init(){
        storage = Storage.storage()
        storageRef = storage.reference()
        vehicleOwnerImageRef = storageRef.child("vehiclOwnerImages")
        vehicleImageRef = storageRef.child("vehicleImages")
    }

    
    func storeImage(type: ImageType, uid: String, image: UIImage) {
        guard let data = UIImagePNGRepresentation(image) else { print("image is nil"); return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        ///////////////TODO switch on the type and change the refrence respectively
        let uploadTask = FirebaseStorageManager.shared.vehicleOwnerImageRef.child(uid).putData(data, metadata: metadata) { (storageMetadata, error) in
            if let error = error {
                print("uploadTask error: \(error)")
            } else if let storageMetadata = storageMetadata {
                print("storageMetadata: \(storageMetadata)")
            }
        }
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentProgress = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print(percentProgress)
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            
            // set  imageURL
            let imageURL = String(describing: snapshot.metadata!.downloadURL()!)
            
            switch type {
            case .vehicleOwner:
                DataBaseService.manager.getCarOwnerRef().child(uid).child("userImage").setValue(imageURL)
            case .vehicleImage:
                DataBaseService.manager.getCarOwnerRef().child(uid).child("car").child("carImageId").setValue(imageURL)
            }
            
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
    }
    
    func retrieveImage(imgURL: String,
                       completionHandler: @escaping (UIImage) -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        ImageHelper.manager.getImage(from: imgURL, completionHandler: { completionHandler($0) }, errorHandler: { errorHandler($0) })
    }
    
    
}
