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
    
    self.delegate = self
    self.preferredPrimaryColumnWidthFraction = 0.06

  }
  
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

