//
//  DetailViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 03/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import Charts
import Calendar_iOS

class DetailViewController: UIViewController, ChartViewDelegate {
    

    @IBOutlet var titleLabelChart: UILabel!
    @IBOutlet var number: UILabel!
    @IBOutlet var numberTitle: UILabel!
    @IBOutlet var titleLabel: UILabel!
    var selectedSegue : String!
    var chartContainerViewController : ChartContainerViewController?
    var pageMenuViewController : PageMenuViewController?
    
    @IBOutlet var pieChartLabel: UILabel!
    @IBOutlet var horizontalChartView: HorizontalBarChartView!
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet var tableauDeBord: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   //     print(self.selectedSegue)
//        self.performSegueWithIdentifier(self.selectedSegue!, sender: nil)
       
        
        //MARK: - CALENDAR
        let calendarView : CalendarView = CalendarView.init(position: 10.0, y: 40.0)
        calendarView.shouldShowHeaders = true
        calendarView.refresh()
        self.tableauDeBord.addSubview(calendarView)
        
        // CHARTS
        self.pieChartLabel.text = "États"
        self.titleLabelChart.text = "Priorités"
        self.setCharts()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.titleLabel.text = self.selectedSegue?.capitalizedString
        self.numberTitle.text = self.selectedSegue?.capitalizedString
        
        switch self.selectedSegue{
        case "changements":
            self.number.text = "44"
            break
        case "incidents" :
            self.number.text = "12"
            break
        case "demandes" :
            self.number.text = "9"
            break
            
        default : break
        }
        
        //self.performSegueWithIdentifier(self.selectedSegue, sender: self)
        
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
        
        if (self.selectedSegue != nil){
        if segue.identifier == "embeddedContainer"{
            self.pageMenuViewController = segue.destinationViewController as? PageMenuViewController
         //   if self.selectedSegue == nil{
//                self.pageMenuViewController!.selectedSegue = "changements"
        //    }else
         //   {
                self.pageMenuViewController!.selectedSegue = self.selectedSegue
          //  }
            
            
        }
        }else{
            if segue.identifier == "embeddedContainer"{
          self.pageMenuViewController = segue.destinationViewController as? PageMenuViewController
            //   if self.selectedSegue == nil{
            //    self.containerViewController!.selectedSegue = "changements"
            //    }else
            //   {
            self.pageMenuViewController!.selectedSegue = "changements"
            }
        }
        /*
        if segue.identifier == "embeddedChart"{
            self.chartContainerViewController = segue.destinationViewController as? ChartContainerViewController
            self.chartContainerViewController!.selectedSegue = "pieChart"
        }
*/


    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
    }
    
    //MARK: Status Bar Color
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK: Chart View
    func setCharts() {
        
        // pie Chart view
        pieChartView = PieChartView.init(frame: self.pieChartView.frame)
        pieChartView.delegate = self
        pieChartView.usePercentValuesEnabled = true
        pieChartView.holeTransparent = true
        pieChartView.holeRadiusPercent = 0.58
        pieChartView.transparentCircleRadiusPercent = 0.61
        pieChartView.descriptionText = ""
        pieChartView.setExtraOffsets(left: 5.0, top:10.0 , right: 5.0, bottom: 5.0)
       // pieChartView.drawCenterTextEnabled = true
        
        //ADD TEXT IN CENTER
        /*
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"iOS Charts\nby Daniel Cohen Gindi"];
        [centerText setAttributes:@{
        NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f],
        NSParagraphStyleAttributeName: paragraphStyle
        } range:NSMakeRange(0, centerText.length)];
        [centerText addAttributes:@{
        NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f],
        NSForegroundColorAttributeName: UIColor.grayColor
        } range:NSMakeRange(10, centerText.length - 10)];
        [centerText addAttributes:@{
        NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:10.f],
        NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
        } range:NSMakeRange(centerText.length - 19, 19)];
        _chartView.centerAttributedText = centerText;
        */
        
        
        pieChartView.drawHoleEnabled = true
        pieChartView.rotationAngle = 0.0
        pieChartView.rotationEnabled = true
        pieChartView.highlightPerTapEnabled = true
        pieChartView.legend.enabled = false
        pieChartView.holeColor = UIColor.init(red: 40.0/255, green: 40.0/255, blue: 40.0/255, alpha: 1.0)
        /*
        let l : ChartLegend = pieChartView.legend
        l.position = .PiechartCenter
        l.xEntrySpace = 7.0
        l.yEntrySpace = 1.0
        l.yOffset = 4.0
        l.textColor = UIColor.blackColor()
*/
    
        // _sliderX.value = 3.0;
        // _sliderY.value = 100.0;
        //[self slidersValueChanged:nil];
        //4 type de valeur et sur une echelle de 100%
        
        // Bar Chart View
        horizontalChartView = HorizontalBarChartView.init(frame: self.horizontalChartView.frame)
        horizontalChartView.autoresizingMask = .FlexibleHeight
        horizontalChartView.delegate = self
        
        horizontalChartView.descriptionText = "";
        horizontalChartView.noDataTextDescription = "You need to provide data for the chart."
        
        horizontalChartView.drawBarShadowEnabled = false
        horizontalChartView.drawValueAboveBarEnabled = true
        
        horizontalChartView.maxVisibleValueCount = 60
        horizontalChartView.pinchZoomEnabled = false
        horizontalChartView.drawGridBackgroundEnabled = false
        
        let xAxis :ChartXAxis = horizontalChartView.xAxis
        xAxis.labelPosition = .Bottom
        xAxis.labelFont = UIFont.systemFontOfSize(10.0)
        xAxis.labelTextColor = UIColor.whiteColor()
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = true
        xAxis.gridLineWidth = 0.3
        
        let leftAxis:ChartYAxis = horizontalChartView.leftAxis
        /*
        leftAxis.labelFont = UIFont.systemFontOfSize(10.0)
        leftAxis.labelTextColor = UIColor.whiteColor()
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.gridLineWidth = 0.3
*/
        leftAxis.enabled = false
        
        
        let rightAxis : ChartYAxis = horizontalChartView.rightAxis
        rightAxis.labelFont = UIFont.systemFontOfSize(10.0)
        rightAxis.labelTextColor = UIColor.whiteColor()
        rightAxis.drawAxisLineEnabled = true
        rightAxis.drawGridLinesEnabled = true
        rightAxis.gridLineWidth = 0.3
        
        horizontalChartView.legend.enabled = false
        /*
        horizontalChartView.legend.position = .BelowChartLeft
        horizontalChartView.legend.form = .Square
        horizontalChartView.legend.formSize = 8.0
        horizontalChartView.legend.font = UIFont.init(name: "HelveticaNeue-CondensedBold", size: 11.0)!
        horizontalChartView.legend.textColor = UIColor.whiteColor()
        horizontalChartView.legend.xEntrySpace = 4.0
        */
        
        
        self.setDataCount(3, range: 100.0)
        
        
        pieChartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .EaseOutBack)
        horizontalChartView.animate(yAxisDuration: 2.5)
        self.tableauDeBord.addSubview(pieChartView)
        self.tableauDeBord.addSubview(horizontalChartView)
        
    }
    
    func setDataCount(count :Int ,range : Double){
        
        var mult:Double = range
        var parties = ["Faible", "Moyen", "Fort"]
        var etats = ["Nouveau","En attente","Résolu","Clos","En cours","Affecté"]
        
        var yVals1 = [ChartDataEntry]()
        var yVals2 = [ChartDataEntry]()
        
        // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
        for var i = 0; i < 6; ++i {
            let random = Double(arc4random_uniform(UInt32(mult + mult/5)))
            let barChartDataEntry = BarChartDataEntry.init(value: random, xIndex: i)
            yVals1.append(barChartDataEntry)
        }
        
        for var i = 0; i < count; ++i {
            mult = mult + 1
            let val = Double(arc4random_uniform(UInt32(mult)))
            let barChartDataEntry = BarChartDataEntry.init(value: val, xIndex: i)
            yVals2.append(barChartDataEntry)
        }
        
        var xVals1 = [String]()
        
        for var i = 0; i < 6; ++i {
            let etat = etats[i % etats.count]
            xVals1.append(etat)
        }
        var xVals2 = [String]()
        for var i = 0; i < count; ++i {
            let party = parties[i % parties.count]
            xVals2.append(party)
        }
        
        // PieChart View
        let dataSet = PieChartDataSet.init(yVals: yVals1, label: "")
        dataSet.sliceSpace = 2.0;
        // add a lot of colors
        
        var colors = [UIColor]()
//        colors.appendContentsOf(ChartColorTemplates.vordiplom())
//        colors.appendContentsOf(ChartColorTemplates.joyful())
        colors.appendContentsOf(ChartColorTemplates.colorful())
//        colors.appendContentsOf(ChartColorTemplates.liberty())
        colors.appendContentsOf(ChartColorTemplates.pastel())
/*        let uiColorFromRGB: ColorHelper = ColorHelper()
        colors.append(uiColorFromRGB.UIColorFromRGB(0x33B5E5))
        */
        colors.append(UIColor.redColor())
        dataSet.colors = colors;
        
        
        let data : PieChartData = PieChartData.init(xVals: xVals1, dataSet: dataSet)
        let pFormatter:NSNumberFormatter = NSNumberFormatter.init()
        pFormatter.numberStyle = .PercentStyle
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1.0
        pFormatter.percentSymbol = "%"
        data.setValueFormatter(pFormatter)
        data.setValueFont(UIFont.init(name: "HelveticaNeue", size: 8.0))
        data.setValueTextColor(UIColor.whiteColor())
        
        pieChartView.data = data
        pieChartView.highlightValues(nil)
        
        //Bar chart View
        let horizontalChartDataSet = BarChartDataSet(yVals: yVals2, label: "Priorité")
        horizontalChartDataSet.barSpace = 0.35
        var horizontalColors = [UIColor]()
        horizontalColors.appendContentsOf(ChartColorTemplates.vordiplom())
        horizontalChartDataSet.colors = horizontalColors
        let horizontalChartData = BarChartData(xVals: xVals2, dataSet: horizontalChartDataSet)
        horizontalChartData.setValueFormatter(pFormatter)
        horizontalChartData.setValueFont(UIFont.init(name: "HelveticaNeue-CondensedBold", size: 10.0))
        horizontalChartData.setValueTextColor(UIColor.whiteColor())
        horizontalChartView.data = horizontalChartData
        
        
    }
    
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("chartValueSelecter")
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }


}
