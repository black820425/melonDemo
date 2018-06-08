//
//  ActionCertificationViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/29.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class ActionCertificationViewController: UIViewController {
  
  @IBOutlet weak var deviceTokenTextField: UITextField!
  
  @IBOutlet weak var otpCodeLabel: UILabel!
  @IBOutlet weak var confirmButton: UIButton!
  @IBOutlet weak var ppTextField: UITextField!
  @IBOutlet weak var cutomizeTitleLabel: UILabel!
  
  let vaktenManager = VaktenManager.sharedInstance()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    //print(VaktenManager.sharedInstance().p_GetClientAPI())
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func associationBtnPressed(_ sender: Any) {
    vaktenManager?.associationOperation(withAssociationCode: ppTextField.text, complete: { (resultCode) in
      print("resultCode --> \(resultCode.rawValue)")
      let title = "Message"
      var message = ""
      
      if(VIsSuccessful(resultCode)) {
        message = "Success"
        
      } else {
        message = "\(resultCode.rawValue) <-- Failure"
      }
      
      self.setAlertViewContrllerOfTitle(title: title, message: message)
    })
  }
  
  @IBAction func authenticateBtnPressed(_ sender: Any) {
    vaktenManager?.authenticateOperation(withSessionID: "tester", complete: { (resultCode) in
      print("resultCode --> \(resultCode.rawValue)")
      let title = "Message"
      var message = ""
      
      if(VIsSuccessful(resultCode)) {
        message = "Success"
        
      } else {
        message = "\(resultCode.rawValue) <-- Failure"
      }
      
      self.setAlertViewContrllerOfTitle(title: title, message: message)
    })
  }
  
  
  @IBAction func taskBtnPressed(_ sender: Any) {
    VaktenManager.sharedInstance().getTasksOperation { (resultCode, tasks) in
      if(VIsSuccessful(resultCode)) {
        print("Load task Successful --> \(String(describing: tasks))")
        
      } else {
        print("Load task failed. Error --> \(resultCode.rawValue)")
        
      }
    }
  }
  
  
  @IBAction func otpBtnPressed(_ sender: Any) {
    let otp = VaktenManager.sharedInstance().generateGeoOTPCode()
    print("resultCode --> \(String(describing: otp?.resultCode.rawValue))")
    print("OTPCode --> \(String(describing: otp?.otp))")
    if(VIsSuccessful((otp?.resultCode)!)) {
      otpCodeLabel.text = otp?.otp
      
    } else {
      switch otp?.resultCode.rawValue {
      case 207:
        otpCodeLabel.text = "Error VResultCodeGeoOTPNotInitialized"
        break
      case 206:
        otpCodeLabel.text = "Error VResultCodeNoLocation"
        break
      default:
        otpCodeLabel.text = String(format: "%d", (otp?.resultCode.rawValue)!)
        break
      }
    }
    
    if let DeviceTokenString = UserDefaults.standard.object(forKey: "DeviceTokenString") as? String {
      deviceTokenTextField.text = DeviceTokenString
    } else {
      deviceTokenTextField.text = "未取得DeviceToken"
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    ppTextField.resignFirstResponder()
  }
  
  func setAlertViewContrllerOfTitle(title:String, message:String) {
    
    let customAlertViewController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
    
    let okAlertAction = UIAlertAction.init(title: LanguageTool.sharedInstance().customzieLocalizedString(key: "ConfirmTitle", commit: ""), style: .default) { (action) in }
    
    customAlertViewController.addAction(okAlertAction)
    present(customAlertViewController, animated: true, completion: nil)
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
