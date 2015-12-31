//
//  IncidentsTousPageMenu.swift
//  ag2r
//
//  Created by Ayoub El barji on 21/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import Charts

class IncidentsTousPageMenu: UIViewController, ChartViewDelegate {

    
    @IBOutlet var leftChartView: RadarChartView!
    @IBOutlet var rightChartView: RadarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setChartsLeft()
        self.setChartsRight()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Chart View Controller
    func setChartsLeft() {
        
        // Line Chart view
        let frame : CGRect = leftChartView.frame;
        /*
        if chartView == leftChartView{
        frame.origin.x = (self.view.frame.size.width - frame.size.width) / 2.0
        }else{
        frame.origin.x = frame.size.width + (frame.size.width / 2.0)
        }
        */
        leftChartView = RadarChartView.init(frame: frame)
//        leftChartView.autoresizingMask = .FlexibleWidth
        leftChartView.delegate = self
        
        leftChartView.descriptionText = "Incicents Techniques"
        
        leftChartView.descriptionTextColor = ChartColorTemplates.vordiplom()[2]
        leftChartView.descriptionFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 12.0)!
        
        leftChartView.webLineWidth = 0.75
        leftChartView.innerWebLineWidth = 0.375
        leftChartView.webAlpha = 1.0
        
        let marker : BalloonMarker = BalloonMarker.init(color: UIColor.init(white: 180/255.0, alpha: 1.0), font: UIFont.systemFontOfSize(12.0), insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
        
        marker.minimumSize = CGSizeMake(80.0, 40.0)
        leftChartView.marker = marker
        
        let xAxis :ChartXAxis = leftChartView.xAxis
        xAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
        xAxis.labelTextColor = UIColor.whiteColor()
        
        
        let yAxis:ChartYAxis = leftChartView.yAxis
        yAxis.labelTextColor = UIColor.whiteColor()
        yAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
        yAxis.labelCount = 5
        yAxis.startAtZeroEnabled = true
        
        
        let l : ChartLegend = leftChartView.legend
        l.enabled = false
        /*
        l.yEntrySpace = 5.0
        l.xEntrySpace = 7.0
        l.font = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 10.0)!
        l.textColor = UIColor.whiteColor()
        l.position = .BelowChartCenter
        */
        leftChartView.data = self.setData("left")
        
        
        leftChartView.spin(duration: 1.5, fromAngle: 0.0, toAngle: 90.0)
        self.view.addSubview(leftChartView)
        
    }
    
    func setChartsRight() {
        
        // Line Chart view
        let frame : CGRect = rightChartView.frame;
        
        //        frame.origin.x = (frame.size.width / 2.0)
        
        rightChartView = RadarChartView.init(frame: frame)
//        rightChartView.autoresizingMask = .FlexibleWidth
        rightChartView.delegate = self
        
        rightChartView.descriptionText = "Incicents Applicatifs"
        rightChartView.descriptionTextColor = ChartColorTemplates.vordiplom()[3]
        rightChartView.descriptionFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 12.0)!
        
        rightChartView.webLineWidth = 0.75
        rightChartView.innerWebLineWidth = 0.375
        rightChartView.webAlpha = 1.0
        
        let marker : BalloonMarker = BalloonMarker.init(color: UIColor.init(white: 180/255.0, alpha: 1.0), font: UIFont.systemFontOfSize(12.0), insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
        
        marker.minimumSize = CGSizeMake(80.0, 40.0)
        rightChartView.marker = marker
        
        let xAxis :ChartXAxis = rightChartView.xAxis
        xAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
        xAxis.labelTextColor = UIColor.whiteColor()
        
        
        let yAxis:ChartYAxis = rightChartView.yAxis
        yAxis.labelTextColor = UIColor.whiteColor()
        yAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
        yAxis.labelCount = 5
        yAxis.startAtZeroEnabled = true
        
        
        let l : ChartLegend = rightChartView.legend
        l.enabled = false
        /*
        l.yEntrySpace = 5.0
        l.xEntrySpace = 7.0
        l.font = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 10.0)!
        l.textColor = UIColor.whiteColor()
        l.position = .BelowChartCenter
        */
        rightChartView.data = self.setData("right")
        
        
        rightChartView.spin(duration: 1.5, fromAngle: 0.0, toAngle: 90.0)
        self.view.addSubview(rightChartView)
        
    }
    
    
    func setData(currentView : String)->RadarChartData{
        
        let mult:Double = 30.0
        let count:Int = 6
        var parties = ["Nouveau","En attente","Résolu","Clos","En cours","Affecté"]
        
        
        
        var yVals1 = [ChartDataEntry]()
        var yVals2 = [ChartDataEntry]()
        // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
        for var i = 0; i < count; ++i {
            let val = Double(arc4random_uniform(UInt32(mult))) + mult / 2
            let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
            yVals1.append(barChartDataEntry)
            yVals2.append(barChartDataEntry)
        }
        
        var xVals = [String]()
        for var i = 0; i < count; ++i {
            let party = parties[i % parties.count]
            xVals.append(party)
        }
        
        //Bar chart View
        let radarChartData : RadarChartData!
        
        if currentView == "left"{
            let radarChartDataSet1 = RadarChartDataSet(yVals: yVals1, label: "Incidents Techniques")
            radarChartDataSet1.setColor(ChartColorTemplates.vordiplom()[2])
            radarChartDataSet1.drawFilledEnabled = true
            radarChartDataSet1.lineWidth = 2.0
            radarChartData = RadarChartData(xVals: xVals, dataSet: radarChartDataSet1)
        }else{
            
            let radarChartDataSet2 = RadarChartDataSet(yVals: yVals2, label: "Incidents Applicatifs")
            radarChartDataSet2.setColor(ChartColorTemplates.vordiplom()[3])
            radarChartDataSet2.drawFilledEnabled = true
            radarChartDataSet2.lineWidth = 2.0
            radarChartData = RadarChartData(xVals: xVals, dataSet: radarChartDataSet2)
        }
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
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("chartValueSelecter")
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }

}
