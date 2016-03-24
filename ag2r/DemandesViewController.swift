//
//  DemandesViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 21/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import RealmSwift
import Calendar_iOS

class DemandesViewController: UIViewController {
  
  weak var delegate:ActionMenuDelegate?
  
  var demandeArray : Results<Demande>!
  var filtredDemandeArray : Results<Demande>!
  @IBOutlet var customTableView: ASFTableView!
  @IBOutlet var detailsView: UIView!
  @IBOutlet var lblNbrDemandes: UILabel!
  @IBOutlet var lblDemandes: UILabel!
  
  @IBOutlet var lblMails: UILabel!
  @IBOutlet var lblObs: UILabel!
  @IBOutlet var lblNbrMailsCriticite: UILabel!
  @IBOutlet var lblNbrObsCriticite: UILabel!
  
  @IBOutlet var lblMailEtats: UILabel!
  @IBOutlet var lblNbrMailClosed: UILabel!
  @IBOutlet var lblNbrMailCanceled: UILabel!
  @IBOutlet var lblNbrMailSchld: UILabel!
  @IBOutlet var lblNbrMailPrg: UILabel!
  @IBOutlet var lblNbrMailKo: UILabel!
  @IBOutlet var lblNbrMailDelayed: UILabel!
  @IBOutlet var lblNbrMailComing: UILabel!
 
  
  
  @IBOutlet var lblObsEtats: UILabel!
  @IBOutlet var lblNbrObsClosed: UILabel!
  @IBOutlet var lblNbrObsCanceled: UILabel!
  @IBOutlet var lblNbrObsSchld: UILabel!
  @IBOutlet var lblNbrObsPrg: UILabel!
  @IBOutlet var lblNbrObsKo: UILabel!
  @IBOutlet var lblNbrObsDelayed: UILabel!
  @IBOutlet var lblNbrObsComing: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    //labels colors
    self.lblDemandes.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
    self.lblNbrDemandes.textColor = UIColor.init(red: 79.0/255, green: 164.0/255, blue: 32.0/255, alpha: 1.0)
    
    self.lblMails.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblNbrMailsCriticite.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblObs.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblNbrObsCriticite.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    
    //Mails lables color
    self.lblMailEtats.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblNbrMailComing.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblNbrMailCanceled.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblNbrMailSchld.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblNbrMailPrg.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblNbrMailKo.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblNbrMailClosed.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    self.lblNbrMailDelayed.textColor = UIColor.init(red: 189/255.0, green: 207/255.0, blue: 65/225.0, alpha: 1.0)
    
    //OBS Labels color
    self.lblObsEtats.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblNbrObsComing.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblNbrObsCanceled.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblNbrObsSchld.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblNbrObsPrg.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblNbrObsKo.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblNbrObsClosed.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    self.lblNbrObsDelayed.textColor = UIColor.init(red: 246.0/255, green: 242.0/255, blue: 164.0/255, alpha: 1.0)
    // Do any additional setup after loading the view.
    
    self.customTableView.layer.cornerRadius = 5.0
    self.detailsView.layer.cornerRadius = 5.0
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTable:",name:"reload", object: nil)
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    let array:[Demande] = demandeArray.map { $0 }
    self.addASFTableView(array)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    var obsArray = [Demande]()
    var mailArray = [Demande]()
    
    if let dataArray = filtredDemandeArray{
      
      self.lblNbrDemandes.text = String(dataArray.count)
      obsArray = dataArray.filter {
        $0.type.rangeOfString("obs", options: .CaseInsensitiveSearch) != nil
      }
       mailArray = dataArray.filter {
        $0.type.rangeOfString("mail", options: .CaseInsensitiveSearch) != nil
      }
      
    }else{
      self.lblNbrDemandes.text = String(demandeArray.count)
      
      obsArray = demandeArray.filter {
        $0.type.rangeOfString("obs", options: .CaseInsensitiveSearch) != nil
      }
      mailArray = demandeArray.filter {
        $0.type.rangeOfString("mail", options: .CaseInsensitiveSearch) != nil
      }
    }
    
    let mailCritArray = mailArray.filter {
      $0.criticite.rangeOfString("Impératif", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrMailsCriticite.text = String(mailCritArray.count)
    
    let obsCritArray = obsArray.filter {
      $0.criticite.rangeOfString("Impératif", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrObsCriticite.text = String(obsCritArray.count)
    
    let mailComingArray = mailArray.filter {
      $0.etat.rangeOfString("A venir", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrMailComing.text = String(mailComingArray.count)
    let mailCanceledArray = mailArray.filter {
      $0.etat.rangeOfString("Annulé", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrMailCanceled.text = String(mailCanceledArray.count)
    let mailSchedArray = mailArray.filter {
      $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrMailSchld.text = String(mailSchedArray.count)
    let mailProgArray = mailArray.filter {
      $0.etat.rangeOfString("En cours", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrMailPrg.text = String(mailProgArray.count)
    let mailKoArray = mailArray.filter {
      $0.etat.rangeOfString("Ko", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrMailKo.text = String(mailKoArray.count)
    let mailClosedArray = mailArray.filter {
      $0.etat.rangeOfString("Ok", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrMailClosed.text = String(mailClosedArray.count)
    let mailDelayedArray = mailArray.filter {
      $0.etat.rangeOfString("Retard", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrMailDelayed.text = String(mailDelayedArray.count)
    
    let obsComingArray = obsArray.filter {
       $0.etat.rangeOfString("A venir", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrObsComing.text = String(obsComingArray.count)
    
    let obsCanceledArray = obsArray.filter {
      $0.etat.rangeOfString("Annulé", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrObsCanceled.text = String(obsCanceledArray.count)
    let obsSchedArray = obsArray.filter {
      $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrObsSchld.text = String(obsSchedArray.count)
    
    let obsProgArray = obsArray.filter {
      $0.etat.rangeOfString("En cours", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrObsPrg.text = String(obsProgArray.count)
    
    let obsKoArray = obsArray.filter {
      $0.etat.rangeOfString("Ko", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrObsKo.text = String(obsKoArray.count)
    let obsClosedArray = obsArray.filter {
      $0.etat.rangeOfString("Ok", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrObsClosed.text = String(obsClosedArray.count)
    let obsDelayedArray = obsArray.filter {
      $0.etat.rangeOfString("Retard", options: .CaseInsensitiveSearch) != nil
    }
    self.lblNbrObsDelayed.text = String(obsDelayedArray.count)
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    // Commit frames' updates
    //     self.leftChartView.commitCalendarViewUpdate()
    //    self.rightChartView.commitMenuViewUpdate()
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  func reloadTable(notification: NSNotification){
    //load data here
    // First try to cast user info to expected type
    if let info = notification.userInfo as? Dictionary<String,NSDate> {
      // Check if value present before using it
      let date = info["date"]
      let dateNext = info["dateNext"]
      print(date)
      filtredDemandeArray = uiRealm.objects(Demande).filter("heureRealisation >= %@ AND heureRealisation < %@", date! ,dateNext!).sorted("heureRealisation", ascending: false)
      let array:[Demande] = filtredDemandeArray.map({$0})
      self.addASFTableView(array)
      self.viewDidAppear(true)
    }
    
  }
  
  //MARK: - FILTER ACTIONS
  @IBAction func filterComDmdAction() {
    var comingArray = [Demande]()
    if (filtredDemandeArray != nil){
     comingArray  = filtredDemandeArray.filter {
      $0.etat.rangeOfString("A venir", options: .CaseInsensitiveSearch) != nil
    }
    }else{
      comingArray  = demandeArray.filter {
        $0.etat.rangeOfString("A venir", options: .CaseInsensitiveSearch) != nil
      }
    }
    self.addASFTableView(comingArray)
  }
  
  @IBAction func filterSchedDmdAction() {
    var scheduledArray = [Demande]()
    if (filtredDemandeArray != nil){
      scheduledArray  = filtredDemandeArray.filter {
        $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
      }
    }else{
      scheduledArray  = demandeArray.filter {
        $0.etat.rangeOfString("Affecté", options: .CaseInsensitiveSearch) != nil
      }
    }
    self.addASFTableView(scheduledArray)
  }
  
  @IBAction func filterProgDmdAction() {
    var progressArray = [Demande]()
    if (filtredDemandeArray != nil){
      progressArray  = filtredDemandeArray.filter {
        $0.etat.rangeOfString("En cours", options: .CaseInsensitiveSearch) != nil
      }
    }else{
      progressArray  = demandeArray.filter {
        $0.etat.rangeOfString("En cours", options: .CaseInsensitiveSearch) != nil
      }
      
    }
    self.addASFTableView(progressArray)
  }
  
  @IBAction func filterClosedDmdAction() {
    var okArray = [Demande]()
    if (filtredDemandeArray != nil){
     okArray  = filtredDemandeArray.filter {
      $0.etat.rangeOfString("Ok", options: .CaseInsensitiveSearch) != nil
    }
    }else{
      okArray  = demandeArray.filter {
        $0.etat.rangeOfString("Ok", options: .CaseInsensitiveSearch) != nil
      }
    }
    self.addASFTableView(okArray)
  }
  
  @IBAction func filterDelayedDmdAction() {
    var delayedArray = [Demande]()
    if (filtredDemandeArray != nil){
      delayedArray  = filtredDemandeArray.filter {
      $0.etat.rangeOfString("Retard", options: .CaseInsensitiveSearch) != nil
    }
    }else{
       delayedArray  = demandeArray.filter {
        $0.etat.rangeOfString("Retard", options: .CaseInsensitiveSearch) != nil
      }
    }
    self.addASFTableView(delayedArray)
  }
  
  @IBAction func filterCanceledDmdAction() {
    var canceledArray = [Demande]()
    if (filtredDemandeArray != nil){
      canceledArray  = filtredDemandeArray.filter {
        $0.etat.rangeOfString("Annulé", options: .CaseInsensitiveSearch) != nil
      }
    }else{
      canceledArray  = demandeArray.filter {
        $0.etat.rangeOfString("Annulé", options: .CaseInsensitiveSearch) != nil
      }
    }
    self.addASFTableView(canceledArray)
  }
  
  @IBAction func filterKoDmdAction() {
    var koArray = [Demande]()
    if (filtredDemandeArray != nil){
      koArray  = filtredDemandeArray.filter {
        $0.etat.rangeOfString("Ko", options: .CaseInsensitiveSearch) != nil
      }
    }else{
      koArray  = demandeArray.filter {
        $0.etat.rangeOfString("Ko", options: .CaseInsensitiveSearch) != nil
      }
    }
    self.addASFTableView(koArray)
  }
  
  @IBAction func showAllDmdAction() {

    if (filtredDemandeArray != nil){
      self.addASFTableView(filtredDemandeArray.map({$0}))
    }else{
      self.addASFTableView(demandeArray.map({$0}))
    }
    
    self.viewDidAppear(true)
  }

  @IBAction func filterImperatifAction() {
    var imperatifArray = [Demande]()
    if (filtredDemandeArray != nil){
      imperatifArray  = filtredDemandeArray.filter {
        $0.criticite.rangeOfString("Impératif", options: .CaseInsensitiveSearch) != nil
      }
    }else{
      imperatifArray  = demandeArray.filter {
        $0.criticite.rangeOfString("Impératif", options: .CaseInsensitiveSearch) != nil
      }
    }
    self.addASFTableView(imperatifArray)

  }
  
  
}

//MARK: - extension protocol
extension DemandesViewController : ASFTableViewDelegate{
  
  func addASFTableView(dataArray : [Demande]){
    
    let cols = ["ID","Type","Nom","Criticité", "État", "Description", "Environnement","Heure de réception","Heure de réalisation","Émetteur", "Numéro OBS"]
    let weights = [(0.05),(0.05),(0.1),(0.1),(0.1),(0.15),(0.1),(0.1),(0.1),(0.1),(0.05)]
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
    
    for (index, demande) in dataArray.enumerate() {
      
      let rows = [
        [kASF_CELL_TITLE:demande.idDemande, kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:demande.type, kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:demande.nom,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementLeft],
        [kASF_CELL_TITLE:demande.criticite,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:demande.etat.demLocalized,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:demande.des,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementLeft],
        [kASF_CELL_TITLE:demande.environnement,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:NSDate.printDate(demande.heureReception),kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:NSDate.printDate(demande.heureRealisation),kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:demande.emetteur,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter],
        [kASF_CELL_TITLE:demande.numOBS,kASF_OPTION_CELL_TEXT_ALIGNMENT :textAlignementCenter]
      ]
      
      //Options
      let rowOptions = [kASF_OPTION_BACKGROUND : UIColor.whiteColor(), kASF_OPTION_CELL_PADDING : 5, kASF_OPTION_CELL_BORDER_COLOR : UIColor.lightGrayColor(),kASF_OPTION_CELL_TEXT_FONT_SIZE : 8]
      
      let row = [kASF_ROW_ID: String(index),kASF_ROW_CELLS:rows,kASF_ROW_OPTIONS : rowOptions]
      
      rowArray.append(row)
    }
    
    customTableView.setRows(rowArray)
  }
}

extension String {
    var demLocalized: String {
      return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
  }
}


