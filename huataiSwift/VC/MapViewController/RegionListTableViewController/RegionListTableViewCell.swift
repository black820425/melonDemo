//
//  RegionListTableViewCell.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/17.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class RegionListTableViewCell: UITableViewCell {

  @IBOutlet weak var branchNameTitleLabel: UILabel!
  @IBOutlet weak var branchAddTitleLabel: UILabel!
  @IBOutlet weak var branchPhoneNumTitleLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
