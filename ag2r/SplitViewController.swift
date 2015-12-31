//
//  SplitViewController.swift
//  ag2r
//
//  Created by Ayoub El barji on 03/12/2015.
//  Copyright © 2015 Groupehn. All rights reserved.
//

import UIKit
import Crashlytics


class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Crashlitics
  /*      let button = UIButton(type: UIButtonType.RoundedRect)
        button.frame = CGRectMake(20, 50, 100, 30)
        button.setTitle("Crash", forState: UIControlState.Normal)
        button.addTarget(self, action: "crashButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
*/
        // Do any additional setup after loading the view.
        let view = UIView(frame:
            CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0)
        )
        view.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(view)
        configureSplitVC()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureSplitVC() {
        // Set up split view delegate
//        let splitVC = self.childViewControllers[0] as! UISplitViewController
        self.delegate = self
        self.preferredPrimaryColumnWidthFraction = 0.05
//        let navVC = self.childViewControllers.last as! UINavigationController
//        navVC.topViewController!.navigationItem.leftBarButtonItem = self.displayModeButtonItem()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK: - Crashlitics
    /*
    @IBAction func crashButtonTapped(sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }
*/

}
