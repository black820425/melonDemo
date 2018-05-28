//
//  SettingLangueTableViewCell.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/25.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class SettingLangueTableViewCell: UITableViewCell {
  
  @IBOutlet weak var customizeImageView: UIImageView!
  
  
  @IBOutlet weak var customizeTitleLabel: UILabel!
  
  @IBOutlet weak var currentLanguageTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
