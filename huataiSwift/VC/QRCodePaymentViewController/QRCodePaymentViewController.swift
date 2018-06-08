//
//  QRCodePaymentViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/7.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class QRCodePaymentViewController: UIViewController {
  
  var sixSec = 0
  var timer: Timer!
  
  @IBOutlet weak var backgroundView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    backgroundView.layer.cornerRadius = 4.0
    navigationController?.navigationBar.topItem?.title = ""
    navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_com_Left_pressed")
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_com_Left_pressed")
    
    NotificationCenter.default.addObserver(self, selector: #selector(TestSingOutSuccess), name: NSNotification.Name(rawValue: "TestSignOutSuccess"), object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationItem.title = LanguageTool.sharedInstance().customzieLocalizedString(key: "NavigaitonControllerTitle_QRCodePaymentTitle", commit: "")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    if(!Singleton.sharedInstance().getTestLogin()) {
      
      if let viewController = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
        self.navigationController?.pushViewController(viewController, animated: true)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  @objc func TestSingOutSuccess() {
    if let viewController = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
      self.navigationController?.pushViewController(viewController, animated: true)
    }
  }
  
  @IBAction func scanPaymentButtonAction(_ sender: Any) {
    performSegue(withIdentifier: "scan", sender: nil)
  }
  
  
  @IBAction func barcodeReceiptButtonAction(_ sender: Any) {
    performSegue(withIdentifier: "bar", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "scan" {
      let destination = segue.destination as! QRCodeScanViewController
      destination.hidesBottomBarWhenPushed = true
    } else if segue.identifier == "bar" {
      let destination = segue.destination as! QRCodeBarViewController
      destination.hidesBottomBarWhenPushed = true
    }
  }
  
}
