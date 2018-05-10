//
//  GeneralLoginViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/7.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class GeneralLoginViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
  
  @IBOutlet weak var customizeScrollView: UIScrollView!
  
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
    }
  
  override func viewDidLayoutSubviews() {
    customizeScrollView.contentSize = CGSize(width: self.view.frame.width, height: customizeScrollView.contentSize.height)
  }

  @IBAction func CreditCardMemApplyButtonAction(_ sender: Any) {
    if let creditCardMembershipViewController = storyboard?.instantiateViewController(withIdentifier: "CreditCardMembershipViewController") {
      present(creditCardMembershipViewController, animated: true, completion: nil)
    }
  }
  
  @IBAction func testLoginButtonAction(_ sender: Any) {
    NotificationCenter.default.post(name: NSNotification.Name.init("TestLoginSuccess"), object: nil)
    
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    userppTextField.resignFirstResponder()
    identityTextField.resignFirstResponder()
    userCodeTextField.resignFirstResponder()
    userConfimppTextField.resignFirstResponder()
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

