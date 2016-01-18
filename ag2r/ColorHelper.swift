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

class ColorHelper: NSObject {

    // MARK: - Helper
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
