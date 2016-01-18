//
//  MasterTableViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 03/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import Crashlytics


class MasterTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // API CALLS
        Ag2rClient.getChangements()
        Ag2rClient.getDemandes()
        Ag2rClient.getIncidents()
        
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
        return 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : MenuTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MenuTableViewCell
        
        switch indexPath.row {
        case 0: 
            let image : UIImage = UIImage(named:"changements_logo_selected")!
            cell.menuLogo.image = image
            break
        case 1:
            let image : UIImage = UIImage(named:"incidents_logo")!
            cell.menuLogo.image = image
            break
        case 2:
            let image : UIImage = UIImage(named:"demandes_logo")!
            cell.menuLogo.image = image
            break
        default:
            break
            
        }

        // Configure the cell...
        let customColorView = UIView()
        let uiColorFromRGG: ColorHelper = ColorHelper()
        customColorView.backgroundColor = uiColorFromRGG.UIColorFromRGB(0x00B9E4)
        cell.selectedBackgroundView =  customColorView;
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    /*    let cell : MenuTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MenuTableViewCell
  
        */
        let cell : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! MenuTableViewCell
        
        switch indexPath.row {
        case 0:
            let image : UIImage = UIImage(named:"changements_logo_selected")!
            cell.menuLogo.image = image
            let indexPath1 = NSIndexPath(forRow: 1, inSection: 0)
            let cell1 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath1) as! MenuTableViewCell
            let image1 : UIImage = UIImage(named:"incidents_logo")!
            cell1.menuLogo.image = image1
            let indexPath2 = NSIndexPath(forRow: 2, inSection: 0)
            let cell2 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath2) as! MenuTableViewCell
            let image2 : UIImage = UIImage(named:"demandes_logo")!
            cell2.menuLogo.image = image2
            break
            
        case 1:
            let image : UIImage = UIImage(named:"incidents_logo_selected")!
            cell.menuLogo.image = image
            let indexPath1 = NSIndexPath(forRow: 0, inSection: 0)
            let cell1 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath1) as! MenuTableViewCell
            let image1 : UIImage = UIImage(named:"changements_logo")!
            cell1.menuLogo.image = image1
            let indexPath2 = NSIndexPath(forRow: 2, inSection: 0)
            let cell2 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath2) as! MenuTableViewCell
            let image2 : UIImage = UIImage(named:"demandes_logo")!
            cell2.menuLogo.image = image2
            break
            
        case 2:
            let image : UIImage = UIImage(named:"demandes_logo_selected")!
            cell.menuLogo.image = image
            let indexPath1 = NSIndexPath(forRow: 0, inSection: 0)
            let cell1 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath1) as! MenuTableViewCell
            let image1 : UIImage = UIImage(named:"changements_logo")!
            cell1.menuLogo.image = image1
            let indexPath2 = NSIndexPath(forRow: 1, inSection: 0)
            let cell2 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath2) as! MenuTableViewCell
            let image2 : UIImage = UIImage(named:"incidents_logo")!
            cell2.menuLogo.image = image2
            break
            
        default:
            break
            
        }
        
        self.performSegueWithIdentifier("showDetails", sender: self)
    /*
        if indexPath.row == 0 {
            self.performSegueWithIdentifier("changements", sender: self)
        } else if indexPath.row == 1 {
            self.performSegueWithIdentifier("incidents", sender: self)
        } else {
            self.performSegueWithIdentifier("demandes", sender: self)
        }
*/

    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
 
        let currentIndexPath = self.tableView.indexPathForSelectedRow
        let cell : MenuTableViewCell = tableView.cellForRowAtIndexPath(currentIndexPath!) as! MenuTableViewCell
       
        switch currentIndexPath!.row {
        case 0:
            let image : UIImage = UIImage(named:"changements_logo_selected")!
            cell.menuLogo.image = image
            let indexPath1 = NSIndexPath(forRow: 1, inSection: 0)
            let cell1 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath1) as! MenuTableViewCell
            let image1 : UIImage = UIImage(named:"incidents_logo")!
            cell1.menuLogo.image = image1
            let indexPath2 = NSIndexPath(forRow: 2, inSection: 0)
            let cell2 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath2) as! MenuTableViewCell
            let image2 : UIImage = UIImage(named:"demandes_logo")!
            cell2.menuLogo.image = image2

            break
        case 1:
            let image : UIImage = UIImage(named:"incidents_logo_selected")!
            cell.menuLogo.image = image
            let indexPath1 = NSIndexPath(forRow: 0, inSection: 0)
            let cell1 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath1) as! MenuTableViewCell
            let image1 : UIImage = UIImage(named:"changements_logo")!
            cell1.menuLogo.image = image1
            let indexPath2 = NSIndexPath(forRow: 2, inSection: 0)
            let cell2 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath2) as! MenuTableViewCell
            let image2 : UIImage = UIImage(named:"demandes_logo")!
            cell2.menuLogo.image = image2

            break
        case 2:
            let image : UIImage = UIImage(named:"demandes_logo_selected")!
            cell.menuLogo.image = image
            let indexPath1 = NSIndexPath(forRow: 0, inSection: 0)
            let cell1 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath1) as! MenuTableViewCell
            let image1 : UIImage = UIImage(named:"changements_logo")!
            cell1.menuLogo.image = image1
            let indexPath2 = NSIndexPath(forRow: 1, inSection: 0)
            let cell2 : MenuTableViewCell = tableView.cellForRowAtIndexPath(indexPath2) as! MenuTableViewCell
            let image2 : UIImage = UIImage(named:"incidents_logo")!
            cell2.menuLogo.image = image2

            break
        default:
            break
            
        }

    }
    
    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
   // TODO: A Supprimer
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetails" {
            
            let controller = (segue.destinationViewController
                as! UINavigationController).topViewController
                as! DetailViewController
         
            let indexPath = self.tableView.indexPathForSelectedRow
            
            switch indexPath!.row {
            case 0 :
                controller.selectedSegue = "changements"
                break
            case 1:
               controller.selectedSegue = "incidents"
                break
            default:
               controller.selectedSegue = "demandes"
                break
                
                
            }

          //      controller.navigationItem.leftBarButtonItem =
          //          splitViewController?.displayModeButtonItem()
          //      controller.navigationItem.leftItemsSupplementBackButton = true

            
        }
        
        
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK : Crashlytics
    func anImportantUserAction(){
        // TODO: Move this method and customize the name and parameters to track your key metrics
        //       Use your own string attributes to track common values over time
        //       Use your own number attributes to track median value over time
        Answers.logCustomEventWithName("Menu Selected", customAttributes: ["Menu":"incidents", "Selected":350])

    }

}
