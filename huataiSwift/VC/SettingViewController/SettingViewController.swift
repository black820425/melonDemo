//
//  SettingViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/24.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
  
  var didselectPickBool = true
  
  var pickerView = UIPickerView()
  var myTextField = UITextField()
  var pickerViewDataArray = [String]()
  private var contentArray = [String]()
  private var imageNameArray = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if(Singleton.sharedInstance().getTestLogin()) {
      imageNameArray = ["設定_通知","設定_快登","設定_語系"]
      contentArray = [
        LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_NotificationSettingTitle", commit: ""),
        LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_QuickLoginSetTitle", commit: ""),
        LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_LanguageChangeTitle", commit: "")]
  
    } else {
      imageNameArray = ["設定_通知","設定_語系"]
      contentArray = [
        LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_NotificationSettingTitle", commit: ""),
        LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_LanguageChangeTitle", commit: "")]
    }
  
    setPcikerViewAndToolBar()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func popButtonAction(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  func getCurrentLanguage() -> String {
    
    if(LanguageTool.sharedInstance().currentLanguage() != nil) {
      
      let currnetLanuage = LanguageTool.sharedInstance().currentLanguage()
      if(currnetLanuage == "zh-Hant") {
        return LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_ChineseTraditionalTitle", commit: "")
        
      } else if(currnetLanuage == "zh-Hants") {
        return LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_ChineseSimplifiedTitle", commit: "")
        
      } else {
        return LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_EnglishTitle", commit: "")
      }
      
    } else {
      return LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_ChineseTraditionalTitle", commit: "")
    }
  }
  
  func setPcikerViewAndToolBar() {
    pickerView.delegate = self
    pickerView.dataSource = self
    pickerViewDataArray = [
      LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_ChineseTraditionalTitle", commit: ""),
      LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_ChineseSimplifiedTitle", commit: ""),
      LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_EnglishTitle", commit: "")]
    
    myTextField.inputView = pickerView;
    self.view.addSubview(myTextField)
    
    let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
    toolBar.barTintColor = Singleton.sharedInstance().getThemeColorR226xG75xB91()
    
    let fiexbleSpaceButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    
    let doneButton = UIBarButtonItem.init(title:LanguageTool.sharedInstance().customzieLocalizedString(key: "FinishTitle", commit: ""), style: .done, target: self, action: #selector(doneToSearchRegion))
    doneButton.tintColor = .white
    
    let cancelButton = UIBarButtonItem.init(title:LanguageTool.sharedInstance().customzieLocalizedString(key: "CancelTitle", commit: ""), style: .done, target: self, action: #selector(cancelSearchRegion))
    cancelButton.tintColor = .white
    
    toolBar.setItems([cancelButton,fiexbleSpaceButton,doneButton], animated: true)
    
    myTextField.inputAccessoryView = toolBar
    
  }
  
  @objc func doneToSearchRegion() {
    myTextField.resignFirstResponder()
    
    if(didselectPickBool) {
      LanguageTool.sharedInstance().setLanguage(language: "zh-Hant")
    }
  
    UserDefaults.standard.set(true, forKey: "ChangeLanguageBool")
    UserDefaults.standard.synchronize()
    
    navigationController?.popViewController(animated: true)
  }
  
  @objc func cancelSearchRegion() {
    myTextField.resignFirstResponder()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    myTextField.resignFirstResponder()
  }
}

extension SettingViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contentArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let settingLangueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SettingLangueTableViewCell") as! SettingLangueTableViewCell
    let settingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as! SettingTableViewCell

      if(indexPath.row == contentArray.count-1) {
        
        settingLangueTableViewCell.customizeImageView.image = UIImage(named: imageNameArray[indexPath.row])
        settingLangueTableViewCell.customizeTitleLabel.text = contentArray[indexPath.row]
        settingLangueTableViewCell.currentLanguageTitleLabel.text = getCurrentLanguage()
        
        return settingLangueTableViewCell
        
      } else {
        settingTableViewCell.customizeImageView.image = UIImage(named: imageNameArray[indexPath.row])
        settingTableViewCell.customizeTitleLabel.text = contentArray[indexPath.row]
        return settingTableViewCell
      }
  }
  
}


extension SettingViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    var storyboard: UIStoryboard
    switch contentArray[indexPath.row] {
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_NotificationSettingTitle", commit: ""):
      guard let url = URL(string: UIApplicationOpenSettingsURLString) else {
        return
      }
      UIApplication.shared.open(url ,options: [:], completionHandler: nil)
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_QuickLoginSetTitle", commit: ""):
      if(Singleton.sharedInstance().getTestLogin()) {
        storyboard = UIStoryboard.init(name: "SettingViewController", bundle: nil)
        let quickLoginSetViewContorller = storyboard.instantiateViewController(withIdentifier: "QuickLoginSetViewContorller")
        navigationController?.pushViewController(quickLoginSetViewContorller, animated: true)
        
      } else {
        //let alertController = UIAlertController.init(title: NSLocalizedString("", comment: ""), message: "", preferredStyle: .alert)
      }
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_LanguageChangeTitle", commit: ""):
      
      myTextField.becomeFirstResponder()
      break
    default:
      
      break
    }
  }
}

extension SettingViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerViewDataArray.count
  }
}

extension SettingViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerViewDataArray[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    didselectPickBool = false
    
    //en
    //zh-Hant
    //zh-Hants
    switch pickerViewDataArray[row] {
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_ChineseTraditionalTitle", commit: ""):
      LanguageTool.sharedInstance().setLanguage(language: "zh-Hant")
      break
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "SettingViewContrller_ChineseSimplifiedTitle", commit: ""):
      LanguageTool.sharedInstance().setLanguage(language: "zh-Hans")
      break
    default:
      LanguageTool.sharedInstance().setLanguage(language: "en")
      break
    }
  }
}


