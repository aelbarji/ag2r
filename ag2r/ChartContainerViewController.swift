//
//  ChartContainerViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 15/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit

class ChartContainerViewController: UIViewController {
    
    var selectedSegue : String!
    var pieChartViewController : PieChartViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         self.performSegueWithIdentifier(self.selectedSegue, sender: self)
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
        if segue.identifier == "pieChart"{
            self.pieChartViewController = segue.destinationViewController as? PieChartViewController
            
            
        }
        if segue.identifier == "pieChart"{
            self.displayContentController(self.pieChartViewController!)
            
            
        }
    }
    
    func displayContentController(content: UIViewController) {
        self.addChildViewController(content)
        
        content.view.frame = self.view.frame
        
        self.view.addSubview(content.view)
        
        content.didMoveToParentViewController(self)
        
    }

}
