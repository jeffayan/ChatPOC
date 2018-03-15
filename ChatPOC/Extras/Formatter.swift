//
//  Formatter.swift
//  User
//
//  Created by CSS on 02/02/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import Foundation

class Formatter {
    
    static let shared = Formatter()
    
    private var dateFormatter : DateFormatter?
    
    private var numberFormatter : NumberFormatter?
    
    
    // Initializing the Date formatter for the First Time
    
    private func initializeDateFormatter(){
        
        if self.dateFormatter == nil {
            dateFormatter = DateFormatter()
            dateFormatter?.locale = Locale.current
        }
        
    }
    
    //MARK:- Getting String for Date with required format
    
    func getString(from date : Date?, format : String)->String?{
        
        initializeDateFormatter()
        
        dateFormatter?.dateFormat = format
        return date == nil ? nil : dateFormatter?.string(from: date!)
        
    }
    
    //MARK:- Getting Date from String Format
    
    func getDate(from string : String?, format : String)->Date?{
        
        initializeDateFormatter()
        
        dateFormatter?.dateFormat = format
        
        return string == nil ? nil : dateFormatter?.date(from: string!)
    }
    
   
    //MARK:- Initilizing Number Formatter
    
    private func initializeNumberFormatter(){
        
        if numberFormatter == nil {
            self.numberFormatter = NumberFormatter()
        }
        
    }
    
    // MARK:- Limit number to required Decimal Values
    
    func limit(string number : String?, maximumDecimal limit : Int)->String?{
        
        initializeNumberFormatter()
        guard let float = Float(number ?? .Empty) else {
            return nil

        }
        numberFormatter?.maximumFractionDigits = limit
        return numberFormatter?.string(for: NSNumber(value: float))
        
    }
    
    //MARK:- Remove Decimal values from Number
    
    func removeDecimal(from number : Double)->Int?{
        
        initializeNumberFormatter()
        
        numberFormatter?.numberStyle = .none
        
        return numberFormatter?.number(from: "\(round(number))") as? Int
        
    }
    
    
    
}
