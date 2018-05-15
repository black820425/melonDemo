//
//  GeneralLoginViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/7.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class GeneralLoginViewController: UIViewController {
  
  @IBOutlet weak var customizeScrollView: UIScrollView!
  
  @IBOutlet weak var rememberMeButton: UIButton!
  @IBOutlet weak var refreshConfimppButton: UIButton!
  
  @IBOutlet weak var userLoginButton: UIButton!
  @IBOutlet weak var userCrdSignButton: UIButton!
  
  @IBOutlet weak var userppBackgroundView: UIView!
  @IBOutlet weak var userCodeBackgroundView: UIView!
  @IBOutlet weak var identityCardBackgroundView: UIView!
  @IBOutlet weak var userconfimppBackgroundView: UIView!
  
  @IBOutlet weak var userppTextField: UITextField!
  @IBOutlet weak var identityTextField: UITextField!
  @IBOutlet weak var userCodeTextField: UITextField!
  @IBOutlet weak var userConfimppTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userppTextField.delegate = self
    identityTextField.delegate = self
    userCodeTextField.delegate = self
    userConfimppTextField.delegate = self
    
    repareTextFieldAndButtonRadious()
    
    //註冊tap事件，點選瑩幕任一處可關閉瑩幕小鍵盤
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    self.view.addGestureRecognizer(tap)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

  override func viewDidLayoutSubviews() {
    customizeScrollView.contentSize = CGSize(width: self.view.frame.width, height: customizeScrollView.contentSize.height)
  }
  
  @objc func dismissKeyboard() {
    self.view.endEditing(true)
  }
  
  @IBAction func rememberMeButtonAction(_ sender: Any) {
    let button = sender as! UIButton
    if(button.tag == 0) {
      button.tag = 1
      button.setImage(UIImage(named: "check box"), for: .normal)
      
    } else {
      button.tag = 0
      button.setImage(UIImage(named: "check box_空心"), for: .normal)
    }
  }
  
  @IBAction func refreshButtonAction(_ sender: Any) {
    
  }
  
  
  @IBAction func CreditCardMemApplyButtonAction(_ sender: Any) {
    if let creditCardMembershipViewController = storyboard?.instantiateViewController(withIdentifier: "CreditCardMembershipViewController") {
      present(creditCardMembershipViewController, animated: true, completion: nil)
    }
  }
  
  @IBAction func testLoginButtonAction(_ sender: Any) {
    
    Singleton.sharedInstance().setTestLogin(bool: true)
    
    ProjectAPI.Object().connectAPIWithUrl { (array) in
      NotificationCenter.default.post(name: NSNotification.Name.init("TestLoginSuccess"), object: nil)
      NotificationCenter.default.post(name: NSNotification.Name.init("TestLoginSuccessToPopLoginView"), object: nil)
    }
  }
  
  func repareTextFieldAndButtonRadious() {
    userLoginButton.layer.cornerRadius = 20.0
    userCrdSignButton.layer.borderWidth = 1.0
    userCrdSignButton.layer.cornerRadius = 20.0
    userCrdSignButton.layer.borderColor = Singleton.sharedInstance().getThemeColorR207xG18xB37().cgColor
    
    userppBackgroundView.layer.borderWidth = 1.5
    userppBackgroundView.layer.cornerRadius = 8.0
    userppBackgroundView.layer.borderColor = Singleton.sharedInstance().getThemeColorR232xG232xB232().cgColor
    
    userCodeBackgroundView.layer.borderWidth = 1.5
    userCodeBackgroundView.layer.cornerRadius = 8.0
    userCodeBackgroundView.layer.borderColor = Singleton.sharedInstance().getThemeColorR232xG232xB232().cgColor
    
    identityCardBackgroundView.layer.borderWidth = 1.5
    identityCardBackgroundView.layer.cornerRadius = 8.0
    identityCardBackgroundView.layer.borderColor = Singleton.sharedInstance().getThemeColorR232xG232xB232().cgColor
    
    userconfimppBackgroundView.layer.borderWidth = 1.5
    userconfimppBackgroundView.layer.cornerRadius = 8.0
    userconfimppBackgroundView.layer.borderColor = Singleton.sharedInstance().getThemeColorR232xG232xB232().cgColor
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

extension GeneralLoginViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

    //是否含有注音
    if string.isContainsPhoneticCharacters() {
      return false
    }
    
    //是否含有中文字元
    if string.isContainsChineseCharacters() {
      return false
    }
    
    //是否含有空白字元
    if string.isContainsSpaceCharacters() {
      return false
    }
    
    
    /*
     0 --> identityTextField
     1 --> userppTextField
     2 --> userCodeTextField
     3 --> userConfimppTextField
     */
    switch textField.tag {
    case 0:
      //第一個字轉大寫
      if(string != "") {
        if range.location == 0 && !string.isContainsPhoneticCharacters()  {
          let index = string.index(string.startIndex, offsetBy: 1)
          textField.text = String(string[..<index]).uppercased()
          return false
        }
      }
      
      let maxLength = 10
      let currentString: NSString = textField.text! as NSString
      let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
      return newString.length <= maxLength
    case 1:
      let maxLength = 12
      let currentString: NSString = textField.text! as NSString
      let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
      return newString.length <= maxLength
    case 2:
      break
    case 3:
      break
    default:
      break
    }
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    userppTextField.resignFirstResponder()
    identityTextField.resignFirstResponder()
    userCodeTextField.resignFirstResponder()
    userConfimppTextField.resignFirstResponder()
    return true
  }
  
}

extension String {
  
  //是否含有注音
  func isContainsPhoneticCharacters() -> Bool {
    for scalar in self.unicodeScalars {
      if (scalar.value >= 12549 && scalar.value <= 12582) || (scalar.value == 12584 || scalar.value == 12585 || scalar.value == 19968) {
        return true
      }
    }
    return false
  }
  
  //是否含有中文字元
  func isContainsChineseCharacters() -> Bool {
    for scalar in self.unicodeScalars {
      if scalar.value >= 19968 && scalar.value <= 171941 {
        return true
      }
    }
    return false
  }
  
  //是否含有空白字元
  func isContainsSpaceCharacters() -> Bool {
    for scalar in self.unicodeScalars {
      if scalar.value == 32 {
        return true
      }
    }
    return false
  }
  
}

extension GeneralLoginViewController: UIScrollViewDelegate {
  
}

