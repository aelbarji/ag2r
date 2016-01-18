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
    dynamic var idDemande = ""
    dynamic var typeDemande = ""
    dynamic var etat = ""
    dynamic var priorite = ""
    dynamic var resume = ""
    dynamic var groupeAttribution = ""
    dynamic var dateModification = NSDate()
    dynamic var intervenant = ""
    dynamic var typeAssociation = ""
    dynamic var vip = ""
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
        idDemande     <- map["id_demande"]
        typeDemande     <- map ["type_demande"]
        etat         <- map["etat"]
        priorite   <- map["priorite"]
        resume      <- map["resume"]
        groupeAttribution       <- map["groupe_attribution"]
        dateModification  <- (map["date_modification"], IncidentDateTransform())
        intervenant     <- map["intervenant"]
        typeAssociation    <- map["type_association"]
        vip     <- map["vip"]
        nbRelance   <- map["nb_relance"]
    }
}

//MARK: - DateTransform
class IncidentDateTransform : DateTransform {
    override func transformFromJSON(value: AnyObject?) -> NSDate? {
        if let dateStr = value as? String {
            return NSDate.dateWithString(
                dateStr,
                format: "dd/MM/yy HH:mm:ss" ,
                locale : NSLocale(localeIdentifier: "en_US"))
        }
        return nil
    }
}

