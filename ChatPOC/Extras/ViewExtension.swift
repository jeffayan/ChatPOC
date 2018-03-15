//
//  ViewExtension.swift
//  User
//
//  Created by CSS on 17/01/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func dismissKeyBoardonTap(){
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.endEditingForce)))
        
    }
    
   @IBAction func endEditingForce(){
        
        self.endEditing(true)
        
    }
    
    
    // Hide and show in Dispatch Main thread
    
    func isHideInMainThread(_ isHide : Bool){
        
        DispatchQueue.main.async {
           
            if isHide {
                UIView.animate(withDuration: 0.1, animations: {
                     self.isHidden = isHide
                })
            } else {
                 self.isHidden = isHide
            }
            
        }
        
    }
    
    // Set Tint color
    
    @IBInspectable
    var tintColorId : Int {
        
        get {
           return self.tintColorId
        }
        set(newValue){
            self.tintColor = {
                
                if let color = Color.valueFor(id: newValue){
                    return color
                } else {
                    return tintColor
                }
                
            }()
        }
        
    }
    
    
   //Set background color
    
    @IBInspectable
    var backgroundColorId : Int {
        
        get {
            return self.backgroundColorId
        }
        set(newValue){
            self.backgroundColor = {
                
                if let color = Color.valueFor(id: newValue){
                    return color
                } else {
                    return backgroundColor
                }
                
            }()
        }
        
    }
    
    //Setting Corner Radius
    
    @IBInspectable
    var cornerRadius : CGFloat {
        
        get{
          return self.layer.cornerRadius
        }
        
        set(newValue) {
            self.layer.cornerRadius = newValue
        }
        
    }
    
    
    //MARK:- Setting bottom Line
    
    @IBInspectable
    var borderLineWidth : CGFloat {
        get {
            return self.layer.borderWidth
        }
        set(newValue) {
            self.layer.borderWidth = newValue
        }
    }
    
    
    //MARK:- Setting border color
    
    @IBInspectable
    var borderColor : UIColor {
        
        get {
            
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set(newValue) {
            self.layer.borderColor = borderColor.cgColor
        }
        
    }
    
    
    //MARK:- Shadow Offset
    
    @IBInspectable
    var offsetShadow : CGSize {
        
        get {
           return self.layer.shadowOffset
        }
        set(newValue) {
            self.layer.shadowOffset = newValue
        }
        
        
    }
    
    
    //MARK:- Shadow Opacity
    @IBInspectable
    var opacityShadow : Float {
        
        get{
            return self.layer.shadowOpacity
        }
        set(newValue) {
            self.layer.shadowOpacity = newValue
        }
        
    }
    
    //MARK:- Shadow Color
    @IBInspectable
    var colorShadow : UIColor? {
        
        get{
           return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set(newValue) {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    //MARK:- Shadow Radius
    @IBInspectable
    var radiusShadow : CGFloat {
        get {
             return self.layer.shadowRadius
        }
        set(newValue) {
            
           self.layer.shadowRadius = newValue
        }
    }
    
    //MARK:- Mask To Bounds
    
    @IBInspectable
    var maskToBounds : Bool {
        get {
            return self.layer.masksToBounds
        }
        set(newValue) {
            
            self.layer.masksToBounds = newValue
        }
    }
    
    
    //MARK:- Add Shadow with bezier path
    
    func addShadow(color : UIColor = .gray, opacity : Float = 0.5, offset : CGSize = CGSize(width: 0.5, height: 0.5), radius : CGFloat = 0.5, rasterize : Bool = true, maskToBounds : Bool = false){
        
        layer.masksToBounds = maskToBounds
        self.custom(layer: self.layer, opacity: opacity, offset: offset, color: color, radius: radius)
      //layer.shadowPath = UIBezierPath(rect: self.frame).cgPath
        layer.shouldRasterize = rasterize
        
    }
    
    //MARK:- Add shadow by beizer
    
    func addShadowBeizer(){
        
            
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.bounds.width/2).cgPath
            shadowLayer.fillColor = UIColor.blue.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 4
            
            self.layer.insertSublayer(shadowLayer, at: 0)
      
        
    }
    
    
    private func custom(layer customLayer : CALayer, opacity : Float, offset : CGSize, color : UIColor, radius : CGFloat){
        
        customLayer.shadowColor = color.cgColor
        customLayer.shadowOpacity = opacity
        customLayer.shadowOffset = offset
        customLayer.shadowRadius = radius
        
        
    }
    
    //MARK:- Make View Round
    
    func makeRoundedCorner(){
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width/2
        
    }
    
    
}
