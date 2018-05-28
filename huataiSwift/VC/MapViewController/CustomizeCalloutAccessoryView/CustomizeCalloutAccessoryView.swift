//
//  TestView.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/18.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class CustomizeCalloutAccessoryView: UIView {
  
  @IBOutlet var contentView: UIView!
  
  @IBOutlet weak var branchTitleLabel: UILabel!
  
  @IBOutlet weak var addressTitleLabel: UILabel!
  
  @IBOutlet weak var phoneNumberTitleLabel: UILabel!
  
  @IBOutlet weak var distanceTitleLabel: UILabel!
  
  @IBOutlet weak var pinImageView: UIImageView!
  
  @IBOutlet weak var routeButton: UIButton!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("CustomizeCalloutAccessoryView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
  }
  
  /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
