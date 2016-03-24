//
//  MasterTableViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 03/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import Crashlytics
import RealmSwift
import Spring

class MasterTableViewController: UITableViewController {
  
  var demandeArray : Results<Demande>!
  var changementArray : Results<Changement>!
  var incidentArray : Results<Incident>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Realm fetch
    let date = NSDate()
    let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    let today = cal.startOfDayForDate(date)
    let dateNext = NSDate.nextDay(today)
    changementArray = uiRealm.objects(Changement).filter("debut >= %@ AND debut < %@", today,dateNext)
    demandeArray = uiRealm.objects(Demande).filter("heureRealisation >= %@ AND heureRealisation < %@", today,dateNext)
    incidentArray = uiRealm.objects(Incident).filter("dateCreation >= %@ AND dateCreation < %@", today,dateNext)
    /*
    demandeArray = uiRealm.objects(Demande).sorted("heureReception", ascending: false)
    changementArray = uiRealm.objects(Changement).sorted("debut", ascending: false)
    incidentArray = uiRealm.objects(Incident).sorted("dateCreation", ascending: false)
*/
    //FABRIC- Answers
    let button = UIButton(type: UIButtonType.RoundedRect)
    button.setTitle("Trigger Key Metric", forState: UIControlState.Normal)
    button.addTarget(self, action: "anImportantUserAction", forControlEvents: UIControlEvents.TouchUpInside)
    button.sizeToFit()
    button.center = self.view.center;
    view.addSubview(button)
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    self.tableView.tableFooterView = UIView(frame:CGRectZero);
  }
  
  override func viewWillAppear(animated: Bool) {
   let indexPath = NSIndexPath(forRow: 0, inSection: 0)
    
   self.tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .Top)
    self.tableView(self.tableView, didSelectRowAtIndexPath: indexPath)

  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 5
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell : MenuTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MenuTableViewCell
    
    switch indexPath.row {
    case 0:
      let image : UIImage = UIImage(named:"slctIcnHome")!
      cell.contentView.backgroundColor = UIColor.whiteColor()
      cell.menuLogo.image = image
      break
    case 1:
      let image : UIImage = UIImage(named:"unslctIcnDashboard")!
      cell.menuLogo.image = image
      break
    case 2:
      let image : UIImage = UIImage(named:"unslctIcnChangements")!
      cell.menuLogo.image = image
      break
    case 3:
      let image : UIImage = UIImage(named:"unslctIcnIncidents")!
      cell.menuLogo.image = image
      break
    case 4:
      let image : UIImage = UIImage(named:"unslctIcnDemande")!
      cell.menuLogo.image = image
      break
    default:
      break
      
    }
    
    // Configure the cell...
    
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    let cell : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! MenuTableViewCell
    
    switch indexPath.row {
    case 0:
      let image : UIImage = UIImage(named:"slctIcnHome")!
      cell.menuLogo.image = image
      let indexPath1 = NSIndexPath(forRow: 1, inSection: 0)
      let cell1 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath1) as! MenuTableViewCell
      let image1 : UIImage = UIImage(named:"unslctIcnDashboard")!
      cell1.menuLogo.image = image1
      let indexPath2 = NSIndexPath(forRow: 4, inSection: 0)
      let cell2 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath2) as! MenuTableViewCell
      let image2 : UIImage = UIImage(named:"unslctIcnDemande")!
      cell2.menuLogo.image = image2
      let indexPath3 = NSIndexPath(forRow: 2, inSection: 0)
      let cell3 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath3) as! MenuTableViewCell
      let image3 : UIImage = UIImage(named:"unslctIcnChangements")!
      cell3.menuLogo.image = image3
      let indexPath4 = NSIndexPath(forRow: 3, inSection: 0)
      let cell4 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath4) as! MenuTableViewCell
      let image4 : UIImage = UIImage(named:"unslctIcnIncidents")!
      cell4.menuLogo.image = image4
      break

    case 1:
      let image : UIImage = UIImage(named:"slctIcnDashboard")!
      cell.menuLogo.image = image
      let indexPath2 = NSIndexPath(forRow: 4, inSection: 0)
      let cell2 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath2) as! MenuTableViewCell
      let image2 : UIImage = UIImage(named:"unslctIcnDemande")!
      cell2.menuLogo.image = image2
      let indexPath3 = NSIndexPath(forRow: 2, inSection: 0)
      let cell3 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath3) as! MenuTableViewCell
      let image3 : UIImage = UIImage(named:"unslctIcnChangements")!
      cell3.menuLogo.image = image3
      let indexPath4 = NSIndexPath(forRow: 3, inSection: 0)
      let cell4 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath4) as! MenuTableViewCell
      let image4 : UIImage = UIImage(named:"unslctIcnIncidents")!
      cell4.menuLogo.image = image4
      break
      
    case 2:
      let image : UIImage = UIImage(named:"slctIcnChangements")!
      cell.menuLogo.image = image
      let indexPath1 = NSIndexPath(forRow: 1, inSection: 0)
      let cell1 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath1) as! MenuTableViewCell
      let image1 : UIImage = UIImage(named:"unslctIcnDashboard")!
      cell1.menuLogo.image = image1
      let indexPath3 = NSIndexPath(forRow: 4, inSection: 0)
      let cell3 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath3) as! MenuTableViewCell
      let image3 : UIImage = UIImage(named:"unslctIcnDemande")!
      cell3.menuLogo.image = image3
      let indexPath4 = NSIndexPath(forRow: 3, inSection: 0)
      let cell4 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath4) as! MenuTableViewCell
      let image4 : UIImage = UIImage(named:"unslctIcnIncidents")!
      cell4.menuLogo.image = image4
      break
      
    case 3:
      let image : UIImage = UIImage(named:"slctIcnIncidents")!
      cell.menuLogo.image = image
      let indexPath1 = NSIndexPath(forRow: 1, inSection: 0)
      let cell1 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath1) as! MenuTableViewCell
      let image1 : UIImage = UIImage(named:"unslctIcnDashboard")!
      cell1.menuLogo.image = image1
      let indexPath2 = NSIndexPath(forRow: 4, inSection: 0)
      let cell2 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath2) as! MenuTableViewCell
      let image2 : UIImage = UIImage(named:"unslctIcnDemande")!
      cell2.menuLogo.image = image2
      let indexPath4 = NSIndexPath(forRow: 2, inSection: 0)
      let cell4 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath4) as! MenuTableViewCell
      let image4 : UIImage = UIImage(named:"unslctIcnChangements")!
      cell4.menuLogo.image = image4
      break
      
    case 4:
      let image : UIImage = UIImage(named:"slctIcnDemande")!
      cell.menuLogo.image = image
      let indexPath1 = NSIndexPath(forRow: 1, inSection: 0)
      let cell1 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath1) as! MenuTableViewCell
      let image1 : UIImage = UIImage(named:"unslctIcnDashboard")!
      cell1.menuLogo.image = image1
      let indexPath2 = NSIndexPath(forRow: 2, inSection: 0)
      let cell2 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath2) as! MenuTableViewCell
      let image2 : UIImage = UIImage(named:"unslctIcnChangements")!
      cell2.menuLogo.image = image2
      let indexPath3 = NSIndexPath(forRow: 3, inSection: 0)
      let cell3 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath3) as! MenuTableViewCell
      let image3 : UIImage = UIImage(named:"unslctIcnIncidents")!
      cell3.menuLogo.image = image3
      break
   
    default:
      break
      
    }
    
    if indexPath.row == 0 {
      self.performSegueWithIdentifier("showWelcome", sender: self)
    }
    if indexPath.row == 1 {
      self.performSegueWithIdentifier("showDashboard", sender: self)
    }
    if indexPath.row == 2 {
      self.performSegueWithIdentifier("showDetails", sender: self)
    }
    if indexPath.row == 3 {
      self.performSegueWithIdentifier("showDetails", sender: self)
    }
    if indexPath.row == 4 {
      self.performSegueWithIdentifier("showDetails", sender: self)
    }
    
  }

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    if segue.identifier == "showDetails" {
      
      let controller = (segue.destinationViewController
        as! UINavigationController).topViewController
        as! DetailViewController
      controller.demandes = demandeArray
      controller.changements = changementArray
      controller.incidents = incidentArray
      
      let indexPath = self.tableView.indexPathForSelectedRow
      
      switch indexPath!.row {
      case 2 :
        controller.selectedSegue = "changements"
        controller.delegate = self
        break
        
      case 3 :
        controller.selectedSegue = "incidents"
        controller.delegate = self
        break
        
      case 4:
        controller.selectedSegue = "demandes"
        controller.delegate = self
        break
        
      default:
        break
        
        
      }
    }
    
    if segue.identifier == "showDashboard" {
      
      let controller = (segue.destinationViewController
        as! UINavigationController).topViewController
        as! DashboardViewController
      controller.delegate = self
    }
    
    if segue.identifier == "showWelcome" {
      
      let controller = (segue.destinationViewController
        as! UINavigationController).topViewController
        as! WelcomeViewController
      controller.delegate = self

    }
    
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  //MARK : Crashlytics
  func anImportantUserAction(){
    // TODO: Move this method and customize the name and parameters to track your key metrics
    //       Use your own string attributes to track common values over time
    Answers.logCustomEventWithName("Menu Selected", customAttributes: ["Menu":"incidents", "Selected":350])
    
  }
  
}

//Dashboard extension protocol
extension MasterTableViewController: ActionMenuDelegate {
  
  func didSelectAction(rowIndex : Int) {
    // do stuff like updating the UI
    let indexPath = NSIndexPath(forRow: rowIndex, inSection: 0)
    
    self.tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .Top)
    self.tableView(self.tableView, didSelectRowAtIndexPath: indexPath)
  }
}

