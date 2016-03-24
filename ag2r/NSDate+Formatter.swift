//
//  Ag2rDateTransform.swift
//  ag2r
//
//  Created by Ayoub El barji on 07/01/2016.
//  Copyright © 2016 Groupehn. All rights reserved.
//

import Foundation

extension NSDate {
  
  public static func dateWithString(dateStr : String? , format : String) ->NSDate? {
    if let uwDateStr = dateStr {
      let df : NSDateFormatter = NSDateFormatter()
      df.calendar = NSCalendar(calendarIdentifier: "NSCalendarIdentifierISO8601")
      df.locale = NSLocale(localeIdentifier: "en-FR")
      df.timeZone = NSTimeZone.defaultTimeZone()
      df.dateFormat = format
      return df.dateFromString(uwDateStr)
    }
    
    
    return nil
  }
  
  public static func printDate(date:NSDate)->String{
    
    print("Date before trasform : \(date)")
    let mydateFormatter = NSDateFormatter()
    mydateFormatter.calendar = NSCalendar(calendarIdentifier: "NSCalendarIdentifierISO8601")
    mydateFormatter.timeZone = NSTimeZone.defaultTimeZone()
    mydateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    mydateFormatter.locale = NSLocale(localeIdentifier: "en-FR")
    let dateString = mydateFormatter.stringFromDate(date)
    print("Date after trasform : \(dateString)")
    return dateString
  }
  
  public static func nextDay(date:NSDate)->NSDate!{
    
    let daysToAdd : NSTimeInterval = 1.0
    let nextDay = date.dateByAddingTimeInterval(60*60*24*daysToAdd)
    print("Next Day is : \(nextDay)")
    return nextDay
  }
  
}