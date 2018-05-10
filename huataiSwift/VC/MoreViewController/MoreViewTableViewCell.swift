//
//  MoreViewTableViewCell.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/8.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class MoreViewTableViewCell: UITableViewCell {

  @IBOutlet weak var customizeImageView: UIImageView!
  
  @IBOutlet weak var customizeTitleLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
