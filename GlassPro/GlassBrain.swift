//
//  GlassBrain.swift
//  GlassPro
//
//  Created by wade chen on 9/7/20.
//  Copyright © 2020 Chris. All rights reserved.
//

import Foundation


struct GlassBrain {
    
    var height = 0.0
    var width = 0.0
    var radius = 0.0
    var area = 0.0
    
    var glassTypeIndex = 0
    var glassThicknessIndex = 0
    
    //Used to load uipickerview
    var glassTypes : [String] = ["Clear Float","Low Iron"]
    var glassThickness : [String] = ["4","6","10"]
    
    var cutToSizeFlag = false
    var toughenFlag = false
    var slumpFlag = false
    
    var quoteTotalPrice = 0.0
    
    var glass = Glass()
    
    var glassArray = [
        Glass(type: "Clear Float", thickness: "4", cutToSizePrice: 19.0, toughenPrice: 31.5),
        Glass(type: "Clear Float", thickness: "6", cutToSizePrice: 28.0, toughenPrice: 40),
        Glass(type: "Clear Float", thickness: "10", cutToSizePrice: 58, toughenPrice: 95),
        Glass(type: "Low Iron", thickness: "4", cutToSizePrice: 68.0, toughenPrice: 85),
        Glass(type: "Low Iron", thickness: "6", cutToSizePrice: 75.0, toughenPrice: 94.0),
        Glass(type: "Low Iron", thickness: "10", cutToSizePrice: 115.0, toughenPrice: 156)
    ]
    
    
    
    //Calculates the glass price using the area(m^2) and glass price
    mutating func calculatePrice(_ glassType: String, _ glassThickness:String) {
        
        //Determines the glass type and thickness and retreives the appropriate glass object
        for iGlass in glassArray {
            if( (iGlass.type == glassType) && (iGlass.thickness == glassThickness)) {
                glass = iGlass
            }
        }
        
        //
        quoteTotalPrice =  getCutToSizePrice(cutToSizeFlag) + getToughenPrice(toughenFlag)
        
        
    }
    
    func getCutToSizePrice(_ flag:Bool) -> Double {
        
        if flag {
            return glass.cutToSizePrice * area
        } else {
            return 0.0
        }
        
    }
    
    func getToughenPrice(_ flag: Bool) -> Double {
        
        if flag {
            return glass.toughenPrice * area
        } else {
            return 0.0
        }
        
    }
    
    func getCutToSize() -> String {
        if cutToSizeFlag {
            return "Cut to size"
        } else {
            return ""
        }
    }
    
    func getToughen() -> String {
        if toughenFlag {
            return "Toughen"
        } else {
            return ""
        }
    }
    
    func getSlump() -> String {
        if slumpFlag {
            return "Slump"
        } else {
            return ""
        }
    }
    
    mutating func calculateArea() -> Double {
        
        if( (height != 0.0) && (width != 0.0) ) {
            area = (height * width)/(1000000)
        } else if(radius != 0.0) {
            area = (Double.pi * pow(radius, 2))/(1000000)
        } else {
            area = 0.0
        }
        
        return area
    }

}
