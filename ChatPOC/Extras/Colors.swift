//
//  Colors.swift
//  User
//
//  Created by imac on 12/22/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import UIKit

enum Color : Int {
    
    case primary = 1
    case secondary = 2
    case lightBlue = 3
    case brightBlue = 4
    
    
    static func valueFor(id : Int)->UIColor?{
        
        switch id {
        case self.primary.rawValue:
            return .primary
        
        case self.secondary.rawValue:
            return .secondary
            
        case self.lightBlue.rawValue:
            return .lightBlue
        
        case self.brightBlue.rawValue:
            return .brightBlue
            
        default:
            return nil
        }
        
        
    }
    
    
}

extension UIColor {
    
    // Primary Color
    static var primary : UIColor {
        return UIColor(red: 35/255, green: 118/255, blue: 188/255, alpha: 1)
    }
    
    // Secondary Color
    static var secondary : UIColor {
        return UIColor(red: 248/255, green: 249/255, blue: 252/255, alpha: 1)
    }
    
    // Secondary Color
    static var lightBlue : UIColor {
        return UIColor(red: 63/255, green: 210/255, blue: 255/255, alpha: 1)
    }
    
    //Gradient Start Color
    
    static var startGradient : UIColor {
        return UIColor(red: 83/255, green: 173/255, blue: 46/255, alpha: 1)
    }
    
    //Gradient End Color
    
    static var endGradient : UIColor {
        return UIColor(red: 158/255, green: 178/255, blue: 45/255, alpha: 1)
    }
    
    // Blue Color
    
    static var brightBlue : UIColor {
        return UIColor(red: 40/255, green: 25/255, blue: 255/255, alpha: 1)
    }
    
    
}
