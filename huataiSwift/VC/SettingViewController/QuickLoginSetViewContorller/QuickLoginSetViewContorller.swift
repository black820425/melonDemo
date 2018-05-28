//
//  QuickLoginSettingViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/11.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit
import LocalAuthentication


class QuickLoginSetViewContorller: UIViewController {
  
  @IBOutlet weak var settingTableView: UITableView!
  
  private var headerTitleArray = [String]()
  private var graphicPWSetContentArray = [String]()
  private var fingerSetContentArray = [String]()
  private var FaceIDSetContentArray = [String]()
  
  private let locationAuth = LAContext()
  private var authError: NSError?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    prepareLanuageChange()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = LanguageTool.sharedInstance().customzieLocalizedString(key: "NavigaitonControllerTitle_QuickLoginSettingTitle", commit: "")
    
    settingTableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  @IBAction func switchButtonAction(_ sender: Any) {
    
    let customizeSwitch = sender as! UISwitch
    
    var storyboard: UIStoryboard
    switch customizeSwitch.tag {
    case 0:
      if(customizeSwitch.isOn) {
        
        storyboard = UIStoryboard.init(name: "SettingViewController", bundle: nil)
        let gestureUnlockSettingViewController = storyboard.instantiateViewController(withIdentifier: "GestureUnlockSettingViewController")
        navigationController?.pushViewController(gestureUnlockSettingViewController, animated: true)
        
      } else {
        UserDefaults.standard.removeObject(forKey: "confirmSelectArray")
        UserDefaults.standard.synchronize()
        
      }
      break
    default:
      if(customizeSwitch.isOn) {
        
        if locationAuth.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
          UserDefaults.standard.set(true, forKey: "BiometricSetQuickBool")
          UserDefaults.standard.synchronize()
          
        } else {
          customizeSwitch.isOn = false
          
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
          
        }
        
      } else {
        UserDefaults.standard.set(false, forKey: "BiometricSetQuickBool")
        UserDefaults.standard.synchronize()
      }
    }
    
  }
  
  
  @IBAction func popButtonAction(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  func prepareLanuageChange() {
    headerTitleArray = [
      LanguageTool.sharedInstance().customzieLocalizedString(key: "QuickLoginSetViewContorller_GraphicPasswordTitle", commit: ""),
      LanguageTool.sharedInstance().customzieLocalizedString(key: "QuickLoginSetViewContorller_UseFingerprintRecognitionTitle", commit: ""),
      LanguageTool.sharedInstance().customzieLocalizedString(key: "QuickLoginSetViewContorller_UseFaceIDTitle", commit: "")]
    
    graphicPWSetContentArray = [
      LanguageTool.sharedInstance().customzieLocalizedString(key: "QuickLoginSetViewContorller_GraphicPWSetAndChangeTitle", commit: ""),
      LanguageTool.sharedInstance().customzieLocalizedString(key: "QuickLoginSetViewContorller_UseGraphicPWTitle", commit: "")]
    
    fingerSetContentArray = [
      LanguageTool.sharedInstance().customzieLocalizedString(key: "QuickLoginSetViewContorller_SetFingerRecognitionTitle", commit: ""),
      LanguageTool.sharedInstance().customzieLocalizedString(key: "QuickLoginSetViewContorller_UseFingerRecognitionTitle", commit: "")]
    
    FaceIDSetContentArray = [
      LanguageTool.sharedInstance().customzieLocalizedString(key: "QuickLoginSetViewContorller_SetFaceIDTitle", commit: ""),
      LanguageTool.sharedInstance().customzieLocalizedString(key: "QuickLoginSetViewContorller_UseFaceIDTitle", commit: "")]
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  func setAlertViewContrllerOfTitle(title:String, message:String) {
    
    let customAlertViewController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
    
    let okAlertAction = UIAlertAction.init(title: LanguageTool.sharedInstance().customzieLocalizedString(key: "ConfirmTitle", commit: ""), style: .default) { (action) in }
    
    customAlertViewController.addAction(okAlertAction)
    present(customAlertViewController, animated: true, completion: nil)
  }
  
}

extension QuickLoginSetViewContorller: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "QuickLoginSettingTableViewCell") as! SettingTableViewCell
    
    switch indexPath.section {
    case 0:
      if(UserDefaults.standard.object(forKey: "confirmSelectArray") != nil) {
        cell.customizeSwitch.isOn = true
      } else {
        cell.customizeSwitch.isOn = false
      }
      
      if(indexPath.row == 0) {
        cell.customizeSwitch.isHidden = true
      }
      cell.customizeTitleLabel.text = graphicPWSetContentArray[indexPath.row]
      cell.customizeSwitch.tag = 0
      
      break
    default:
      
      if(UserDefaults.standard.bool(forKey: "BiometricSetQuickBool")) {
        
        if locationAuth.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
          cell.customizeSwitch.isOn = true
          
        } else {
          cell.customizeSwitch.isOn = false
          UserDefaults.standard.set(false, forKey: "BiometricSetQuickBool")
          UserDefaults.standard.synchronize()
        }
        
      } else {
        cell.customizeSwitch.isOn = false
      }
      
      
      if(indexPath.row == 0) {
        cell.customizeSwitch.isHidden = true
      }
      cell.customizeTitleLabel.text = fingerSetContentArray[indexPath.row]
      cell.customizeSwitch.tag = 1
      break
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    var storyboard: UIStoryboard
    switch indexPath.section {
    case 0:
      if(indexPath.row == 0) {
        storyboard = UIStoryboard.init(name: "SettingViewController", bundle: nil)
        let gestureUnlockSettingViewController = storyboard.instantiateViewController(withIdentifier: "GestureUnlockSettingViewController")
        navigationController?.pushViewController(gestureUnlockSettingViewController, animated: true)
      }
      break
    default:
      if(indexPath.row == 0) {
        guard let url = URL(string: UIApplicationOpenSettingsURLString) else {
          return
        }
        
        UIApplication.shared.open(url ,options: [:], completionHandler: nil)
      }
      break
    }
  }
}

extension QuickLoginSetViewContorller: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: settingTableView.bounds.size.width, height: 40))
    headerView.backgroundColor = Singleton.sharedInstance().getThemColorR250xG250xB250()
    
    let customizeLabel = UILabel.init(frame: CGRect(x: 28, y: 0, width: 100, height: 50))
    customizeLabel.font = UIFont(name: "PingFangTC-Medium", size: 14.0)
    customizeLabel.textColor = Singleton.sharedInstance().getThemeColorR113xG113xB113()
    
    headerView.addSubview(customizeLabel)
    
    switch section {
    case 0:
      customizeLabel.text = headerTitleArray[section]
      break
    default:
      customizeLabel.text = headerTitleArray[section]
      break
    }
    
    return headerView
  }
  
}
