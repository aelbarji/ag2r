//
//  WelcomeViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 17/02/2016.
//  Copyright © 2016 Groupehn. All rights reserved.
//

import UIKit
import RealmSwift


class WelcomeViewController: UIViewController {

  weak var delegate: ActionMenuDelegate?
  
  @IBOutlet var tadayLbl: UILabel!
  @IBOutlet var refreshButton: UIButton!
  @IBOutlet var lblNbrDemandes: UILabel!
  @IBOutlet var lblNbrChangements: UILabel!
  @IBOutlet var lblNbrIncidents: UILabel!
  @IBOutlet var changementsView: UIView!
  @IBOutlet var demandesView: UIView!
  @IBOutlet var incidentsView: UIView!
  
  var changementArray : Results<Changement>!
  var incidentArray : Results<Incident>!
  var demandeArray : Results<Demande>!
  
  var selectedSegue : String!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let date = NSDate()
      let formatter = NSDateFormatter()
      formatter.dateStyle = .MediumStyle
      self.tadayLbl.text = formatter.stringFromDate(date)
       // Do any additional setup after loading the view.
      self.demandesView.layer.cornerRadius = 5.0
      self.incidentsView.layer.cornerRadius = 5.0
      self.changementsView.layer.cornerRadius = 5.0
      let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
      let today = cal.startOfDayForDate(date)
      
      let dateNext = NSDate.nextDay(today)
      
      changementArray = uiRealm.objects(Changement).filter("debut >= %@ AND debut < %@", today,dateNext)
      incidentArray = uiRealm.objects(Incident).filter("dateCreation >= %@ AND dateCreation < %@", today,dateNext)
      demandeArray = uiRealm.objects(Demande).filter("heureRealisation >= %@ AND heureRealisation < %@", today,dateNext)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    self.lblNbrDemandes.text = String(demandeArray.count)
    self.lblNbrChangements.text = String(changementArray.count)
    self.lblNbrIncidents.text = String(incidentArray.count)
    
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func demandesTapped() {
    delegate?.didSelectAction(4)
  }
  
  @IBAction func changementsTapped() {
     delegate?.didSelectAction(2)
  }
  
  @IBAction func IncidentsTapped() {
     delegate?.didSelectAction(3)
  }
  
  @IBAction func refresh() {
    
    self.refreshButton.rotate360Degrees()
    
    if Reachability.isConnectedToNetwork() == true {
      
      Ag2rClient.getChangements()
      Ag2rClient.getDemandes()
      Ag2rClient.getIncidents()
      
      let delayInSeconds = 2.0
      let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC))) // 1
      dispatch_after(popTime, dispatch_get_main_queue()) { // 2
        self.delegate?.didSelectAction(0)
      }
    }    
  }


}

extension UIView {
  func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotateAnimation.fromValue = 0.0
    rotateAnimation.toValue = CGFloat(M_PI * 2.0)
    rotateAnimation.duration = duration
    
    if let delegate: AnyObject = completionDelegate {
      rotateAnimation.delegate = delegate
    }
    self.layer.addAnimation(rotateAnimation, forKey: nil)
  }
}