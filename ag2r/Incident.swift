//
//  Incidents.swift
//  ag2r
//
//  Created by Ayoub El barji on 05/01/2016.
//  Copyright © 2016 Groupehn. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Incident: Object {

    dynamic var idRequete = ""
    dynamic var etat = ""
    dynamic var priorite = ""
    dynamic var urgence = ""
    dynamic var impact = ""
    dynamic var resume = ""
    dynamic var dateCreation = NSDate()
    dynamic var dateModification = NSDate()
    dynamic var nbRelance = ""
    
    override static func primaryKey() -> String? {
        return "idRequete"
    }
    
    // initializer mapping(map: Map)
    required convenience init?(_ map: Map) {
        self.init()
        mapping(map)
    }
    
}

// MARK: - ObjectMapper
extension Incident : Mappable {
    
    // Mappable
    func mapping(map: Map) {
        idRequete    <- map["id_requete"]
        etat         <- map["etat"]
        priorite   <- map["priorite"]
        urgence         <- map["urgence"]
        impact   <- map["impact"]
        resume      <- map["resume"]
        dateCreation       <- (map["date_creation"], IncidentDateTransform())
        dateModification  <- (map["date_modification"], IncidentDateTransform())
        nbRelance   <- map["nb_relance"]
    }
}

//MARK: - DateTransform
class IncidentDateTransform : DateTransform {
    override func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let dateStr = value as? String {
            return NSDate.dateWithString(
                dateStr,
                format: "yyyy-MM-dd HH:mm:ss")
        }
        return nil
    }
}

