//
//  BiometricsViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/7.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit
import LocalAuthentication

class QuickLoginViewController: UIViewController {
  
  @IBOutlet weak var biometricsButton: UIButton!
  @IBOutlet weak var graphicLockButton: UIButton!
  
  var quickLoginViewPageViewController: QuickLoginViewPageViewController!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareButtonRadious()
  }
  
  override func viewWillAppear(_ animated: Bool) {

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func biometricButtonAction(_ sender: Any) {
    
    let button = sender as! UIButton
    quickLoginViewPageViewController.showPage(index: button.tag)

    biometricsButton.backgroundColor = Singleton.sharedInstance().getThemeColorR224xG224xB224()
    graphicLockButton.backgroundColor = .clear
  }
  
  @IBAction func grpahicLockButtonAction(_ sender: Any) {
    let button = sender as! UIButton
    quickLoginViewPageViewController.showPage(index: button.tag)

    graphicLockButton.backgroundColor = Singleton.sharedInstance().getThemeColorR224xG224xB224()
    biometricsButton.backgroundColor = .clear
  }
  
  func prepareButtonRadious() {
    biometricsButton.layer.borderWidth = 1
    biometricsButton.layer.cornerRadius = 15.5
    biometricsButton.layer.borderColor = Singleton.sharedInstance().getThemeColorR151xG151xB151().cgColor
    graphicLockButton.layer.borderWidth = 1
    graphicLockButton.layer.cornerRadius = 15.5
    graphicLockButton.layer.borderColor = Singleton.sharedInstance().getThemeColorR151xG151xB151().cgColor
  }
  
  // MARK: - Navigation
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if(segue.identifier == "QuickLoginViewPageViewSegue") {
      quickLoginViewPageViewController = segue.destination as! QuickLoginViewPageViewController
    }
  }
  
  
}
