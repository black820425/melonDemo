//
//  QuickLoginSettingTableViewCell.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/11.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
  
  @IBOutlet weak var customizeTitleLabel: UILabel!
  
  @IBOutlet weak var customizeSwitch: UISwitch!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
