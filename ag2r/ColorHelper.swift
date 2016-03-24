//
//  ColorHelper.swift
//  ag2r
//
//  Created by Ayoub El barji on 15/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

//import Cocoa
import Foundation
import UIKit

class ColorHelper{
  
  // MARK: - Helper
  func HexToRGB(hex: UInt) -> UIColor {
    return UIColor(
      red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(hex & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
  //MARK: Color Templates
  func changementNuanceColors () -> [UIColor]
  {
    return [
      UIColor(red: 0.0/255, green: 112.0/255, blue: 192.0/255, alpha: 1.0), //Critique
      UIColor(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0), // Importante
      UIColor(red: 110.0/255, green: 200.0/255, blue: 255.0/255, alpha: 1.0), //Moyenne
      UIColor(red: 171.0/255, green: 219.0/255, blue: 255.0/255, alpha: 1.0) // Faible
      
    ]
  }
  
  func incidentNuanceColors () -> [UIColor]
  {
    return [
      UIColor(red: 235.0/255, green: 116.0/255, blue: 40.0/255, alpha: 1.0),//Critique
      UIColor(red: 246.0/255, green: 168.0/255, blue: 0.0/255, alpha: 1.0), //Importante
      UIColor(red: 255.0/255, green: 210.0/255, blue: 100.0/255, alpha: 1.0), //Moyenne
      UIColor(red: 255.0/255, green: 237.0/255, blue: 151.0/255, alpha: 1.0)//Faible
      
    ]
  }

}
