//
//  IncidentsViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 21/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class IncidentsViewController: UIViewController {
  
  @IBOutlet var customTableView: ASFTableView!
  @IBOutlet var detailView: UIView!
  var delegate : ActionMenuDelegate?
  
  //LABELS
  @IBOutlet var lblTilte: UILabel!
  @IBOutlet var lblNbrIncidents: UILabel!
  @IBOutlet var lblNbrNewEtat: UILabel!
  @IBOutlet var lblNbrSchdlEtat: UILabel!
  @IBOutlet var lblNbrPrgEtat: UILabel!
  @IBOutlet var lblNbrReslvdEtat: UILabel!
  @IBOutlet var lblNbrPriorite: UILabel!
  @IBOutlet var lblNbrCanceledEtat: UILabel!
  @IBOutlet var lblNbrClosEtat: UILabel!
  
  var incidentArray : Results<Incident>!
  var filtredIncidentArray : Results<Incident>!
  
  var incEtatInProgArray : [Incident]!
  var incEtatCanceledArray : [Incident]!
  var incEtatClosedArray : [Incident]!
  var incEtatNewArray : [Incident]!
  var incEtatResArray : [Incident]!
  var incEtatAssignArray : [Incident]!
  var incidentPrioArray : [Incident]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.customTableView.layer.cornerRadius = 5.0
    self.detailView.layer.cornerRadius = 5.0
    // Do any additional setup after loading the view.
    //Lables Color
    self.lblTilte.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    self.lblNbrIncidents.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    self.lblNbrNewEtat.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    self.lblNbrClosEtat.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    self.lblNbrCanceledEtat.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    self.lblNbrSchdlEtat.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    self.lblNbrPrgEtat.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    self.lblNbrReslvdEtat.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    self.lblNbrPriorite.textColor = UIColor.init(red: 235.0/255, green: 106.0/255, blue: 40.0/255, alpha: 1.0)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable:",name:"reload", object: nil)
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let array:[Incident] = incidentArray.map { $0 }
    self.addASFTableView(array)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    var dataArray = [Incident]()
    
    if (filtredIncidentArray != nil){
      dataArray = filtredIncidentArray.map { $0 }
    }else{
      dataArray = incidentArray.map { $0 }
    }
    
    self.lblNbrIncidents.text = String(dataArray.count)
    
    incEtatInProgArray = dataArray.filter {
      $0.etat.rangeOfString("cours", options: .CaseInsensitiveSearch) != nil
    }
    incEtatCanceledArray = dataArray.filter {
      $0.etat.rangeOfString("Annulé", options: .CaseInsensitiveSearch) != nil
    }
    incEtatClosedArray = dataArray.filter {
      $0.etat.rangeOfString("Clos", options: .CaseInsensitiveSearch) != nil
    }
    incEtatNewArray = dataArray.filter {
      $0.etat.rangeOfString("Nouveau", options: .CaseInsensitiveSearch) != nil
    }
    incEtatResArray = dataArray.filter {
      $0.etat.rangeOfString("Résolu", options: .CaseInsensitiveSearch) != nil
    }
    incEtatAssignArray = dataArray.filter {
      $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
    }

    self.lblNbrNewEtat.text = String(incEtatNewArray.count)
    self.lblNbrClosEtat.text = String(incEtatClosedArray.count)
    self.lblNbrCanceledEtat.text = String(incEtatCanceledArray.count)
    self.lblNbrSchdlEtat.text = String(incEtatAssignArray.count)
    self.lblNbrPrgEtat.text = String(incEtatInProgArray.count)
    self.lblNbrReslvdEtat.text = String(incEtatResArray.count)
    
    incidentPrioArray = dataArray.filter {
      $0.priorite.rangeOfString("Critique", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrPriorite.text = String(incidentPrioArray.count)
    
  }

  func reloadTable(notification: NSNotification){
    //load data here
    // First try to cast user info to expected type
    if let info = notification.userInfo as? Dictionary<String,NSDate> {
      // Check if value present before using it
      let date = info["date"]
      let dateNext = info["dateNext"]
      print("date is \(date)")
      print("Next date is \(dateNext)")
      filtredIncidentArray = uiRealm.objects(Incident).filter("dateCreation >= %@ AND dateCreation < %@", date! ,dateNext!).sorted("dateCreation", ascending: false)
      let array:[Incident] = filtredIncidentArray.map({$0})
      self.addASFTableView(array)
      self.viewDidAppear(true)
    }
    
  }
  
  //MARK: - FILTER ACTION
  @IBAction func filterNewAction() {
    self.addASFTableView(incEtatNewArray)
  }
  @IBAction func filterAssignAction() {
    self.addASFTableView(incEtatAssignArray)
  }
  @IBAction func filterProgAction() {
    self.addASFTableView(incEtatInProgArray)
  }
  @IBAction func filterCanceledAction() {
    self.addASFTableView(incEtatCanceledArray)
  }
  @IBAction func filterResolvAction() {
    self.addASFTableView(incEtatResArray)
  }
  @IBAction func filterClosedAction() {
    self.addASFTableView(incEtatClosedArray)
  }
  @IBAction func showAllIncidents() {
    if (filtredIncidentArray != nil){
      self.addASFTableView(filtredIncidentArray.map({$0}))
    }else{
      self.addASFTableView(incidentArray.map({$0}))
    }
    
    self.viewDidAppear(true)

  }

  @IBAction func filterCritiqueAction() {
    self.addASFTableView(incidentPrioArray)
 
  }
  
}

//MARK: - extension protocol
extension IncidentsViewController : ASFTableViewDelegate{
  
  func addASFTableView(dataArray : [Incident]){

    let cols = ["ID Requete","Priorité", "État","Urgence", "Impact", "Résumé", "Date de création","Date de modification", "Nombre relance"]
    let weights = [(0.1),(0.1),(0.1),(0.1),(0.1),(0.15),(0.15),(0.15),(0.05)]
    let options = [kASF_OPTION_CELL_TEXT_FONT_SIZE : 8,
      kASF_OPTION_CELL_TEXT_FONT_BOLD : true,
      kASF_OPTION_CELL_BORDER_COLOR : UIColor.lightGrayColor(),
      kASF_OPTION_CELL_BORDER_SIZE : 2.0,
      kASF_OPTION_BACKGROUND : UIColor.init(red: 239/255.0, green: 244/255.0, blue: 254/255.0, alpha: 1.0)]
    
    customTableView.delegate = self
    customTableView.setBounces(false)
    customTableView.setSelectionColor(UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0))
    customTableView.setTitles(cols, withWeights: weights, withOptions: options, witHeight: 32, floating: true)
    
    var rowArray = [AnyObject]()
    let textAlignementCenter = NSTextAlignment.Center.rawValue
    let textAlignementLeft = NSTextAlignment.Left.rawValue
    
    for (index, incident) in dataArray.enumerate() {
      
      let rows = [
        [kASF_CELL_TITLE:incident.idRequete, kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:incident.priorite,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:incident.etat,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:incident.urgence,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:incident.impact,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:incident.resume,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementLeft],
        [kASF_CELL_TITLE:NSDate.printDate(incident.dateCreation),kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:NSDate.printDate(incident.dateModification),kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:incident.nbRelance,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter]
      ]
      
      //Options
      let rowOptions = [kASF_OPTION_BACKGROUND : UIColor.whiteColor(), kASF_OPTION_CELL_PADDING : 5, kASF_OPTION_CELL_BORDER_COLOR : UIColor.lightGrayColor(),kASF_OPTION_CELL_TEXT_FONT_SIZE : 8]
      
      let row = [kASF_ROW_ID: String(index),kASF_ROW_CELLS:rows,kASF_ROW_OPTIONS : rowOptions]
      
      rowArray.append(row)
    }
    
    customTableView.setRows(rowArray)
  }
}
