//
//  CreditCardPublicTextFieldTableViewCell.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/9.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class CreditCardPublicTextFieldTableViewCell: UITableViewCell {
  
  @IBOutlet weak var customizeTitleLabel: UILabel!
  
  @IBOutlet weak var customizeTextField: UITextField!
  
  @IBOutlet weak var customizeBackgroundImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
