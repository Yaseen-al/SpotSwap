//
//  ViewController.swift
//  SpotSwap
//
//  Created by Yaseen Al Dallash on 3/14/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func testSpot(){
        let user = AuthenticationService.manager.getCurrentUser()!
        let date = Date()
        let timeFormater = DateFormatter()
        timeFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = timeFormater.string(from: date)
        print(dateString)
        let spot = Spot(spotUID: "adg", longitude: 151.5, latitude: 135.15, timeStamp: dateString, userUID: user.uid)
        DataBaseService.manager.addSpot(spot: spot)
        print("Dev:",date.description)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        testSpot()
    }


}

