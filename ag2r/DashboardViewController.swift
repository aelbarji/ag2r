//
//  DashboardViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 21/01/2016.
//  Copyright © 2016 Groupehn. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class DashboardViewController: UIViewController {
  
  weak var delegate:ActionMenuDelegate?
  
  @IBOutlet var refreshButton: UIButton!
  var changementArray : Results<Changement>!
  var incidentArray : Results<Incident>!
  var demandeArray : Results<Demande>!
  
  var changEtatInProgArray : [Changement]?
  var changEtatSchedArray : [Changement]?
  var changEtatClosedArray : [Changement]?
  var changEtatNewArray : [Changement]?
  var changEtatResProgArray : [Changement]?
  var changEtatPendArray : [Changement]?
  var changEtatAssignArray : [Changement]?
  
  var incEtatInProgArray : [Incident]?
  var incEtatCanceledArray : [Incident]?
  var incEtatClosedArray : [Incident]?
  var incEtatNewArray : [Incident]?
  var incEtatResArray : [Incident]?
  var incEtatAssignArray : [Incident]?
  
  var mailArray : [Demande]?
  var obsArray : [Demande]?
  var mailInProgArray : [Demande]?
  var obsInProgArray : [Demande]?
  var mailScheduledArray : [Demande]?
  var obsScheduledArray : [Demande]?
  var mailClosedArray : [Demande]?
  var obsClosedArray : [Demande]?
  
  @IBOutlet var lblHighTopDmd: UILabel!
  @IBOutlet var lblHighTopChgt: UILabel!
  @IBOutlet var lblHighTopIncdt: UILabel!
  @IBOutlet var lblDate: UILabel!
  
  @IBOutlet weak var lblNbrChangement: UILabel!
  @IBOutlet weak var lblNbrIncident: UILabel!
  @IBOutlet weak var lblNbrDemande: UILabel!
  @IBOutlet var contentView: UIView!
  @IBOutlet var topDemandeView: UIView!
  @IBOutlet var topIncidentView: UIView!
  @IBOutlet var topChangementView: UIView!
  
  //Top VIEW
  //DEMANDES
  //DEMANDE CRITICITE
  @IBOutlet var lblNbrCritTotal: UILabel!
  //DEMANDE ETAT
  @IBOutlet var lblScheduledMail: UILabel!
  @IBOutlet var lblInPrgMails: UILabel!
  @IBOutlet var lblClosedMail: UILabel!
  @IBOutlet var lblScheduledDmd: UILabel!
  @IBOutlet var lblProgressDmd: UILabel!
  @IBOutlet var lblClosedDmd: UILabel!
  @IBOutlet var lblNbrScheduledObs: UILabel!
  @IBOutlet var lblNbrProgressObs: UILabel!
  @IBOutlet var lblNbrClosedObs: UILabel!
  @IBOutlet var lblEtatMails: UILabel!
  @IBOutlet var lblEtatObs: UILabel!
  
  //CHANGEMENTS
  @IBOutlet var lblNbrPriorite: UILabel!
  @IBOutlet var lblScheduledchangement: UILabel!
  @IBOutlet var lblInPrgChangement: UILabel!
  @IBOutlet var lblClosedChangement: UILabel!
  @IBOutlet var lblScheduledChgt: UILabel!
  @IBOutlet var lblProgressChgt: UILabel!
  @IBOutlet var lblClosedChgt: UILabel!
  
  //Incidents
  @IBOutlet var lblNbrPrioriteInc: UILabel!
  @IBOutlet var lblNbrScheduledInc: UILabel!
  @IBOutlet var lblNbrInPrgInc: UILabel!
  @IBOutlet var lblNbrClosedInc: UILabel!
  @IBOutlet var lblScheduledIncdt: UILabel!
  @IBOutlet var lblProgressIncdt: UILabel!
  @IBOutlet var lblClosedInct: UILabel!
  
  //Changement Views
  @IBOutlet  var changementView: UIView!
  @IBOutlet  var radarChgmtChartView: RadarChartView!
  @IBOutlet  var pieChgmtChartView: PieChartView!
  @IBOutlet var lblEtatsChgt: UILabel!
  @IBOutlet var lblPrioriteChgt: UILabel!
  
  //Demande Views
  @IBOutlet  var DemandeView: UIView!
  @IBOutlet  var barChartView: BarChartView!
  @IBOutlet  var horizontalBarChartView: HorizontalBarChartView!
  @IBOutlet var lblEtatsDmd: UILabel!
  @IBOutlet var lblCriticiteDmd: UILabel!
  
  //Incident Views
  @IBOutlet var incidentView: UIView!
  @IBOutlet var radarIncdtChartView: RadarChartView!
  @IBOutlet var pieIncdtChartView: PieChartView!
  @IBOutlet var lblEtatsIncdt: UILabel!
  @IBOutlet var lblPrioriteIncdt: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.topDemandeView.layer.cornerRadius = 5.0
    self.topIncidentView.layer.cornerRadius = 5.0
    self.topChangementView.layer.cornerRadius = 5.0
    
    self.changementView.layer.cornerRadius = 5.0
    self.radarChgmtChartView.layer.cornerRadius = 5.0
    self.pieChgmtChartView.layer.cornerRadius = 5.0
    
    self.DemandeView.layer.cornerRadius = 5.0
    self.barChartView.layer.cornerRadius = 5.0
    self.horizontalBarChartView.layer.cornerRadius = 5.0
    
    self.incidentView.layer.cornerRadius = 5.0
    self.radarIncdtChartView.layer.cornerRadius = 5.0
    self.pieIncdtChartView.layer.cornerRadius = 5.0
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(animated: Bool)  {
    super.viewDidAppear(animated)
   /* let date = NSDate()
    let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    let today = cal.startOfDayForDate(date)
    let dateNext = NSDate.nextDay(today)
    changementArray = uiRealm.objects(Changement).filter("debut >= %@ AND debut < %@", today,dateNext)
    demandeArray = uiRealm.objects(Demande).filter("heureRealisation >= %@ AND heureRealisation < %@", today,dateNext)
    incidentArray = uiRealm.objects(Incident).filter("dateCreation >= %@ AND dateCreation < %@", today,dateNext)
*/
  
    changementArray = uiRealm.objects(Changement)
    incidentArray = uiRealm.objects(Incident)
    demandeArray = uiRealm.objects(Demande)
  
    
    //Changements filtred Etats
    changEtatAssignArray = changementArray.filter {
      $0.etat.rangeOfString("Assign", options: .CaseInsensitiveSearch) != nil
    }
    changEtatInProgArray = changementArray.filter {
      $0.etat.rangeOfString("WorkInProgress", options: .CaseInsensitiveSearch) != nil
    }
    changEtatClosedArray = changementArray.filter {
      $0.etat.rangeOfString("Closed", options: .CaseInsensitiveSearch) != nil
    }
    changEtatSchedArray = changementArray.filter {
      $0.etat.rangeOfString("Sched", options: .CaseInsensitiveSearch) != nil
    }
    changEtatNewArray = changementArray.filter {
      $0.etat.rangeOfString("New", options: .CaseInsensitiveSearch) != nil
    }
    changEtatResProgArray = changementArray.filter {
      $0.etat.rangeOfString("Resol", options: .CaseInsensitiveSearch) != nil
    }
    changEtatPendArray = changementArray.filter {
      $0.etat.rangeOfString("Pending", options: .CaseInsensitiveSearch) != nil
    }
    
    //Incidents filtred Etats
    incEtatInProgArray = incidentArray.filter {
      $0.etat.rangeOfString("cours", options: .CaseInsensitiveSearch) != nil
    }
    incEtatCanceledArray = incidentArray.filter {
      $0.etat.rangeOfString("Annulé", options: .CaseInsensitiveSearch) != nil
    }
    incEtatClosedArray = incidentArray.filter {
      $0.etat.rangeOfString("Clos", options: .CaseInsensitiveSearch) != nil
    }
    incEtatNewArray = incidentArray.filter {
      $0.etat.rangeOfString("Nouveau", options: .CaseInsensitiveSearch) != nil
    }
    incEtatResArray = incidentArray.filter {
      $0.etat.rangeOfString("Résolu", options: .CaseInsensitiveSearch) != nil
    }
    incEtatAssignArray = incidentArray.filter {
      $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
    }
    
    self.lblNbrDemande.text = String(self.demandeArray.count)
    self.lblNbrChangement.text = String(self.changementArray.count)
    self.lblNbrIncident.text = String(self.incidentArray.count)
    
    //DEMANDE CRITICITE
    let demandeCritArray = demandeArray.filter {
      $0.criticite.rangeOfString("Impératif", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrCritTotal.text = String(demandeCritArray.count)
    //DEMANDE MAIL
    mailArray = demandeArray.filter {
      $0.type.rangeOfString("mail", options: .CaseInsensitiveSearch) != nil
    }
    mailInProgArray = mailArray!.filter {
      $0.etat.rangeOfString("En cours", options: .CaseInsensitiveSearch) != nil
    }
    self.lblInPrgMails.text = String(mailInProgArray!.count)
    mailScheduledArray = mailArray!.filter {
      $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
    }
    self.lblScheduledMail.text = String(mailScheduledArray!.count)
    mailClosedArray = mailArray!.filter {
      $0.etat.rangeOfString("Ok", options: .CaseInsensitiveSearch) != nil
    }
    self.lblClosedMail.text = String(mailClosedArray!.count)
    
    //DEMANDE OBS
    obsArray = demandeArray.filter {
      $0.type.rangeOfString("obs", options: .CaseInsensitiveSearch) != nil
    }
    obsInProgArray = obsArray!.filter {
      $0.etat.rangeOfString("En cours", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrProgressObs.text = String(obsInProgArray!.count)
    obsScheduledArray = obsArray!.filter {
      $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrScheduledObs.text = String(obsScheduledArray!.count)
    obsClosedArray = obsArray!.filter {
      $0.etat.rangeOfString("Ok", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrClosedObs.text = String(obsClosedArray!.count)
    //Changement
    let changPrioArray = changementArray.filter {
      $0.priorite.rangeOfString("Urgent", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrPriorite.text = String(changPrioArray.count)
    self.lblScheduledchangement.text = String(changEtatAssignArray!.count)
    self.lblInPrgChangement.text = String(changEtatInProgArray!.count)
    self.lblClosedChangement.text = String(changEtatClosedArray!.count)
    //INCIDENTS
    let incidentPrioArray = incidentArray.filter {
      $0.priorite.rangeOfString("Critique", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrPrioriteInc.text = String(incidentPrioArray.count)
    self.lblNbrScheduledInc.text = String(incEtatAssignArray!.count)
    self.lblNbrInPrgInc.text = String(incEtatInProgArray!.count)
    self.lblNbrClosedInc.text = String(incEtatClosedArray!.count)
    
    self.lblNbrDemande.hidden = false
    self.lblNbrCritTotal.hidden = false
    self.lblInPrgMails.hidden = false
    self.lblScheduledMail.hidden = false
    self.lblClosedMail.hidden = false
    self.lblNbrProgressObs.hidden = false
    self.lblNbrScheduledObs.hidden = false
    self.lblNbrClosedObs.hidden = false
    self.lblNbrChangement.hidden = false
    self.lblNbrIncident.hidden = false
    self.lblNbrCritTotal.hidden = false
    self.lblNbrPriorite.hidden = false
    self.lblScheduledchangement.hidden = false
    self.lblInPrgChangement.hidden = false
    self.lblClosedChangement.hidden = false
    self.lblNbrPrioriteInc.hidden = false
    self.lblNbrScheduledInc.hidden = false
    self.lblNbrInPrgInc.hidden = false
    self.lblNbrClosedInc.hidden = false
    
    //CHARTS
    self.setDemandeEtatCharts()
    self.setDemandeCritCharts()
    self.setChangementCharts()
    self.setIncidentCharts()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    
    super.viewWillAppear(animated)
    //Label Date
    let date = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    self.lblDate.text = formatter.stringFromDate(date)
    //SETTING LABELS
    
    self.lblNbrDemande.hidden = true
    self.lblNbrCritTotal.hidden = true
    self.lblInPrgMails.hidden = true
    self.lblScheduledMail.hidden = true
    self.lblClosedMail.hidden = true
    self.lblNbrProgressObs.hidden = true
    self.lblNbrScheduledObs.hidden = true
    self.lblNbrClosedObs.hidden = true
    self.lblNbrChangement.hidden = true
    self.lblNbrIncident.hidden = true
    self.lblNbrCritTotal.hidden = true
    self.lblNbrPriorite.hidden = true
    self.lblScheduledchangement.hidden = true
    self.lblInPrgChangement.hidden = true
    self.lblClosedChangement.hidden = true
    self.lblNbrPrioriteInc.hidden = true
    self.lblNbrScheduledInc.hidden = true
    self.lblNbrInPrgInc.hidden = true
    self.lblNbrClosedInc.hidden = true
    //Demandes
    self.lblHighTopDmd.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
    
    self.lblNbrDemande.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
    //Changements
    self.lblHighTopChgt.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    
    self.lblNbrChangement.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    //Incidents
    self.lblHighTopIncdt.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    
    self.lblNbrIncident.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    
    //TOP VIEW
    
    self.lblNbrCritTotal.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
    self.lblEtatMails.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
    self.lblEtatMails.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblEtatObs.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
    self.lblEtatObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    
    //DEMANDE ETAT
    self.lblEtatsDmd.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
    self.lblCriticiteDmd.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
    //DEMANDE MAIL
    self.lblScheduledMail.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblInPrgMails.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblClosedMail.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    //DEMANDE OBS
    self.lblNbrScheduledObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblNbrProgressObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblNbrClosedObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    
    //CHANGEMENTS
    // add a lot of colors
    self.lblPrioriteChgt.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    self.lblEtatsChgt.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    
    self.lblNbrPriorite.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    
    self.lblScheduledchangement.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    
    self.lblInPrgChangement.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    
    self.lblClosedChangement.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    
    //Incidents
    self.lblPrioriteIncdt.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    self.lblEtatsIncdt.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    
    self.lblNbrPrioriteInc.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    
    self.lblNbrScheduledInc.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    
    self.lblNbrInPrgInc.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    
    self.lblNbrClosedInc.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    
    //Labels Etat color
    self.lblScheduledDmd.textColor = UIColor.init(red: 225.0/255, green: 113.0/255, blue: 141.0/255, alpha: 1.0)
    self.lblProgressDmd.textColor = UIColor.init(red: 0.0/255, green: 171.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblClosedDmd.textColor = UIColor.init(red: 246.0/255, green: 243.0/255, blue: 132.0/255, alpha: 1.0)
    self.lblScheduledChgt.textColor = UIColor.init(red: 225.0/255, green: 113.0/255, blue: 141.0/255, alpha: 1.0)
    self.lblProgressChgt.textColor = UIColor.init(red: 0.0/255, green: 171.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblClosedChgt.textColor = UIColor.init(red: 246.0/255, green: 243.0/255, blue: 132.0/255, alpha: 1.0)
    self.lblScheduledIncdt.textColor = UIColor.init(red: 225.0/255, green: 113.0/255, blue: 141.0/255, alpha: 1.0)
    self.lblProgressIncdt.textColor = UIColor.init(red: 0.0/255, green: 171.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblClosedInct.textColor = UIColor.init(red: 246.0/255, green: 243.0/255, blue: 132.0/255, alpha: 1.0)
    
    
  }
  
  
}

//MARK: - extension protocol
extension DashboardViewController : ChartViewDelegate{
  
  //MARK: - Chart View
  func setIncidentCharts() {
    
    //PIECHART : Priorité
    pieIncdtChartView = PieChartView.init(frame: self.pieIncdtChartView.frame)
    pieIncdtChartView.delegate = self
    pieIncdtChartView.usePercentValuesEnabled = true
    pieIncdtChartView.holeTransparent = true
    pieIncdtChartView.holeRadiusPercent = 0.58
    pieIncdtChartView.transparentCircleRadiusPercent = 0.61
    pieIncdtChartView.descriptionText = ""
    pieIncdtChartView.setExtraOffsets(left: 5.0, top:10.0 , right: 5.0, bottom: 5.0)
    pieIncdtChartView.noDataTextDescription = "Il n'y a pas de données à afficher."
    
    if (incidentArray.count > 0){
    pieIncdtChartView.drawHoleEnabled = true
    }else{
      pieIncdtChartView.drawHoleEnabled = false
    }
    pieIncdtChartView.rotationAngle = 0.0
    pieIncdtChartView.rotationEnabled = true
    pieIncdtChartView.highlightPerTapEnabled = true
    pieIncdtChartView.legend.enabled = false
    pieIncdtChartView.holeColor = UIColor.init(red: 59.0/255, green: 65.0/255, blue: 71.0/255, alpha: 1.0)
    
    //RADARCHART : ÉTATS
    radarIncdtChartView = RadarChartView.init(frame: self.radarIncdtChartView.frame)
    radarIncdtChartView.delegate = self
    radarIncdtChartView.descriptionText = ""
    radarIncdtChartView.noDataTextDescription = "Il n'y a pas de données à afficher."
    //  radarChgmtChartView.descriptionFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 12.0)!
    
    radarIncdtChartView.webLineWidth = 0.75
    radarIncdtChartView.innerWebLineWidth = 0.375
    radarIncdtChartView.webAlpha = 1.0
    
    let marker : BalloonMarker = BalloonMarker.init(color: UIColor.init(white: 180/255.0, alpha: 1.0), font: UIFont.systemFontOfSize(12.0), insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
    
    marker.minimumSize = CGSizeMake(80.0, 40.0)
    radarIncdtChartView.marker = marker
    
    let xAxis :ChartXAxis = radarIncdtChartView.xAxis
    xAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
    xAxis.labelTextColor = UIColor.whiteColor()
    
    
    let yAxis:ChartYAxis = radarIncdtChartView.yAxis
    yAxis.labelTextColor = UIColor.whiteColor()
    yAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
    yAxis.labelCount = 5
    yAxis.startAtZeroEnabled = true
    let valueFormatter = NSNumberFormatter()
    valueFormatter.maximumFractionDigits = 1
    yAxis.valueFormatter = valueFormatter
    
    
    let l : ChartLegend = radarIncdtChartView.legend
    l.enabled = false
    radarIncdtChartView.data = self.setIncEtatData()
    
    //        self.setDataCount()
    
    
    self.setIncdtPrioriteData()
    
    pieIncdtChartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .EaseOutBack)
    radarIncdtChartView.spin(duration: 1.0, fromAngle: 0.0, toAngle: 60.0)
    incidentView.addSubview(pieIncdtChartView)
    incidentView.addSubview(radarIncdtChartView)
    
  }
  
  func setChangementCharts() {
    
    //PIECHART : Priorité
    pieChgmtChartView = PieChartView.init(frame: self.pieChgmtChartView.frame)
    pieChgmtChartView.delegate = self
    pieChgmtChartView.usePercentValuesEnabled = true
    pieChgmtChartView.holeTransparent = true
    pieChgmtChartView.holeRadiusPercent = 0.58
    pieChgmtChartView.transparentCircleRadiusPercent = 0.61
    pieChgmtChartView.descriptionText = ""
    pieChgmtChartView.setExtraOffsets(left: 5.0, top:10.0 , right: 5.0, bottom: 5.0)
    pieChgmtChartView.noDataTextDescription = "Il n'y a pas de données à afficher."
    
    if (changementArray.count > 0){
      pieChgmtChartView.drawHoleEnabled = true
    }else{
      pieChgmtChartView.drawHoleEnabled = false
    }
    pieChgmtChartView.rotationAngle = 0.0
    pieChgmtChartView.rotationEnabled = true
    pieChgmtChartView.highlightPerTapEnabled = true
    pieChgmtChartView.legend.enabled = false
    pieChgmtChartView.holeColor = UIColor.init(red: 59.0/255, green: 65.0/255, blue: 71.0/255, alpha: 1.0)
    
    //RADARCHART : ÉTATS
    radarChgmtChartView = RadarChartView.init(frame: self.radarChgmtChartView.frame)
    radarChgmtChartView.delegate = self
    radarChgmtChartView.descriptionText = ""
    radarChgmtChartView.noDataTextDescription = "Il n'y a pas de données à afficher."
    //  radarChgmtChartView.descriptionFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 12.0)!
    
    radarChgmtChartView.webLineWidth = 0.75
    radarChgmtChartView.innerWebLineWidth = 0.375
    radarChgmtChartView.webAlpha = 1.0
    
    let marker : BalloonMarker = BalloonMarker.init(color: UIColor.init(white: 180/255.0, alpha: 1.0), font: UIFont.systemFontOfSize(12.0), insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
    
    marker.minimumSize = CGSizeMake(80.0, 40.0)
    radarChgmtChartView.marker = marker
    
    let xAxis :ChartXAxis = radarChgmtChartView.xAxis
    xAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
    xAxis.labelTextColor = UIColor.whiteColor()
    
    
    let yAxis:ChartYAxis = radarChgmtChartView.yAxis
    yAxis.labelTextColor = UIColor.whiteColor()
    yAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
    yAxis.labelCount = 5
    yAxis.startAtZeroEnabled = true
    let valueFormatter = NSNumberFormatter()
    valueFormatter.maximumFractionDigits = 1
    yAxis.valueFormatter = valueFormatter
    
    
    let l : ChartLegend = radarChgmtChartView.legend
    l.enabled = false
    radarChgmtChartView.data = self.setChgtEtatData()
    
    //        self.setDataCount()
    
    
    self.setChgtPrioriteData()
    
    pieChgmtChartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .EaseOutBack)
    radarChgmtChartView.spin(duration: 1.0, fromAngle: 0.0, toAngle: 64.0)
    changementView.addSubview(pieChgmtChartView)
    changementView.addSubview(radarChgmtChartView)
    
  }
  
  func setDataCount(){
    
    var xVals = [String]()
    
    for var i = 0; i < 3; ++i {
      xVals.append(String(i))
    }
    
    var yVals1 = [BubbleChartDataEntry]()
    var yVals2 = [BubbleChartDataEntry]()
    var yVals3 = [BubbleChartDataEntry]()
    
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    
    let bubbleChartDataEntry1 = BubbleChartDataEntry.init(xIndex: 0, value:40.0, size:  CGFloat(changementArray.count))
    yVals1.append(bubbleChartDataEntry1)
    
    let bubbleChartDataEntry2 = BubbleChartDataEntry.init(xIndex: 1, value:35.0, size: CGFloat(incidentArray.count))
    yVals2.append(bubbleChartDataEntry2)
    
    let bubbleChartDataEntry3 = BubbleChartDataEntry.init(xIndex: 2, value: 37.5, size: CGFloat(demandeArray.count))
    yVals3.append(bubbleChartDataEntry3)
    
    // Changement
    let dataSet1 = BubbleChartDataSet.init(yVals: yVals1, label: "Changements")
    dataSet1.setColor(ChartColorTemplates.colorful()[0], alpha: 0.5)
    dataSet1.drawValuesEnabled = true
    //Incidents
    let dataSet2 = BubbleChartDataSet.init(yVals: yVals2, label: "Incidents")
    dataSet2.setColor(ChartColorTemplates.colorful()[1], alpha: 0.5)
    dataSet2.drawValuesEnabled = true
    // Demandes
    let dataSet3 = BubbleChartDataSet.init(yVals: yVals3, label: "Demandes")
    dataSet3.setColor(ChartColorTemplates.colorful()[2], alpha: 0.5)
    dataSet3.drawValuesEnabled = true
    
    var dataSets = [BubbleChartDataSet]()
    dataSets.append(dataSet1)
    dataSets.append(dataSet2)
    dataSets.append(dataSet3)
    
    let data : BubbleChartData = BubbleChartData.init(xVals: xVals, dataSets: dataSets)
    data.setValueFont(UIFont.init(name: "HelveticaNeue", size: 18.0))
    data.setHighlightCircleWidth(1.5)
    data.setValueTextColor(UIColor.whiteColor())
    
    //    bubbleChartView.data = data
    
  }
  
  func setChgtPrioriteData(){
    
    //Récupération de toutes les priorités dans une liste
    let changCritiqueArray = changementArray.filter {
      $0.priorite.rangeOfString("Urgent", options: .CaseInsensitiveSearch) != nil
    }
    let changImportanteArray = changementArray.filter {
      $0.priorite.rangeOfString("High", options: .CaseInsensitiveSearch) != nil
    }
    let changMoyArray = changementArray.filter {
      $0.priorite.rangeOfString("Medium", options: .CaseInsensitiveSearch) != nil
    }
    let changFaibleArray = changementArray.filter {
      $0.priorite.rangeOfString("Low", options: .CaseInsensitiveSearch) != nil
    }
    
    var countsKeys = [String]()
    var countsValues = [Int]()
    countsKeys.insert("Critique", atIndex: 0)
    countsKeys.insert("Importante", atIndex: 1)
    countsKeys.insert("Moyenne", atIndex: 2)
    countsKeys.insert("Faible", atIndex: 3)
    countsValues.insert(changCritiqueArray.count, atIndex: 0)
    countsValues.insert(changImportanteArray.count, atIndex: 1)
    countsValues.insert(changMoyArray.count, atIndex: 2)
    countsValues.insert(changFaibleArray.count, atIndex: 3)
    //Mise en place de la PieChart
    var yVals1 = [ChartDataEntry]()
    var xVals = [String]()
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    if (changementArray.count > 0){
      for index in 0...3{
        let percentage = Double(countsValues[index]*100 / changementArray.count)
        let barChartDataEntry = BarChartDataEntry.init(value: percentage, xIndex: index)
        yVals1.append(barChartDataEntry)
        xVals.append(countsKeys[index])
      }
    }
    
    let dataSet = PieChartDataSet.init(yVals: yVals1, label: "Priorités des changements")
    dataSet.sliceSpace = 2.0;
    
    var colors = [UIColor]()
    let hexToRGB = ColorHelper()
    colors.appendContentsOf(hexToRGB.changementNuanceColors())
    dataSet.colors = colors;
    dataSet.valueTextColor = UIColor.whiteColor()
    
    //        PieChartData *data = [[PieChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    let data : PieChartData = PieChartData.init(xVals: xVals, dataSet: dataSet)
    
    //        NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    let pFormatter:NSNumberFormatter = NSNumberFormatter.init()
    pFormatter.numberStyle = .PercentStyle
    pFormatter.maximumFractionDigits = 1
    pFormatter.multiplier = 1.0
    pFormatter.percentSymbol = " %"
    data.setValueFormatter(pFormatter)
    data.setValueFont(UIFont.init(name: "HelveticaNeue-Light", size: 11.0))
    data.setValueTextColor(UIColor.blackColor())
    
    pieChgmtChartView.data = data
    pieChgmtChartView.highlightValues(nil)
    
    //        self.chartValueSelected(pieChartView, entry: yVals1[1], dataSetIndex: 0, highlight: self.pieChartView.highlighted[0])
    
    
  }
  
  func setChgtEtatData()->RadarChartData{
    
    //  let mult:Double = 30.0
    //   let count:Int = 5
    var parties = [String]()
    if (changementArray.count > 0){
     parties = ["WorkInProgress","Scheduled","Closed","New","Resolved", "Pending","Assigned"]
    }
    
    
    var yVals = [ChartDataEntry]()
    var xVals = [String]()
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    // let countsKeys :[String] = Array(counts.keys)
    var i = 0
    
    for key in parties{
      switch key{
      case "WorkInProgress":
        let val = Double(changEtatInProgArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append("En cours")
        break
      case "Scheduled":
        let val = Double(changEtatSchedArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append("Planifié")
        break
      case "Closed":
        let val = Double(changEtatClosedArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append("Clos")
        break
      case "New":
        let val = Double(changEtatNewArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append("Nouveau")
        break
      case "Resolved":
        let val = Double(changEtatResProgArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append("Résolu")
        break
      case "Pending":
        let val = Double(changEtatPendArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append("En attente")
        break
      case "Assigned":
        let val = Double(changEtatAssignArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append("Affecté")
        break
      default:
        break
      }
      i++
    }
    
    //Bar chart View
    let radarChartData : RadarChartData!
    
    let radarChartDataSet1 = RadarChartDataSet(yVals: yVals, label: "")
    radarChartDataSet1.setColor(UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0))
    radarChartDataSet1.drawFilledEnabled = true
    radarChartDataSet1.lineWidth = 2.0
    radarChartData = RadarChartData(xVals: xVals, dataSet: radarChartDataSet1)
    
    /*
    var dataSets = [RadarChartDataSet]()
    dataSets.append(radarChartDataSet1)
    dataSets.append(radarChartDataSet2)
    */
    
    radarChartData.setValueFont(UIFont.init(name: "HelveticaNeue-CondensedBold", size: 10.0))
    radarChartData.setValueTextColor(UIColor.whiteColor())
    radarChartData.setDrawValues(false)
    
    
    return radarChartData
    
  }
  
  //MARK: Chart View Controller
  func setDemandeEtatCharts() {
    
    // Bar Chart view
    let subView = UIView()
    subView.frame = CGRectMake(0 , self.barChartView.frame.origin.y+20, self.barChartView.frame.width, self.barChartView.frame.height*0.9)
    barChartView = BarChartView.init(frame: subView.frame)
    //        chartView.autoresizingMask = .FlexibleRightMargin
    barChartView.delegate = self;
    
    barChartView.descriptionText = ""
    barChartView.noDataTextDescription = "Il n'y a pas de données à afficher."
    
    barChartView.pinchZoomEnabled = false
    barChartView.drawBarShadowEnabled = false
    barChartView.drawGridBackgroundEnabled = false
    
    let marker : BalloonMarker = BalloonMarker.init(color: UIColor.init(white: 180.0/255, alpha: 1.0) , font: UIFont.systemFontOfSize(12.0), insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
    marker.minimumSize = CGSizeMake(80.0, 40.0);
    barChartView.marker = marker
    
    
    let legend:ChartLegend = barChartView.legend
    legend.enabled = false
    /*
    legend.position = .AboveChartCenter
    legend.font = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 11.0)!
    legend.textColor = UIColor.whiteColor()
    */
    
    let xAxis:ChartXAxis = barChartView.xAxis;
    xAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 8.0)!
    xAxis.labelTextColor = UIColor.whiteColor()
    xAxis.labelPosition = .Bottom
    /*
    let leftAxis:ChartYAxis = barChartView.leftAxis;
    leftAxis.labelFont = UIFont.init(name: "HelveticaNeue-Light", size: 10.0)!
    leftAxis.valueFormatter = NSNumberFormatter()
    leftAxis.valueFormatter!.maximumFractionDigits = 1
    leftAxis.drawGridLinesEnabled = false
    leftAxis.spaceTop = 0.25
    leftAxis.labelTextColor = UIColor.whiteColor()
    */
    barChartView.rightAxis.enabled = false
    barChartView.leftAxis.enabled = false
    
    
    self.setDemandeEtats()
    
    
    barChartView.animate(yAxisDuration: 1.5)
    self.DemandeView.addSubview(barChartView)
    
  }
  
  func setDemandeEtats(){
    
    var xVals = [String]()
    
    if (demandeArray.count > 0){
     xVals = ["A venir","Affecté","En cours", "Retard","Clos", "Annulé","Ko"]
    }
    //MAILS
    let mailComingArray = mailArray!.filter {
      $0.etat.rangeOfString("A venir", options: .CaseInsensitiveSearch) != nil
    }
    let mailDelayArray = mailArray!.filter {
      $0.etat.rangeOfString("Retard", options: .CaseInsensitiveSearch) != nil
    }
    let mailCancelArray = mailArray!.filter {
      $0.etat.rangeOfString("Annulé", options: .CaseInsensitiveSearch) != nil
    }
    let mailKoArray = mailArray!.filter {
      $0.etat.rangeOfString("Ko", options: .CaseInsensitiveSearch) != nil
    }
    //OBS
    let obsComingArray = obsArray!.filter {
      $0.etat.rangeOfString("A venir", options: .CaseInsensitiveSearch) != nil
    }
    let obsDelayArray = obsArray!.filter {
      $0.etat.rangeOfString("Retard", options: .CaseInsensitiveSearch) != nil
    }
    let obsCancelArray = obsArray!.filter {
      $0.etat.rangeOfString("Annulé", options: .CaseInsensitiveSearch) != nil
    }
    let obsKoArray = obsArray!.filter {
      $0.etat.rangeOfString("Ko", options: .CaseInsensitiveSearch) != nil
    }
    
    let countsMailsValues = [mailComingArray.count,mailScheduledArray!.count,mailInProgArray!.count,
                              mailDelayArray.count,mailClosedArray!.count, mailCancelArray.count,
                        mailKoArray.count]
    let countsObsValues = [obsComingArray.count,obsScheduledArray!.count,obsInProgArray!.count,
                              obsDelayArray.count, obsClosedArray!.count, obsCancelArray.count,obsKoArray.count]
    var yVals1 = [BarChartDataEntry]()
    var yVals2 = [BarChartDataEntry]()
    
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    if ( demandeArray.count > 0){
      for index in 0...6 {
        var val = Double(countsMailsValues[index])
        var barChartDataEntry = BarChartDataEntry.init(value: val, xIndex: index)
        yVals1.append(barChartDataEntry)
        val = Double(countsObsValues[index])
        barChartDataEntry = BarChartDataEntry.init(value: val, xIndex: index)
        yVals2.append(barChartDataEntry)
      }
    }
    
    //Mails Bar chart View
    let barChartDataSet1 = BarChartDataSet(yVals: yVals1, label: "MAILS")
    barChartDataSet1.setColor(UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0))
    //Obs Bar chart View
    let barChartDataSet2 = BarChartDataSet(yVals: yVals2, label: "OBS")
    barChartDataSet2.setColor(UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0))
    
    
    var dataSets = [BarChartDataSet]()
    dataSets.append(barChartDataSet1)
    dataSets.append(barChartDataSet2)
    
    let barChartData = BarChartData(xVals: xVals, dataSets: dataSets)
    barChartData.groupSpace = 0.8
    barChartData.setValueFont(UIFont.init(name: "HelveticaNeue-CondensedBold", size: 10.0))
    let valueFormatter = NSNumberFormatter()
    valueFormatter.maximumFractionDigits = 1
    barChartData.setValueFormatter(valueFormatter)
    barChartData.setValueTextColor(UIColor.whiteColor())
    
    barChartView.data = barChartData
    
    
  }
  
  //MARK: Chart View Controller
  func setDemandeCritCharts() {
    
    let customFormatter:NSNumberFormatter = NSNumberFormatter.init()
    customFormatter.negativePrefix = ""
    customFormatter.positiveSuffix = ""
    customFormatter.negativeSuffix = ""
    customFormatter.minimumSignificantDigits = 1
    customFormatter.minimumFractionDigits = 1
    // Line Chart view
    let subView = UIView()
    subView.frame = CGRectMake(0 , self.horizontalBarChartView.frame.origin.y+20, self.horizontalBarChartView.frame.width, self.horizontalBarChartView.frame.height*0.9)
    horizontalBarChartView = HorizontalBarChartView.init(frame: subView.frame)
    horizontalBarChartView.delegate = self
    
    horizontalBarChartView.descriptionText = ""
    horizontalBarChartView.noDataTextDescription = "Il n'y a pas de données à afficher."
    horizontalBarChartView.drawBarShadowEnabled = false
    horizontalBarChartView.drawValueAboveBarEnabled = true
    
    horizontalBarChartView.pinchZoomEnabled = true
    
    horizontalBarChartView.leftAxis.enabled = false
    horizontalBarChartView.rightAxis.startAtZeroEnabled = false
    
    horizontalBarChartView.rightAxis.labelCount = 9
    horizontalBarChartView.rightAxis.valueFormatter = customFormatter
    horizontalBarChartView.rightAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
    
    let xAxis :ChartXAxis = horizontalBarChartView.xAxis
    xAxis.labelPosition = .Bottom
    xAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 12.0)!
    xAxis.labelTextColor = UIColor.whiteColor()
    xAxis.drawAxisLineEnabled = false
    xAxis.drawGridLinesEnabled = true
    
  
    horizontalBarChartView.legend.enabled = false
    
    let leftAxis:ChartYAxis = horizontalBarChartView.leftAxis
    //  leftAxis.labelTextColor = UIColor.whiteColor()
    leftAxis.enabled = false
    
    let rightAxis : ChartYAxis = horizontalBarChartView.rightAxis
    //  rightAxis.labelTextColor = UIColor.whiteColor()
    rightAxis.enabled = false
    
    let colorHelper = ColorHelper()
    horizontalBarChartView.gridBackgroundColor = colorHelper.HexToRGB(0x3B4147)
    
    self.setData(customFormatter)
    
    
    horizontalBarChartView.animate(yAxisDuration: 1.5)
    //        self.chartView.autoresizingMask = .FlexibleTopMargin
    self.DemandeView.addSubview(horizontalBarChartView)
    
    
  }
  
  func setData(customFormatter : NSNumberFormatter){
    
    var xVals = [String]()
    var yVals = [BarChartDataEntry]()
    
    if (demandeArray.count > 0){
     xVals = ["Peu critique","Critique", "Trés critique", "Impératif"]
  
    let mailPeuArray = mailArray!.filter {
      $0.criticite.rangeOfString("Peu", options: .CaseInsensitiveSearch) != nil
    }
    let mailCritArray = mailArray!.filter {
      $0.criticite.rangeOfString("Critique") != nil
    }
    let mailTresArray = mailArray!.filter {
      $0.criticite.rangeOfString("Trés", options: .CaseInsensitiveSearch) != nil
    }
    let mailImpArray = mailArray!.filter {
      $0.criticite.rangeOfString("Impératif", options: .CaseInsensitiveSearch) != nil
    }
    //OBS
    let obsPeuArray = obsArray!.filter {
      $0.criticite.rangeOfString("Peu", options: .CaseInsensitiveSearch) != nil
    }
    let obsCritArray = obsArray!.filter {
      $0.criticite.rangeOfString("Critique") != nil
    }
    let obsTresArray = obsArray!.filter {
      $0.criticite.rangeOfString("Trés", options: .CaseInsensitiveSearch) != nil
    }
    let obsImpArray = obsArray!.filter {
      $0.criticite.rangeOfString("Impératif", options: .CaseInsensitiveSearch) != nil
    }

    //AXIS
    
    let elements = [ mailPeuArray.count, mailCritArray.count, mailTresArray.count,mailImpArray.count,
      obsPeuArray.count,obsCritArray.count,obsTresArray.count, obsImpArray.count]
    let maxElements = Double(elements.maxElement()!)
    horizontalBarChartView.rightAxis.customAxisMax = maxElements + 2.0
    horizontalBarChartView.rightAxis.customAxisMin = -(maxElements + 2.0)
    
    yVals.append(BarChartDataEntry.init(values: [-Double(mailPeuArray.count),Double(obsPeuArray.count)], xIndex: 0))
    yVals.append(BarChartDataEntry.init(values: [-Double(mailCritArray.count),Double(obsCritArray.count)], xIndex: 1))
    yVals.append(BarChartDataEntry.init(values: [-Double(mailTresArray.count),Double(obsTresArray.count)], xIndex: 2))
    yVals.append(BarChartDataEntry.init(values: [-Double(mailImpArray.count),Double(obsImpArray.count)], xIndex: 3))
  }
  
    //Bar chart View
    let barChartDataSet = BarChartDataSet(yVals: yVals, label: "")
    barChartDataSet.axisDependency = .Right
    barChartDataSet.valueFont = UIFont.systemFontOfSize(7.0)
    barChartDataSet.valueFormatter = customFormatter
    barChartDataSet.barSpace = 0.4
    barChartDataSet.stackLabels = ["MAILS","OBS"]
    barChartDataSet.colors = [ UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0),UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)]
    
    
    let barChartData = BarChartData(xVals: xVals, dataSet: barChartDataSet)
    barChartData.setValueFont(UIFont.init(name: "HelveticaNeue-CondensedBold", size: 10.0))
    barChartData.setValueTextColor(UIColor.whiteColor())
    horizontalBarChartView.data = barChartData
    horizontalBarChartView.setNeedsDisplay()
    
    
  }
  
  func setIncEtatData()->RadarChartData{
    
    //  let mult:Double = 30.0
    //   let count:Int = 5
    var parties = [String]()
    if (incidentArray.count > 0){
     parties = ["Nouveau","Affecté","En cours","Résolu","Clos", "Annulé"]
    }
    
    var yVals = [ChartDataEntry]()
    var xVals = [String]()
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    // let countsKeys :[String] = Array(counts.keys)
    var i = 0
    
    for key in parties{
      switch key{
      case "Nouveau":
        let val = Double(incEtatNewArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append(key)
        break
      case "Affecté":
        let val = Double(incEtatAssignArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append(key)
        break
      case "En cours":
        let val = Double(incEtatInProgArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append(key)
        break
      case "Résolu":
        let val = Double(incEtatResArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append(key)
        break
      case "Clos":
        let val = Double(incEtatClosedArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append(key)
        break
      case "Annulé":
        let val = Double(incEtatCanceledArray!.count)
        let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
        yVals.append(barChartDataEntry)
        xVals.append(key)
        break
      default:
        break
      }
      i++
    }
    
    //Bar chart View
    let radarChartData : RadarChartData!
    
    let radarChartDataSet2 = RadarChartDataSet(yVals: yVals, label: "")
    radarChartDataSet2.setColor(UIColor.init(red: 246.0/255, green: 168.0/255, blue: 0.0/255, alpha: 1.0))
    radarChartDataSet2.drawFilledEnabled = true
    radarChartDataSet2.lineWidth = 2.0
    radarChartData = RadarChartData(xVals: xVals, dataSet: radarChartDataSet2)
    
    /*
    var dataSets = [RadarChartDataSet]()
    dataSets.append(radarChartDataSet1)
    dataSets.append(radarChartDataSet2)
    */
    
    radarChartData.setValueFont(UIFont.init(name: "HelveticaNeue-CondensedBold", size: 10.0))
    radarChartData.setValueTextColor(UIColor.whiteColor())
    radarChartData.setDrawValues(false)
    
    
    return radarChartData
    
  }
  
  func setIncdtPrioriteData(){
    
    
    let incidentCritiqueArray = incidentArray.filter {
      $0.priorite.rangeOfString("Critique", options: .CaseInsensitiveSearch) != nil
    }
    let incidentImportanteArray = incidentArray.filter {
      $0.priorite.rangeOfString("Importante", options: .CaseInsensitiveSearch) != nil
    }
    let incidentMoyArray = incidentArray.filter {
      $0.priorite.rangeOfString("Moyenne", options: .CaseInsensitiveSearch) != nil
    }
    let incidentFaibleArray = incidentArray.filter {
      $0.priorite.rangeOfString("Faible", options: .CaseInsensitiveSearch) != nil
    }
    
    var countsKeys = [String]()
    var countsValues = [Int]()
    countsKeys.insert("Critique", atIndex: 0)
    countsKeys.insert("Importante", atIndex: 1)
    countsKeys.insert("Moyenne", atIndex: 2)
    countsKeys.insert("Faible", atIndex: 3)
    countsValues.insert(incidentCritiqueArray.count, atIndex: 0)
    countsValues.insert(incidentImportanteArray.count, atIndex: 1)
    countsValues.insert(incidentMoyArray.count, atIndex: 2)
    countsValues.insert(incidentFaibleArray.count, atIndex: 3)
    //Mise en place de la PieChart
    var yVals1 = [ChartDataEntry]()
    var xVals = [String]()
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    if(incidentArray.count > 0){
      for index in 0...3{
        let percentage = Double(countsValues[index]*100 / incidentArray.count)
        let barChartDataEntry = BarChartDataEntry.init(value: percentage, xIndex: index)
        yVals1.append(barChartDataEntry)
        xVals.append(countsKeys[index])
      }
    }
    
    let dataSet = PieChartDataSet.init(yVals: yVals1, label: "Priorités des incidents")
    dataSet.sliceSpace = 2.0;
    
    var colors = [UIColor]()
    /*  colors.appendContentsOf(ChartColorTemplates.vordiplom())
    colors.appendContentsOf(ChartColorTemplates.joyful())
    colors.appendContentsOf(ChartColorTemplates.colorful())
    colors.appendContentsOf(ChartColorTemplates.liberty())*/
    //  colors.appendContentsOf(ChartColorTemplates.pastel())
    let colorHelper = ColorHelper()
    colors.appendContentsOf(colorHelper.incidentNuanceColors())
    //let uiColorFromRGB: ColorHelper = ColorHelper()
    //  colors.append(uiColorFromRGB.UIColorFromRGB(0xE74C3C))
    //  colors.append(ChartColorTemplates.vordiplom()[4])
    
    
    dataSet.colors = colors;
    dataSet.valueTextColor = UIColor.whiteColor()
    
    //PieChartData *data = [[PieChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    let data : PieChartData = PieChartData.init(xVals: xVals, dataSet: dataSet)
    
    //        NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    let pFormatter:NSNumberFormatter = NSNumberFormatter.init()
    pFormatter.numberStyle = .PercentStyle
    pFormatter.maximumFractionDigits = 1
    pFormatter.multiplier = 1.0
    pFormatter.percentSymbol = " %"
    data.setValueFormatter(pFormatter)
    data.setValueFont(UIFont.init(name: "HelveticaNeue-Light", size: 11.0))
    data.setValueTextColor(UIColor.blackColor())
    
    //Incidents
    pieIncdtChartView.data = data
    pieIncdtChartView.highlightValues(nil)
    
    //        self.chartValueSelected(pieChartView, entry: yVals1[1], dataSetIndex: 0, highlight: self.pieChartView.highlighted[0])
    
    
  }
  
  //MARK: Action
  @IBAction func DemandesTapped(sender: AnyObject) {
    delegate?.didSelectAction(4)
  }
  
  @IBAction func changementsTapped(sender: AnyObject) {
    delegate?.didSelectAction(2)
  }
  
  @IBAction func incidentsTapped(sender: AnyObject) {
    delegate?.didSelectAction(3)
  }
  
  @IBAction func refreshTapped() {
    self.refreshButton.rotate360Degrees()
    
    if Reachability.isConnectedToNetwork() == true {
      
      Ag2rClient.getChangements()
      Ag2rClient.getDemandes()
      Ag2rClient.getIncidents()
      
      let delayInSeconds = 2.0
      let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC))) // 1
      dispatch_after(popTime, dispatch_get_main_queue()) { // 2
        self.delegate?.didSelectAction(1)
      }
      
    }
    
  }
  
  //Mark: - ChartViewDelegate
  func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
    print("chartValueSelecter")
  }
  
  func chartValueNothingSelected(chartView: ChartViewBase) {
    print("chartValueNothingSelected")
  }
  
}
