//
//  Ag2rDateTransform.swift
//  ag2r
//
//  Created by Ayoub El barji on 07/01/2016.
//  Copyright © 2016 Groupehn. All rights reserved.
//

import Foundation

extension NSDate {
    public static func dateWithString(dateStr : String? , format : String, locale : NSLocale) ->NSDate? {
        if let uwDateStr = dateStr {
            let df : NSDateFormatter = NSDateFormatter()
            df.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            df.timeZone = NSTimeZone.defaultTimeZone()
            df.dateFormat = format
            return df.dateFromString(uwDateStr)
        }
        
        return nil
    }
}