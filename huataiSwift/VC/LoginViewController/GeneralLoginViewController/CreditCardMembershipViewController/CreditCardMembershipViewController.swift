//
//  CreditCardMembershipViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/9.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class CreditCardMembershipViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func dimissButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return 2
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
      
    case 0:
      let creditCardInstructionsTableViewCell =
        tableView.dequeueReusableCell(withIdentifier: "CreditCardInstructionsTableViewCell") as! CreditCardInstructionsTableViewCell
      creditCardInstructionsTableViewCell.customizeBackgroundImageView.layer.cornerRadius = 10
      //creditCardInstructionsTableViewCell.customizeTextView.text = "Hello"
      return creditCardInstructionsTableViewCell
    case 1:
      let creditCardPublicTextFieldTableViewCell =
        tableView.dequeueReusableCell(withIdentifier: "CreditCardPublicTextFieldTableViewCell") as! CreditCardPublicTextFieldTableViewCell
      creditCardPublicTextFieldTableViewCell.customizeTextField.layer.masksToBounds = true
      creditCardPublicTextFieldTableViewCell.customizeTextField.layer.borderColor = UIColor.white.cgColor
      creditCardPublicTextFieldTableViewCell.customizeTextField.layer.borderWidth = 1
      creditCardPublicTextFieldTableViewCell.customizeTextField.layer.cornerRadius = 20
      return creditCardPublicTextFieldTableViewCell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      return cell
    }
  }
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    switch section {
    case 1:
      
      headerView.backgroundColor = .white
      return headerView
    default:
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch section {
    case 1:
      return 59
    default:
      return 0
    }
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationItem.title = NSLocalizedString("NavigationControllerCreditCardMemberShipApplicationTitle", comment: "")
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
