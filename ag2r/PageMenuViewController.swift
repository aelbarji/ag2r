//
//  PageMenuViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 21/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import Foundation
import UIKit
import PageMenu

class PageMenuViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?
    var selectedSegue : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Example:
        
        switch selectedSegue{
        case "changements" :
            let mainChangementsStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let changementsTousViewController = mainChangementsStoryboard.instantiateViewControllerWithIdentifier("TousChangements") as! ChangementsTousPageMenu
            changementsTousViewController.title = "Tous"
            
            let firstChangementsStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let changementsFirstViewController = firstChangementsStoryboard.instantiateViewControllerWithIdentifier("FirstChangements") as! ChangementsFirstPageMenu
            changementsFirstViewController.title = "Techniques"
            
            
            let secondChangementsStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let changementsSecondViewController = secondChangementsStoryboard.instantiateViewControllerWithIdentifier("SecondChangements") as! ChangementsSecondPageMenu
            changementsSecondViewController.title = "Applicatifs"
            
            controllerArray.append(changementsTousViewController)
            controllerArray.append(changementsFirstViewController)
            controllerArray.append(changementsSecondViewController)
            
            break
            
        case "incidents" :
            let mainDemandesStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let incidentsTousViewController = mainDemandesStoryboard.instantiateViewControllerWithIdentifier("TousIncidents") as! IncidentsTousPageMenu
            incidentsTousViewController.title = "Tous"
            
            let firstIncidentsStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let incidentsFirstViewController = firstIncidentsStoryboard.instantiateViewControllerWithIdentifier("FirstIncidents") as! IncidentsFirstPageMenu
            incidentsFirstViewController.title = "États"
            
            
            let secondIncidentsStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let incidentsSecondViewController = secondIncidentsStoryboard.instantiateViewControllerWithIdentifier("SecondIncidents") as! IncidentsSecondPageMenu
            incidentsSecondViewController.title = "Priorités"
            
            controllerArray.append(incidentsTousViewController)
            controllerArray.append(incidentsFirstViewController)
            controllerArray.append(incidentsSecondViewController)
            break
            
        case "demandes":
            let mainDemandesStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let demandesTousViewController = mainDemandesStoryboard.instantiateViewControllerWithIdentifier("TousDemandes") as! DemandesTousPageMenu
            demandesTousViewController.title = "Tous"
            
            let firstDemandesStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let demandesFirstViewController = firstDemandesStoryboard.instantiateViewControllerWithIdentifier("FirstDemandes") as! DemandesFirstPageMenu
            demandesFirstViewController.title = "MAILS"
            
            
            let secondDemandesStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let demandesSecondViewController = secondDemandesStoryboard.instantiateViewControllerWithIdentifier("SecondDemandes") as! DemandeSecondPageMenu
            demandesSecondViewController.title = "OBS"
            
            controllerArray.append(demandesTousViewController)
            controllerArray.append(demandesFirstViewController)
            controllerArray.append(demandesSecondViewController)
            break
            
        default:
            break
            
        }
        
        
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        let parameters: [CAPSPageMenuOption] = [
//            .MenuItemSeparatorWidth(10.0),
//            .MenuItemSeparatorPercentageHeight(0.1),
            .SelectionIndicatorColor (UIColor.init(red: 52.0/255, green: 152.0/255, blue: 219.0/255, alpha: 1.0)),
            .SelectionIndicatorHeight(5.0),
            .ScrollMenuBackgroundColor (UIColor.clearColor()),
            .SelectedMenuItemLabelColor (UIColor.blackColor()),
            .UnselectedMenuItemLabelColor (UIColor.init(red: 225.0/255, green: 230.0/255, blue: 231.0/255, alpha: 1.0)),
            .MenuMargin(0.0),
//            .MenuItemWidthBasedOnTitleTextWidth(true)

        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        
        self.view.addSubview(pageMenu!.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
