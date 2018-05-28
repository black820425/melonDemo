//
//  BiometricViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/7.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit
import LocalAuthentication

class BiometricViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    if(UserDefaults.standard.bool(forKey: "BiometricSetQuickBool")) {
      
      let locationAuth = LAContext()
      var authError: NSError?
      
      if locationAuth.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
        
        locationAuth.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: LanguageTool.sharedInstance().customzieLocalizedString(key: "BiometricViewController_PleaseVerifyYourFingerprintTitle", commit: "")) { (success, evaluatePolicyError) in
          if success {
            
            let alertController = UIAlertController.init(title: LanguageTool.sharedInstance().customzieLocalizedString(key: "BiometricViewController_SuccessLoginTitle", commit: ""), message: "", preferredStyle: .alert)
            
            let confirm = UIAlertAction.init(title: LanguageTool.sharedInstance().customzieLocalizedString(key: "ConfirmTitle", commit: ""), style: .default) { (action) in
              
              Singleton.sharedInstance().setTestLogin(bool: true)
              NotificationCenter.default.post(name: NSNotification.Name.init("TestLoginSuccess"), object: nil)
              NotificationCenter.default.post(name: NSNotification.Name.init("TestLoginSuccessToPopLoginView"), object: nil)
              
              self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(confirm)
            self.present(alertController, animated: true, completion: nil)
            
            
          } else {
            switch evaluatePolicyError?.localizedDescription {
            case "Biometry is locked out.":
              self.setAlertViewContrllerOfTitle(title:LanguageTool.sharedInstance().customzieLocalizedString(key: "BiometricViewController_TouchIDIsLockedTitle", commit: ""),
                message:LanguageTool.sharedInstance().customzieLocalizedString(key: "BiometricViewController_PleaseGoToSettingsAndSelectTouchIDAndPasswordToUnlockThePasswordMessage", commit: ""))
              break
              
            case "Application retry limit exceeded.":
              
              self.setAlertViewContrllerOfTitle(title:LanguageTool.sharedInstance().customzieLocalizedString(key: "BiometricViewController_MoreThanRetriesTitle", commit: ""),message:"")
              break
              
            default:
              print("error message --> \(String(describing: evaluatePolicyError?.localizedDescription)))")
              //self.setAlertViewContrllerOfTitle(title:(evaluatePolicyError?.localizedDescription)!,message:"")
              break
            }
          }
        }
        
      }else {
        if #available(iOS 11.0, *) {
          switch authError?.code {
          case LAError.biometryLockout.rawValue:
            setAlertViewContrllerOfTitle(
              title:LanguageTool.sharedInstance().customzieLocalizedString(key: "BiometricViewController_TouchIDIsLockedTitle", commit: ""),
              message:LanguageTool.sharedInstance().customzieLocalizedString(key: "BiometricViewController_PleaseGoToSettingsAndSelectTouchIDAndPasswordToUnlockThePasswordMessage", commit: ""))
            break
            
          case LAError.biometryNotEnrolled.rawValue:
            setAlertViewContrllerOfTitle(title: LanguageTool.sharedInstance().customzieLocalizedString(key: "BiometricViewController_NoFingerprintIdentificationTitle", commit: ""), message: "")
            break
            
          case LAError.passcodeNotSet.rawValue:
            setAlertViewContrllerOfTitle(title: LanguageTool.sharedInstance().customzieLocalizedString(key: "BiometricViewController_NoPasswordSetTitle", commit: ""), message: "")
            break
          default:
            break
          }
          
        } else {
          switch authError?.code {
          case LAError.touchIDLockout.rawValue:
            break
          case LAError.touchIDNotEnrolled.rawValue:
            break
          case LAError.passcodeNotSet.rawValue:
            break
          default:
            break
          }
        }
        print("authError message --> \(String(describing: authError?.debugDescription))")
      }
      
    } else {
      setAlertViewContrllerOfTitle(title: LanguageTool.sharedInstance().customzieLocalizedString(key: "FirstLoginWithoutSetQuickAlertTitle", commit: ""), message: "")
    }
   
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //..
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
