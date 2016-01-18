//
//  demande.swift
//  ag2r
//
//  Created by Ayoub El barji on 04/01/2016.
//  Copyright © 2016 Groupehn. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Demande: Object{
    
    dynamic var idDemande = ""
    dynamic var type = ""
    dynamic var nom = ""
    dynamic var criticite = ""
    dynamic var etat = ""
    dynamic var des = ""
    dynamic var environnement = ""
    dynamic var heureReception = NSDate()
    dynamic var heureRealisation = NSDate()
    dynamic var emetteur = ""
    dynamic var numOBS = ""
    
    override static func primaryKey() -> String? {
        return "idDemande"
    }
    // initializer mapping(map: Map)
    required convenience init?(_ map: Map) {
        self.init()
        mapping(map)
    }

}


// MARK: - ObjectMapper
extension Demande : Mappable {
    
    // Mappable
    func mapping(map: Map) {
        idDemande  <- map["id_demande"]
        type    <- map["type"]
        nom     <- map["nom"]
        criticite     <- map ["criticite"]
        etat         <- map["etat"]
        des      <- map["description"]
        environnement       <- map["environnement"]
        heureReception  <- (map["heure_reception"], DemandeDateTransform())
        heureRealisation  <- (map["heure_realisation"], DemandeDateTransform())
        emetteur     <- map["nom_emetteur"]
        numOBS    <- map["numero_obs"]
    }

}

//MARK: - DateTransform
class DemandeDateTransform : DateTransform {
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

