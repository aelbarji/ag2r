//
//  ChangementsViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 21/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import RealmSwift

class ChangementsViewController: UIViewController {
  
  var delegate : ActionMenuDelegate?
  var changementArray : Results<Changement>!
  var filtredChangementArray : Results<Changement>!
  
  @IBOutlet var bottomChartView: ASFTableView!
  @IBOutlet var detailView: UIView!
  
  @IBOutlet var lblNbrChangemnts: UILabel!
  @IBOutlet var lblChangements: UILabel!
  
  @IBOutlet var lblNbrNewEtat: UILabel!
  @IBOutlet var lblNbrWtgEtat: UILabel!
  @IBOutlet var lblNbrSchldEtat: UILabel!
  @IBOutlet var lblNbrAssignedEtat: UILabel!
  @IBOutlet var lblNbrPrgEtat: UILabel!
  @IBOutlet var lblNbrResEtat: UILabel!
  @IBOutlet var lblNbrClosedEtat: UILabel!
  
  @IBOutlet var lblNbrPriorite: UILabel!
  
  var changEtatAssignArray : [Changement]!
  var changEtatInProgArray : [Changement]!
  var changEtatClosedArray : [Changement]!
  var changEtatSchedArray : [Changement]!
  var changEtatNewArray : [Changement]!
  var changEtatResProgArray : [Changement]!
  var changEtatPendArray : [Changement]!
  var changPrioArray : [Changement]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bottomChartView.layer.cornerRadius = 5.0
    self.detailView.layer.cornerRadius = 5.0
    // Labels colors
    self.lblChangements.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    self.lblNbrChangemnts.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    self.lblNbrNewEtat.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    self.lblNbrWtgEtat.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
     self.lblNbrAssignedEtat.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    self.lblNbrSchldEtat.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    self.lblNbrPrgEtat.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    self.lblNbrResEtat.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    self.lblNbrPriorite.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    self.lblNbrClosedEtat.textColor = UIColor.init(red: 45.0/255, green: 165.0/255, blue: 255.0/255, alpha: 1.0)
    
    // Do any additional setup after loading the view.
     NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable:",name:"reload", object: nil)
    
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    let array:[Changement] = changementArray.map { $0 }
    self.addASFTableView(array)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    var dataArray = [Changement]()
    
    if (filtredChangementArray != nil){
      dataArray = filtredChangementArray.map { $0 }
    }else{
      dataArray = changementArray.map { $0 }
    }

    //Lables details view
    self.lblNbrChangemnts.text = String(dataArray.count)
    //Changements filtred Etats
    changEtatAssignArray = dataArray.filter {
      $0.etat.rangeOfString("Assign", options: .CaseInsensitiveSearch) != nil
    }
    changEtatInProgArray = dataArray.filter {
      $0.etat.rangeOfString("WorkInProgress", options: .CaseInsensitiveSearch) != nil
    }
    changEtatClosedArray = dataArray.filter {
      $0.etat.rangeOfString("Closed", options: .CaseInsensitiveSearch) != nil
    }
    changEtatSchedArray = dataArray.filter {
      $0.etat.rangeOfString("Sched", options: .CaseInsensitiveSearch) != nil
    }
    changEtatNewArray = dataArray.filter {
      $0.etat.rangeOfString("New", options: .CaseInsensitiveSearch) != nil
    }
    changEtatResProgArray = dataArray.filter {
      $0.etat.rangeOfString("Resol", options: .CaseInsensitiveSearch) != nil
    }
    changEtatPendArray = dataArray.filter {
      $0.etat.rangeOfString("Pending", options: .CaseInsensitiveSearch) != nil
    }
    
    //ETATS
    self.lblNbrNewEtat.text = String(changEtatNewArray.count)
    self.lblNbrWtgEtat.text = String(changEtatPendArray.count)
    self.lblNbrAssignedEtat.text = String(changEtatAssignArray.count)
    self.lblNbrSchldEtat.text = String(changEtatSchedArray.count)
    self.lblNbrPrgEtat.text = String(changEtatInProgArray.count)
    self.lblNbrResEtat.text = String(changEtatResProgArray.count)
    self.lblNbrClosedEtat.text = String(changEtatClosedArray.count)
    
    //Priorité
    changPrioArray = dataArray.filter {
      $0.priorite.rangeOfString("Urgent", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrPriorite.text = String(changPrioArray.count)
    
   
    
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
      filtredChangementArray = uiRealm.objects(Changement).filter("debut >= %@ AND debut < %@", date! ,dateNext!).sorted("debut", ascending: false)
      let array:[Changement] = filtredChangementArray.map({$0})
      self.addASFTableView(array)
      self.viewDidAppear(true)
    }
    
  }
  
  //MARK: - FILTER ACTION
  @IBAction func filterNewAction() {

    self.addASFTableView(changEtatNewArray)
  }
  @IBAction func filterWaintingAction() {
    self.addASFTableView(changEtatPendArray)
  }
  @IBAction func filterScheduledAction() {
    self.addASFTableView(changEtatSchedArray)
  }
  @IBAction func filterAssignedAction() {
    self.addASFTableView(changEtatAssignArray)
  }
  @IBAction func filterProgAction() {
    self.addASFTableView(changEtatInProgArray)
  }
  @IBAction func filterResolvedAction() {
    self.addASFTableView(changEtatResProgArray)
  }
  @IBAction func filterClosedAction() {
    self.addASFTableView(changEtatClosedArray)
  }
  @IBAction func showAllChangements() {
    if (filtredChangementArray != nil){
      self.addASFTableView(filtredChangementArray.map({$0}))
    }else{
      self.addASFTableView(changementArray.map({$0}))
    }
    
    self.viewDidAppear(true)

  }
  
  @IBAction func filterCritiqueAction() {
    self.addASFTableView(changPrioArray)
  }
  
}

//MARK: - extension protocol
extension ChangementsViewController : ASFTableViewDelegate{
  
  func addASFTableView(dataArray : [Changement]){
    
    let cols = ["ID Changement","Resumé","Priorité","État","Date début","Date fin","Demandeur", "Valideur"]
    let weights = [(0.1),(0.3),(0.1),(0.1),(0.1),(0.1),(0.1),(0.1)]
    let options = [kASF_OPTION_CELL_TEXT_FONT_SIZE : 10,
      kASF_OPTION_CELL_TEXT_FONT_BOLD : true,
      kASF_OPTION_CELL_BORDER_COLOR : UIColor.lightGrayColor(),
      kASF_OPTION_CELL_BORDER_SIZE : 2.0,
      kASF_OPTION_BACKGROUND : UIColor.init(red: 239/255.0, green: 244/255.0, blue: 254/255.0, alpha: 1.0)]
    
    bottomChartView.delegate = self
    bottomChartView.setBounces(false)
    bottomChartView.setSelectionColor(UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0))
    bottomChartView.setTitles(cols, withWeights: weights, withOptions: options, witHeight: 32, floating: true)
    
    var rowArray = [AnyObject]()
    let textAlignementCenter = NSTextAlignment.Center.rawValue
    let textAlignementLeft = NSTextAlignment.Left.rawValue
    
    for (index, changement) in dataArray.enumerate() {
      
      let rows = [[kASF_CELL_TITLE:changement.id_changement, kASF_OPTION_CELL_TEXT_ALIGNMENT : textAlignementCenter],
        [kASF_CELL_TITLE:changement.resume, kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementLeft],
        [kASF_CELL_TITLE:changement.priorite.changLocalized, kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:changement.etat.changLocalized,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:NSDate.printDate(changement.debut),kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:NSDate.printDate(changement.fin),kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:changement.demandeur,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:changement.valideur,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter]
      ]
      
      //Options
      let rowOptions = [kASF_OPTION_BACKGROUND : UIColor.whiteColor(), kASF_OPTION_CELL_PADDING : 5, kASF_OPTION_CELL_BORDER_COLOR : UIColor.lightGrayColor(),kASF_OPTION_CELL_TEXT_FONT_SIZE : 10]
      
      let row = [kASF_ROW_ID: String(index),kASF_ROW_CELLS:rows,kASF_ROW_OPTIONS : rowOptions]
      
      rowArray.append(row)
    }
    
    bottomChartView.setRows(rowArray)
  }
}


extension String {
  var changLocalized: String {
    return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
  }
}
