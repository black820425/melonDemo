//
//  MoreViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/8.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
  
  @IBOutlet weak var moreViewTableView: UITableView!
  
  var imageNameArray = [String]()
  var titleNameArray = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    moreViewTableView.layer.cornerRadius = 10
    
    imageNameArray = ["更多_利匯率",
                      "更多_服務據點",
                      "更多_版本",
                      "更多_訊息",
                      "更多_線上業務申辦",
                      "更多_使用者隱私聲明",
                      "更多_QR Code收付",
                      "更多_設定",
                      "更多_使用者隱私聲明"]
    
    titleNameArray = [NSLocalizedString("InterestRateTitle", comment: ""),
                      NSLocalizedString("ServiceLocationTitle", comment: ""),
                      NSLocalizedString("MessageTitle", comment: ""),
                      NSLocalizedString("QRCodePaymentTitle", comment: ""),
                      NSLocalizedString("OnlineBusinessBidTitle", comment: ""),
                      NSLocalizedString("UserPrivacyStatementTitle", comment: ""),
                      NSLocalizedString("SettingTitle", comment: ""),
                      NSLocalizedString("AppVersionTitle", comment: ""),
                      "測試登出"]
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationItem.title = NSLocalizedString("NavigationControllerMoreTitle", comment: "");
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func dimissViewButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
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

extension MoreViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return imageNameArray.count == titleNameArray.count ? imageNameArray.count : 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let moreViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoreViewTableViewCell") as! MoreViewTableViewCell
    moreViewTableViewCell.customizeImageView.image = UIImage(named: imageNameArray[indexPath.row])
    moreViewTableViewCell.customizeTitleLabel.text = titleNameArray[indexPath.row]
    
    if(indexPath.row % 2 == 0) {
      moreViewTableViewCell.backgroundColor = .white
    } else {
      moreViewTableViewCell.backgroundColor = Singleton.sharedInstance().getThemColorR250xG250xB250()
    }
    
    return moreViewTableViewCell
  }
}

extension MoreViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    switch section {
    case 0:
      headerView.backgroundColor = .white
      return headerView
    default:
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch section {
    case 0:
      return 24
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let moreViewTableViewCell = tableView.cellForRow(at: indexPath) as! MoreViewTableViewCell
    
    /*
     "SettingTitle" = "設定"
     "MessageTitle" = "訊息";
     "AppVersionTitle" = "版本";
     "InterestRateTitle" = "利匯率";
     "ServiceLocationTitle" = "服務據點";
     "QRCodePaymentTitle" = "QR Code收付";
     "OnlineBusinessBidTitle" = "線上業務申辦";
     "UserPrivacyStatementTitle" = "使用者隱私聲明";*/
    var storyboard:UIStoryboard
    switch moreViewTableViewCell.customizeTitleLabel.text {
      
    case NSLocalizedString("MessageTitle", comment: ""):
      break
      
    case NSLocalizedString("AppVersionTitle", comment: ""):
      break
      
    case NSLocalizedString("InterestRateTitle", comment: ""):
      break
      
    case NSLocalizedString("ServiceLocationTitle", comment: ""):
      storyboard = UIStoryboard.init(name: "MapViewController", bundle: nil)
      let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController")
      present(mapViewController, animated: true, completion: nil)
      break
      
    case NSLocalizedString("QRCodePaymentTitle", comment: ""):
      break
      
    case NSLocalizedString("OnlineBusinessBidTitle", comment: ""):
      break
      
    case NSLocalizedString("UserPrivacyStatementTitle", comment: ""):
      break
      
    case NSLocalizedString("SettingTitle", comment: ""):
      storyboard = UIStoryboard.init(name: "SettingViewController", bundle: nil)
      let quickLoginSettingViewController = storyboard.instantiateViewController(withIdentifier: "QuickLoginSettingViewController")
      navigationController?.pushViewController(quickLoginSettingViewController, animated: true)
      break
      
    default:
      break
    }
    
    if(indexPath.row == 8) {
      Singleton.sharedInstance().setTestLogin(bool: false)
      dismiss(animated: true, completion: nil)
      NotificationCenter.default.post(name: NSNotification.Name.init("TestSignOutSuccess"), object: nil)
    }
  }
  
}
