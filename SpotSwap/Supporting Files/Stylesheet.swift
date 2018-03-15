//
//  Supporting Files.swift
//  FlashcardHW
//
//  Created by Masai Young on 2/12/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import UIKit

enum Stylesheet {
    
    enum Colors {
        static let BlueMain = UIColor(hex: "#3393CD")
        static let OrangeMain = UIColor(hex: "#F5A623")
        static let GrayMain = UIColor(hex: "#465362")
        static let PinkMain = UIColor(hex: "#EF767A")
        static let White = UIColor.white
        // Colors borrowed from Tweetbot's dark color scheme
    }
    
    enum Fonts {
        static let Bold = "HelveticaNeue-Bold"
        static let Thin = "HelveticaNeue-Thin"
        static let Light = "HelveticaNeue-Light"
        static let Regular = "Helvetica Neue"
    }
    
    enum Contexts {
        enum Global {
            //            static let StatusBarStyle = UIStatusBarStyle.LightContent
            static let BackgroundColor = Colors.White
            
        }
        
        enum NavigationController {
            static let BarTintColor = Colors.White
            static let BarTextColor = Colors.White
            static let BarColor = Colors.OrangeMain
        }
        
        enum TabBarController {
            //default color of the icons on the buttons
        }
        
    }
    
}

