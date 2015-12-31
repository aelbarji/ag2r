//
//  PieChartViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 15/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController,ChartViewDelegate{

    
    var chartView : PieChartView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        chartView = PieChartView.init(frame: self.view.frame)
        chartView.delegate = self
        chartView.usePercentValuesEnabled = true
        chartView.holeTransparent = true
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.descriptionText = ""
        chartView.setExtraOffsets(left: 5.0, top:10.0 , right: 5.0, bottom: 5.0)
        
        chartView.drawCenterTextEnabled = true
        
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
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0.0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let l : ChartLegend = chartView.legend
        l.position = .RightOfChart
        l.xEntrySpace = 7.0
        l.yEntrySpace = 0.0
        l.yOffset = 0.0
        
       // _sliderX.value = 3.0;
       // _sliderY.value = 100.0;
        //[self slidersValueChanged:nil];
        //4 type de valeur et sur une echelle de 100%
        self.setDataCount(3, range: 100.0)
        
        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .EaseOutBack)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDataCount(count :Int ,range : Double){
        
        let mult:Double = range
        var parties = ["Party A", "Party B", "Party C"]
        
        var yVals1 = [ChartDataEntry]()
        
        // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
        for var i = 0; i < count; ++i {
            let random = Double(arc4random_uniform(UInt32(mult + mult/5)))
            let barChartDataEntry = BarChartDataEntry.init(value: random, xIndex: i)
            yVals1.append(barChartDataEntry)
        }
        
        var xVals = [String]()
        for var i = 0; i < count; ++i {
            let party = parties[i % parties.count]
            xVals.append(party)
        }
        
      
        let dataSet = PieChartDataSet.init(yVals: yVals1, label: "Etats Changements")
        dataSet.sliceSpace = 2.0;
        
        // add a lot of colors

        var colors = [UIColor]()
        colors.appendContentsOf(ChartColorTemplates.vordiplom())
        colors.appendContentsOf(ChartColorTemplates.joyful())
        colors.appendContentsOf(ChartColorTemplates.colorful())
        colors.appendContentsOf(ChartColorTemplates.liberty())
        colors.appendContentsOf(ChartColorTemplates.pastel())
        let uiColorFromRGB: ColorHelper = ColorHelper()
        colors.append(uiColorFromRGB.UIColorFromRGB(0x33B5E5))
        
        dataSet.colors = colors;
        
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
        data.setValueTextColor(UIColor.whiteColor())
        
        chartView.data = data
        chartView.highlightValues(nil)

        
    }

    //MARK: ChartViewController
    
     func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("chartValueSelecter")
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }
}
