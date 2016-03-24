//
//  changement.swift
//  ag2r
//
//  Created by Ayoub El barji on 04/01/2016.
//  Copyright © 2016 Groupehn. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Changement: Object{
    
    dynamic var id_changement = ""
    dynamic var resume = ""
    dynamic var priorite = ""
    dynamic var etat = ""
    dynamic var debut = NSDate()
    dynamic var fin = NSDate()
    dynamic var demandeur = ""
    dynamic var valideur = ""
    
    override static func primaryKey() -> String? {
        return "id_changement"
    }
    // initializer mapping(map: Map)
    required convenience init?(_ map: Map) {
        self.init()
        mapping(map)
    }
    
}

// MARK: - ObjectMapper
extension Changement : Mappable {
    
    // Mappable
    func mapping(map: Map) {
        id_changement    <- map["id_changement"]
        resume         <- map["resume"]
        priorite      <- map["priorite"]
        etat       <- map["etat"]
        debut  <- (map["debut"], ChangementDateTransform())
        fin  <- (map["fin"], ChangementDateTransform())
        demandeur     <- map["demandeur"]
        valideur    <- map["valideur"]
    }
}

//MARK: - DateTransform
class ChangementDateTransform : DateTransform {
    override func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let dateStr = value as? String {
            return NSDate.dateWithString(
                dateStr,
                format: "yyyy-MM-dd HH:mm:ss")
        }
        return nil
    }
}
