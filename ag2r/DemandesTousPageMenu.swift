//
//  DemandesTousPageMenu.swift
//  ag2r
//
//  Created by Ayoub El barji on 21/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import Charts

class DemandesTousPageMenu: UIViewController , ChartViewDelegate{


    @IBOutlet var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setCharts()
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
    
    
    //MARK: Chart View
    func setCharts() {
        
        // Line Chart view
        chartView = LineChartView.init(frame: self.chartView.frame)
        //        chartView.autoresizingMask = .FlexibleRightMargin
        chartView.delegate = self
        //        chartView.autoresizingMask = .FlexibleWidth
        chartView.descriptionText = ""
        chartView.noDataTextDescription = "You need to provide data for the chart."
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        
        chartView.drawGridBackgroundEnabled = false
        chartView.pinchZoomEnabled = true
        
        chartView.legend.form = .Line
        chartView.legend.font = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 11.0)!
        chartView.legend.textColor = UIColor.whiteColor()
        chartView.legend.position = .RightOfChart
        
        let xAxis :ChartXAxis = chartView.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.labelFont = UIFont.systemFontOfSize(12.0)
        xAxis.labelTextColor = UIColor.whiteColor()
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.spaceBetweenLabels = 1
        
        let leftAxis:ChartYAxis = chartView.leftAxis
        leftAxis.labelTextColor = UIColor.whiteColor()
        leftAxis.customAxisMax = 200.0
        leftAxis.drawGridLinesEnabled = true
        
        
        let rightAxis : ChartYAxis = chartView.rightAxis
        rightAxis.labelFont = UIFont.systemFontOfSize(10.0)
        rightAxis.labelTextColor = UIColor.redColor()
        rightAxis.customAxisMax = 900.0
        rightAxis.startAtZeroEnabled = false
        rightAxis.customAxisMin = -200.0
        rightAxis.drawGridLinesEnabled = false
        
        
        self.setDataCount(10, range: 100.0)
        
        
        chartView.animate(xAxisDuration: 2.5, yAxisDuration: 2.5)
        self.view.addSubview(chartView)
        
    }
    
    func setDataCount(count :Int ,range : Double){
        
        var xVals = [String]()
        
        for var i = 0; i < count; ++i {
            xVals.append(String(i))
        }
        
        var yVals1 = [ChartDataEntry]()
        // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
        for var i = 0; i < count; ++i {
            let mult = range / 2.0
            let val = Double(arc4random_uniform(UInt32(mult)) + 50)
            let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
            yVals1.append(barChartDataEntry)
        }
        
        //Bar chart View
        let lineChartDataSet1 = LineChartDataSet(yVals: yVals1, label: "OBS")
        lineChartDataSet1.axisDependency = .Left
        lineChartDataSet1.setColor(UIColor.greenColor())
        lineChartDataSet1.setCircleColor(UIColor.whiteColor())
        lineChartDataSet1.lineWidth = 2.0
        lineChartDataSet1.circleRadius = 3.0
        lineChartDataSet1.fillAlpha = 65/255.0
        lineChartDataSet1.fillColor = UIColor.greenColor()
        lineChartDataSet1.highlightColor = UIColor.init(red: 244/255.0, green: 117/255.0, blue: 117/225.0, alpha: 1.0)
        lineChartDataSet1.drawCircleHoleEnabled = false
        
        
        var yVals2 = [ChartDataEntry]()
        
        for var i = 0; i < count; ++i {
            let mult = range
            let val = Double(arc4random_uniform(UInt32(mult)) + 450)
            let barChartDataEntry = ChartDataEntry.init(value: val, xIndex: i)
            yVals2.append(barChartDataEntry)
        }
        
        //Bar chart View
        let lineChartDataSet2 = LineChartDataSet(yVals: yVals2, label: "MAILS")
        lineChartDataSet2.axisDependency = .Right
        lineChartDataSet2.setColor(UIColor.redColor())
        lineChartDataSet2.setCircleColor(UIColor.whiteColor())
        lineChartDataSet2.lineWidth = 2.0
        lineChartDataSet2.circleRadius = 3.0
        lineChartDataSet2.fillAlpha = 65/255.0
        lineChartDataSet2.fillColor = UIColor.redColor()
        lineChartDataSet2.highlightColor = UIColor.init(red: 244/255.0, green: 117/255.0, blue: 117/225.0, alpha: 1.0)
        lineChartDataSet2.drawCircleHoleEnabled = false
        
        var dataSets = [LineChartDataSet]()
        dataSets.append(lineChartDataSet1)
        dataSets.append(lineChartDataSet2)
        
        let lineChartData = LineChartData(xVals: xVals, dataSets: dataSets)
        lineChartData.setValueFont(UIFont.init(name: "HelveticaNeue-CondensedBold", size: 10.0))
        lineChartData.setValueTextColor(UIColor.whiteColor())
        
        chartView.data = lineChartData
        
        
    }
    
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("chartValueSelecter")
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }
    


}
