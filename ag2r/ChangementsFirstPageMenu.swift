//
//  ChangementsFirstPageMenu.swift
//  ag2r
//
//  Created by Ayoub El barji on 21/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import RealmSwift

class ChangementsFirstPageMenu: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let contentCellIdentifier = "ContentCellIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!
    var changementArray : Results<Changement>!
    var columnsLabels : NSArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView .registerNib(UINib(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: contentCellIdentifier)
        self.collectionView.autoresizingMask = .FlexibleLeftMargin
        self.view.addSubview(self.collectionView)
        columnsLabels = ["ID Changement","Resumé","Priorité","État","Date de début","Date de fin","Demandeur", "Valideur"]
     
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.updateTableView()
    }
    
    func updateTableView() {
        changementArray = uiRealm.objects(Changement).sorted("debut", ascending: true)
  //      changementArray = uiRealm.objects(Changement)
        //  self.taskListsTableView.setEditing(false, animated: true)
//        self.colonneTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return changementArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnsLabels.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
                let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(contentCellIdentifier, forIndexPath: indexPath) as! ContentCollectionViewCell
                contentCell.contentLabel.font = UIFont.systemFontOfSize(13)
                contentCell.contentLabel.textColor = UIColor.whiteColor()
                contentCell.contentLabel.text = (columnsLabels[indexPath.row] as! String)
                contentCell.backgroundColor = UIColor.blackColor()
                return contentCell
           
        } else {
            let itemIndex = indexPath.section - 1
            let changement = changementArray![itemIndex]
            
            let contentCell : ContentCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier(contentCellIdentifier, forIndexPath: indexPath) as! ContentCollectionViewCell
            contentCell.contentLabel.font = UIFont.systemFontOfSize(13)
            contentCell.contentLabel.textColor = UIColor.blackColor()
            
            switch indexPath.row{
            case 0 :
                contentCell.contentLabel.text = changement.id_changement
                break
            case 1 :
                contentCell.contentLabel.text = changement.resume
                break
            case 2 :
                contentCell.contentLabel.text = changement.priorite
                break
            case 3 :
                contentCell.contentLabel.text = changement.etat
                break
            case 4 :
                contentCell.contentLabel.text = self.printDate(changement.debut)
                break
            case 5 :
                contentCell.contentLabel.text = self.printDate(changement.fin)
                break
            case 6 :
                contentCell.contentLabel.text = changement.demandeur
                break
            case 7 :
                contentCell.contentLabel.text = changement.valideur
                break
            default: break
            }
            
            if indexPath.section % 2 != 0 {
                contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            } else {
                contentCell.backgroundColor = UIColor.whiteColor()
            }
            
            return contentCell
        }
        
    }
    //MARK: - Date Formatter
    func printDate(date:NSDate)->String{
        
        let formatter = NSDateFormatter()
        let frDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "en-FR"))
        //gbDateFormat now contains an optional string "dd/MM/yyyy"
        formatter.dateFormat = frDateFormat
        let frSwiftDayString = formatter.stringFromDate(date)
        // gbSwiftDayString now contains the string "02/06/2014".
        return frSwiftDayString
    }

}
