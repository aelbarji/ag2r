//
//  MenuTableViewCell.swift
//  ag2r
//
//  Created by Ayoub El barji on 06/01/2016.
//  Copyright © 2016 Groupehn. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet var menuLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        /*
        if selected{
        let customColorView = UIView()
        customColorView.backgroundColor = UIColor.init(red: 0, green: 185, blue: 228, alpha: 1)
        self.selectedBackgroundView =  customColorView;
        }
        */
    }
}
