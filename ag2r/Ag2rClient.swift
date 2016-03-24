//
//  Ag2rClient.swift
//  ag2r
//
//  Created by Ayoub El barji on 04/01/2016.
//  Copyright © 2016 Groupehn. All rights reserved.
//
import Foundation
import AlamofireObjectMapper
import Alamofire
import RealmSwift
import PKHUD

class Ag2rClient {
    
    //MARK: - LifeCycle
    class func getChangements(){
        //
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        Alamofire.request(.GET, GlobalConstants.Api.Ag2rMock_Url_Changements).responseArray { (response: Response<[Changement], NSError>) in
            
            let changementArray = response.result.value
            print(changementArray?.toJSONString())
            if let changementArray = changementArray {
                PKHUD.sharedHUD.hide(afterDelay: 2.0)
                try! uiRealm.write {
                    for changement in changementArray {
                        print(changement.id_changement)
                        print(changement.resume)
                        uiRealm.add(changement, update: true)
                    }
                }
            }
            
        }

        }
    
    class func getIncidents(){
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        Alamofire.request(.GET, GlobalConstants.Api.Ag2rMock_Url_Incidents).responseArray { (response: Response<[Incident], NSError>) in
            
            let incidentArray = response.result.value
             print(incidentArray?.toJSONString())
            if let incidentArray = incidentArray {
                PKHUD.sharedHUD.hide(afterDelay: 2.0)
                try! uiRealm.write {
                for incident in incidentArray {
                    print(incident.resume)
                    print(incident.dateModification)
                    print(incident.etat)
                    uiRealm.add(incident, update: true)
                }
                }
            }
        }
    }
    
    class func getDemandes(){
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        Alamofire.request(.GET, GlobalConstants.Api.Ag2rMock_Url_Demandes).responseArray { (response: Response<[Demande], NSError>) in
            
            let demandeArray = response.result.value
            
            if let demandeArray = demandeArray {
                PKHUD.sharedHUD.hide(afterDelay: 2.0)
                try! uiRealm.write {
                for demande in demandeArray {
                    print(demande.type)
                    print(demande.nom)
                    print(demande.des)
                    print(demande.criticite)
                    uiRealm.add(demande, update: true)
                }
                }
            }
            
        }
    }

}
