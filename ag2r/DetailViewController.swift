//
//  DetailViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 03/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import Calendar_iOS
import RealmSwift

class DetailViewController: UIViewController{
  
  
  var selectedSegue : String!
  var delegate : ActionMenuDelegate?
  var containerViewController : ContainerViewController?
  var demandeViewController : DemandesViewController?
  var changementViewController : ChangementsViewController?
  var incidentViewController : IncidentsViewController?
  var demandes : Results<Demande>!
  var changements : Results<Changement>!
  var incidents : Results<Incident>!
  
  
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var tableauDeBord: UIView!
  @IBOutlet var calendarView: CalendarView!
  @IBOutlet var firstInfoView: UIView!
  @IBOutlet var SecondInfoView: UIView!
  
  //Labels Tableau de bord
  //First View
  @IBOutlet var lblTitleFirstInfo: UILabel!
  @IBOutlet var lblNbrFirst: UILabel!
  @IBOutlet var lblPrioFirst: UILabel!
  @IBOutlet var lblNbrFirstSched: UILabel!
  @IBOutlet var lblNbrFirstPrg: UILabel!
  @IBOutlet var lblNbrFirstClos: UILabel!
  @IBOutlet var lblNbrFirstSchedObs: UILabel!
  @IBOutlet var lblNbrFirstPrgObs: UILabel!
  @IBOutlet var lblNbrFirstClosObs: UILabel!
  //Second View
  @IBOutlet var lblTitleSecondInfo: UILabel!
  @IBOutlet var lblNbrSecond: UILabel!
  @IBOutlet var lblNbrPrio: UILabel!
  @IBOutlet var lblNbrPrioSecond: UILabel!
  @IBOutlet var lblPrioSecond: UILabel!
  @IBOutlet var lblNbrSecondSched: UILabel!
  @IBOutlet var lblNbrSecondPrg: UILabel!
  @IBOutlet var lblNbrSecondClos: UILabel!
  
  @IBOutlet var lblMails: UILabel!
  @IBOutlet var lblObs: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    //self.performSegueWithIdentifier(self.selectedSegue, sender: self)
    //MARK: - CALENDAR
    /* let subView = UIView()
    subView.frame = CGRectMake(self.calendarView.frame.origin.x, self.calendarView.frame.origin.y-40, self.calendarView.frame.width*0.95, self.calendarView.frame.height*0.95)
    let calendarView : CalendarView = CalendarView.init(frame: subView.frame)
    */
    calendarView.calendarDelegate = self
    calendarView.shouldShowHeaders = true
    calendarView.autoresizesSubviews = false
    calendarView.bgColor = UIColor.init(red: 40.0/255, green: 40.0/255, blue: 40.0/255, alpha: 1.0)
    calendarView.fontColor = UIColor.whiteColor()
   // calendarView.setMode(0)
    calendarView.refresh()
    // self.calendarView.addSubview(calendarView)
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    //Views
    self.calendarView.layer.cornerRadius = 5.0
    self.firstInfoView.layer.cornerRadius = 5.0
    self.SecondInfoView.layer.cornerRadius = 5.0
    //Today Date
    let date = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    self.dateLabel.text = formatter.stringFromDate(date)

    
    //LABELS
    switch selectedSegue{
    case "demandes":
      //first view
      self.lblTitleFirstInfo.text = "Changements"
      self.lblTitleFirstInfo.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      self.lblNbrFirst.text = String(changements.count)
      self.lblNbrFirst.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      self.lblPrioFirst.text = "Critique(s)"
      let changPrioArray = changements.filter {
        $0.priorite.rangeOfString("Urgent", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrPrio.text = String(changPrioArray.count)
      self.lblNbrPrio.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      let changEtatAssignArray = changements.filter {
        $0.etat.rangeOfString("Assign", options: .CaseInsensitiveSearch) != nil
      }
      let changEtatInProgArray = changements.filter {
        $0.etat.rangeOfString("WorkInProgress", options: .CaseInsensitiveSearch) != nil
      }
      let changEtatClosedArray = changements.filter {
        $0.etat.rangeOfString("Closed", options: .CaseInsensitiveSearch) != nil
      }

      self.lblNbrFirstSched.text = String(changEtatAssignArray.count)
      self.lblNbrFirstSched.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      self.lblNbrFirstPrg.text = String(changEtatInProgArray.count)
      self.lblNbrFirstPrg.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      self.lblNbrFirstClos.text = String(changEtatClosedArray.count)
      self.lblNbrFirstClos.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      self.lblNbrFirstSchedObs.hidden = true
      self.lblNbrFirstPrgObs.hidden = true
      self.lblNbrFirstClosObs.hidden = true
      self.lblMails.hidden = true
      self.lblObs.hidden = true
      
      // Second View
      self.lblTitleSecondInfo.text = "Incidents"
      self.lblTitleSecondInfo.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      self.lblNbrSecond.text = String(incidents.count)
      self.lblNbrSecond.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      let incidentPrioArray = incidents.filter {
        $0.priorite.rangeOfString("Critique", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrPrioSecond.text = String(incidentPrioArray.count)
      self.lblNbrPrioSecond.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      self.lblPrioSecond.text = "Critique(s)"
      let incEtatAssignArray = incidents.filter {
        $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
      }
      let incEtatInProgArray = incidents.filter {
        $0.etat.rangeOfString("cours", options: .CaseInsensitiveSearch) != nil
      }
      let incEtatClosedArray = incidents.filter {
        $0.etat.rangeOfString("Clos", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrSecondSched.text = String(incEtatAssignArray.count)
      self.lblNbrSecondSched.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      self.lblNbrSecondPrg.text = String(incEtatInProgArray.count)
      self.lblNbrSecondPrg.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      self.lblNbrSecondClos.text = String(incEtatClosedArray.count)
      self.lblNbrSecondClos.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      break
    case "changements":
      //first view
      self.lblTitleFirstInfo.text = "Demandes"
      self.lblTitleFirstInfo.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
      self.lblNbrFirst.text = String(demandes.count)
      self.lblNbrFirst.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
      self.lblPrioFirst.text = "Impératif(s)"
      let demandeCritArray = demandes.filter {
        $0.criticite.rangeOfString("Impératif", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrPrio.text = String(demandeCritArray.count)
      self.lblNbrPrio.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
      let mailArray = demandes.filter {
        $0.type.rangeOfString("mail", options: .CaseInsensitiveSearch) != nil
      }
      let mailInProgArray = mailArray.filter {
        $0.etat.rangeOfString("En cours", options: .CaseInsensitiveSearch) != nil
      }
      let mailScheduledArray = mailArray.filter {
        $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
      }
      let mailClosedArray = mailArray.filter {
        $0.etat.rangeOfString("Ok", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrFirstSched.text = String(mailScheduledArray.count)
      self.lblNbrFirstSched.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
      self.lblNbrFirstPrg.text = String(mailInProgArray.count)
      self.lblNbrFirstPrg.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
      self.lblNbrFirstClos.text = String(mailClosedArray.count)
      self.lblNbrFirstClos.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
      let obsArray = demandes.filter {
        $0.type.rangeOfString("obs", options: .CaseInsensitiveSearch) != nil
      }
      let obsInProgArray = obsArray.filter {
        $0.etat.rangeOfString("En cours", options: .CaseInsensitiveSearch) != nil
      }
      let obsScheduledArray = obsArray.filter {
        $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
      }
      let obsClosedArray = obsArray.filter {
        $0.etat.rangeOfString("Ok", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrFirstSchedObs.text = String(obsScheduledArray.count)
      self.lblNbrFirstPrgObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
      self.lblNbrFirstClosObs.text = String(obsClosedArray.count)
      self.lblNbrFirstSchedObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
      self.lblNbrFirstPrgObs.text = String(obsInProgArray.count)
      self.lblNbrFirstClosObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
      self.lblMails.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
      self.lblMails.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
      self.lblObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
      self.lblObs.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
      // Second View
      self.lblTitleSecondInfo.text = "Incidents"
      self.lblTitleSecondInfo.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      self.lblNbrSecond.text = String(incidents.count)
      self.lblNbrSecond.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      let incidentPrioArray = incidents.filter {
        $0.priorite.rangeOfString("Critique", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrPrioSecond.text = String(incidentPrioArray.count)
      self.lblNbrPrioSecond.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      self.lblPrioSecond.text = "Critique(s)"
      let incEtatAssignArray = incidents.filter {
        $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
      }
      let incEtatInProgArray = incidents.filter {
        $0.etat.rangeOfString("cours", options: .CaseInsensitiveSearch) != nil
      }
      let incEtatClosedArray = incidents.filter {
        $0.etat.rangeOfString("Clos", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrSecondSched.text = String(incEtatAssignArray.count)
      self.lblNbrSecondSched.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      self.lblNbrSecondPrg.text = String(incEtatInProgArray.count)
      self.lblNbrSecondPrg.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      self.lblNbrSecondClos.text = String(incEtatClosedArray.count)
      self.lblNbrSecondClos.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
      break
    case "incidents":
      //first view
      self.lblTitleFirstInfo.text = "Demandes"
      self.lblTitleFirstInfo.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
      self.lblNbrFirst.text = String(demandes.count)
      self.lblNbrFirst.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
      self.lblPrioFirst.text = "Impératif(s)"
      let demandeCritArray = demandes.filter {
        $0.criticite.rangeOfString("Impératif", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrPrio.text = String(demandeCritArray.count)
      self.lblNbrPrio.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
      let mailArray = demandes.filter {
        $0.type.rangeOfString("mail", options: .CaseInsensitiveSearch) != nil
      }
      let mailInProgArray = mailArray.filter {
        $0.etat.rangeOfString("En cours", options: .CaseInsensitiveSearch) != nil
      }
      let mailScheduledArray = mailArray.filter {
        $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
      }
      let mailClosedArray = mailArray.filter {
        $0.etat.rangeOfString("Ok", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrFirstSched.text = String(mailScheduledArray.count)
      self.lblNbrFirstSched.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
      self.lblNbrFirstPrg.text = String(mailInProgArray.count)
      self.lblNbrFirstPrg.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
      self.lblNbrFirstClos.text = String(mailClosedArray.count)
      self.lblNbrFirstClos.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
      let obsArray = demandes.filter {
        $0.type.rangeOfString("obs", options: .CaseInsensitiveSearch) != nil
      }
      let obsInProgArray = obsArray.filter {
        $0.etat.rangeOfString("En cours", options: .CaseInsensitiveSearch) != nil
      }
      let obsScheduledArray = obsArray.filter {
        $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
      }
      let obsClosedArray = obsArray.filter {
        $0.etat.rangeOfString("Ok", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrFirstSchedObs.text = String(obsScheduledArray.count)
      self.lblNbrFirstPrgObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
      self.lblNbrFirstClosObs.text = String(obsClosedArray.count)
      self.lblNbrFirstSchedObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
      self.lblNbrFirstPrgObs.text = String(obsInProgArray.count)
      self.lblNbrFirstClosObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
      self.lblMails.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
      self.lblMails.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
      self.lblObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
      self.lblObs.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
      // Second View
      self.lblTitleSecondInfo.text = "Changements"
      self.lblTitleSecondInfo.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      self.lblNbrSecond.text = String(changements.count)
      self.lblNbrSecond.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      self.lblPrioSecond.text = "Critique(s)"
      let changPrioArray = changements.filter {
        $0.priorite.rangeOfString("Urgent", options: .CaseInsensitiveSearch) != nil
      }
      self.lblNbrPrioSecond.text = String(changPrioArray.count)
      self.lblNbrPrioSecond.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      let changEtatAssignArray = changements.filter {
        $0.etat.rangeOfString("Assign", options: .CaseInsensitiveSearch) != nil
      }
      let changEtatInProgArray = changements.filter {
        $0.etat.rangeOfString("WorkInProgress", options: .CaseInsensitiveSearch) != nil
      }
      let changEtatClosedArray = changements.filter {
        $0.etat.rangeOfString("Closed", options: .CaseInsensitiveSearch) != nil
      }
      
      self.lblNbrSecondSched.text = String(changEtatAssignArray.count)
      self.lblNbrSecondSched.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      self.lblNbrSecondPrg.text = String(changEtatInProgArray.count)
      self.lblNbrSecondPrg.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      self.lblNbrSecondClos.text = String(changEtatClosedArray.count)
      self.lblNbrSecondClos.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
      break
    default:
      break
      
    }
    
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
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
    print("Valeur de selectedSegue : \(self.selectedSegue)")
    
    if let selectedSegueValue = self.selectedSegue {
      if segue.identifier == "embeddedContainer"{
        self.containerViewController = segue.destinationViewController as? ContainerViewController
        
        self.containerViewController!.selectedSegue = selectedSegueValue
        self.containerViewController!.demandes = self.demandes
        self.containerViewController!.changements = self.changements
        self.containerViewController!.incidents = self.incidents
        self.containerViewController!.delegate = self.delegate
        
      }
    }else{
      if segue.identifier == "embeddedContainer"{
      //  self.containerViewController = segue.destinationViewController as? ContainerViewController
      //  self.containerViewController!.selectedSegue = "demandes"
      }
    }
    
  }
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    return true
  }
  
  //MARK: Status Bar Color
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  
  
}


//MARK: - Calendar View Delegate
extension DetailViewController : CalendarViewDelegate{
  
  //required
  func didChangeCalendarDate(date : NSDate){
    print("Calendar date change with date : \(date)")
    //dateFormat
    let dateNext = NSDate.nextDay(date)
    print("Next day : \(dateNext)")
    var dataDict = Dictionary<String, NSDate>()
    dataDict["date"] = date
    dataDict["dateNext"] = dateNext
    NSNotificationCenter.defaultCenter().postNotificationName("reload", object: self, userInfo: dataDict)
  }
  
  //optional
  func didChangeCalendarDate(date : NSDate, withType type:NSInteger, withEvent event: NSInteger){
    
  }
  
  func didDoubleTapCalendar(date : NSDate, withType type : NSInteger){
    
  }
  
}
