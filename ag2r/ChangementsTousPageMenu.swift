//
//  ChangementsTousPageMenu.swift
//  ag2r
//
//  Created by Ayoub El barji on 21/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import Charts

class ChangementsTousPageMenu: UIViewController, ChartViewDelegate {

    @IBOutlet var chartView: HorizontalBarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCharts()
        // Do any additional setup after loading the view.
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
    func setCharts() {
        
        let customFormatter:NSNumberFormatter = NSNumberFormatter.init()
        customFormatter.negativePrefix = ""
        customFormatter.positiveSuffix = ""
        customFormatter.negativeSuffix = ""
        customFormatter.minimumSignificantDigits = 1
        customFormatter.minimumFractionDigits = 1
        // Line Chart view
        chartView = HorizontalBarChartView.init(frame: self.chartView.frame)
        chartView.delegate = self
        
        chartView.descriptionText = ""
        chartView.noDataTextDescription = "You need to provide data for the chart."
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        
        chartView.pinchZoomEnabled = true
        
        chartView.leftAxis.enabled = false
        chartView.rightAxis.startAtZeroEnabled = false
        chartView.rightAxis.customAxisMax = 10.0
        chartView.rightAxis.customAxisMin = -10.0
        chartView.rightAxis.labelCount = 9
        chartView.rightAxis.valueFormatter = customFormatter
        chartView.rightAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
        
        let xAxis :ChartXAxis = chartView.xAxis
        xAxis.labelPosition = .BothSided
        xAxis.labelFont = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 9.0)!
        xAxis.labelTextColor = UIColor.whiteColor()
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        
        chartView.legend.formSize = 8.0
        chartView.legend.formToTextSpace = 4.0
        chartView.legend.xEntrySpace = 6.0
        chartView.legend.font = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 11.0)!
        chartView.legend.textColor = UIColor.whiteColor()
        chartView.legend.position = .RightOfChart
        
        let leftAxis:ChartYAxis = chartView.leftAxis
        leftAxis.labelTextColor = UIColor.whiteColor()
        
        let rightAxis : ChartYAxis = chartView.rightAxis
        rightAxis.labelTextColor = UIColor.whiteColor()
        /*
        
        let rightAxis : ChartYAxis = chartView.rightAxis
        rightAxis.labelFont = UIFont.systemFontOfSize(10.0)
        rightAxis.labelTextColor = UIColor.redColor()
        rightAxis.customAxisMax = 900.0
        rightAxis.startAtZeroEnabled = false
        rightAxis.customAxisMin = -200.0
        rightAxis.drawGridLinesEnabled = false
        */
        
        self.setData(customFormatter)
        
        
        chartView.animate(yAxisDuration: 2.5)
        self.view.addSubview(chartView)
        
    }
    
    func setData(customFormatter : NSNumberFormatter){
        
        
        let xVals = ["Faible","Moyen", "Fort"]
        
        
        var yVals1 = [ChartDataEntry]()
        // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
        yVals1.append(BarChartDataEntry.init(values: [-8,9], xIndex: 0))
        yVals1.append(BarChartDataEntry.init(values: [-5,3], xIndex: 1))
        yVals1.append(BarChartDataEntry.init(values: [-2,7], xIndex: 2))
        
        
        //Bar chart View
        let barChartDataSet = BarChartDataSet(yVals: yVals1, label: "Statistiques Environnements")
        barChartDataSet.axisDependency = .Right
        barChartDataSet.valueFont = UIFont.systemFontOfSize(7.0)
        barChartDataSet.valueFormatter = customFormatter
        barChartDataSet.barSpace = 0.4
        barChartDataSet.stackLabels = ["Techniques","Applicatifs"]
        barChartDataSet.colors = [ UIColor.init(red: 26/255.0, green: 188/255.0, blue: 156/225.0, alpha: 1.0),UIColor.init(red: 241/255.0, green: 196/255.0, blue: 15/225.0, alpha: 1.0)]
        
        
        let barChartData = BarChartData(xVals: xVals, dataSet: barChartDataSet)
        barChartData.setValueFont(UIFont.init(name: "HelveticaNeue-CondensedBold", size: 10.0))
        barChartData.setValueTextColor(UIColor.blackColor())
        
        chartView.data = barChartData
        chartView.setNeedsDisplay()
        
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("chartValueSelecter")
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }

}
