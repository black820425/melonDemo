//
//  QuickLoginSettingViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/11.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
  
  var contentArray = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentArray = [NSLocalizedString("UseGraphicPasswordTitle", comment: ""),
                    NSLocalizedString("UseFaceIDTitle", comment: ""),
                    NSLocalizedString("UseFingerprintRecognitionTitle", comment: "")]
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = NSLocalizedString("NavigationControllerQuickLoginSettingTitle", comment: "")
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
}

extension SettingViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contentArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "QuickLoginSettingTableViewCell") as! SettingTableViewCell
    cell.customizeTitleLabel.text = contentArray[indexPath.row]
    cell.customizeSwitch.tag = indexPath.row
    
    return cell
  }
  
  
}
