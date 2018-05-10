//
//  QRCodePaymentViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/7.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class QRCodePaymentViewController: UIViewController {
  
  @IBOutlet weak var backgroundView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    backgroundView.layer.cornerRadius = 4.0
    navigationController?.navigationBar.topItem?.title = ""
    navigationController?.navigationBar.backIndicatorImage = UIImage(named: "ic_com_Left_pressed")
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "ic_com_Left_pressed")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationItem.title = NSLocalizedString("NavigationControllerQRCodePaymentTitle", comment: "")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    if(!Singleton.sharedInstance().getTestLogin()) {
      if let viewController = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
        if let navigator = navigationController {
          navigator.pushViewController(viewController, animated: true)
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func scanPaymentButtonAction(_ sender: Any) {
    
  }
  
  
  @IBAction func barcodeReceiptButtonAction(_ sender: Any) {
    
  }
  
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
