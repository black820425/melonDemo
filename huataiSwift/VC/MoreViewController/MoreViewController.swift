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
                      "更多_訊息",
                      "更多_QR Code收付",
                      "更多_線上業務申辦",
                      "更多_使用者隱私聲明",
                      "更多_版本",
                      "更多_設定",
                      "更多_登出"]
    
    var AppVersion = ""
    if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String {
      AppVersion = String(format: "%@%@",LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_AppVersionTitle", commit: ""),text)
    }
    
    titleNameArray = [LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_InterestRateTitle", commit: ""),
                      LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_ServiceLocationTitle", commit: ""),
                      LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_MessageTitle", commit: ""),
                      LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_QRCodePaymentTitle", commit: ""),
                      LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_OnlineBusinessBidTitle", commit: ""),
                      LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_UserPrivacyStatementTitle", commit: ""),
                      AppVersion,
                      LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_SettingTitle", commit: ""),
                      LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_LogOutTitle", commit: "")]
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationItem.title = LanguageTool.sharedInstance().customzieLocalizedString(key: "NavigaitonControllerTitle_MoreTitle", commit: "")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    if(UserDefaults.standard.bool(forKey: "ChangeLanguageBool")) {
      UserDefaults.standard.set(false, forKey: "ChangeLanguageBool")
      UserDefaults.standard.synchronize()
      
      let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
      let mainTabBarController =  storyboard.instantiateViewController(withIdentifier: "MainTabBarController")

      dismiss(animated: true) {
        
        UIApplication.shared.keyWindow?.rootViewController = mainTabBarController
      }
    }
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
    
    if(Singleton.sharedInstance().getTestLogin()) {
      return imageNameArray.count == titleNameArray.count ? imageNameArray.count : 0
      
    } else {
      return imageNameArray.count == titleNameArray.count ? imageNameArray.count-1 : 0
    }
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
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_MessageTitle", commit: ""):
      storyboard = UIStoryboard.init(name: "NotificationViewController", bundle: nil)
      let notificationViewController = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
      navigationController?.pushViewController(notificationViewController, animated: true)
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_AppVersionTitle", commit: ""):
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_InterestRateTitle", commit: ""):
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_ServiceLocationTitle", commit: ""):
      storyboard = UIStoryboard.init(name: "MapViewController", bundle: nil)
      let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController")
      present(mapViewController, animated: true, completion: nil)
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_QRCodePaymentTitle", commit: ""):
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_OnlineBusinessBidTitle", commit: ""):
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_UserPrivacyStatementTitle", commit: ""):
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_SettingTitle", commit: ""):
      storyboard = UIStoryboard.init(name: "SettingViewController", bundle: nil)
      let settingViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController")
      navigationController?.pushViewController(settingViewController, animated: true)
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "MoreViewController_LogOutTitle", commit: ""):
      Singleton.sharedInstance().setTestLogin(bool: false)
      dismiss(animated: true, completion: nil)
      NotificationCenter.default.post(name: NSNotification.Name.init("TestSignOutSuccess"), object: nil)
      break
      
    default:
      break
    }
  }
}
