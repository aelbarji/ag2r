//
//  ContainerViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 15/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import Foundation
import Calendar_iOS
import RealmSwift

class ContainerViewController: UIViewController {
  
  var selectedSegue : String!
  var demandeViewController : DemandesViewController!
  var incidentViewController : IncidentsViewController!
  var changementViewController : ChangementsViewController!
  
  var demandes : Results<Demande>!
  var changements : Results<Changement>!
  var incidents : Results<Incident>!
  var delegate : ActionMenuDelegate?
  
 // var tableChangementsViewController : TableChangementsViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.performSegueWithIdentifier(self.selectedSegue, sender: self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
 
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if segue.identifier == "demandes"{
      self.demandeViewController = segue.destinationViewController as? DemandesViewController
      self.demandeViewController.demandeArray = self.demandes
      self.demandeViewController.delegate = self.delegate
    }
    
    if segue.identifier == "demandes"{
      self.displayContentController(self.demandeViewController!)
    }
    
    if segue.identifier == "incidents"{
      self.incidentViewController = segue.destinationViewController as? IncidentsViewController
      self.incidentViewController.incidentArray = self.incidents
      self.incidentViewController.delegate = self.delegate
    }
    
    if segue.identifier == "incidents"{
      self.displayContentController(self.incidentViewController!)
    }
    
    if segue.identifier == "changements"{
      self.changementViewController = segue.destinationViewController as? ChangementsViewController
      self.changementViewController.changementArray = self.changements
      self.changementViewController.delegate = self.delegate
     // self.tableChangementsViewController = segue.destinationViewController as? TableChangementsViewController
    }
    
    if segue.identifier == "changements"{
      self.displayContentController(self.changementViewController!)
     // self.displayContentController(self.tableChangementsViewController!)
    }

    
  }
  
  func displayContentController(content: UIViewController) {
    self.addChildViewController(content)
    
    content.view.frame = self.view.frame
    
    self.view.addSubview(content.view)
    
    content.didMoveToParentViewController(self)
    
  }
  
}
