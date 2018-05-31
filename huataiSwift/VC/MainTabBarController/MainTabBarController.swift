//
//  MainTabBarController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/4.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  private var tabBarItmeTitleArray = [String]()
  private var mapViewController = UIViewController()
  private var moreViewController = UIViewController()
  private var mainViewController = MainViewController()
  private var qRCodePaymentViewController = UINavigationController()
  private var actionCertificationViewController = ActionCertificationViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBarItmeTitleArray = [LanguageTool.sharedInstance().customzieLocalizedString(key: "TabBarController_MainViewTitle", commit: ""),
                            "行動認證",
                            LanguageTool.sharedInstance().customzieLocalizedString(key: "TabBarController_QRCodePaymentTitle", commit: ""),
                            LanguageTool.sharedInstance().customzieLocalizedString(key: "TabBarController_MapTitle", commit: ""),
                            LanguageTool.sharedInstance().customzieLocalizedString(key: "TabBarController_MoreTitle", commit: "")]
    
    self.tabBar.unselectedItemTintColor = .white
    
    NotificationCenter.default.addObserver(self, selector: #selector(reloadTabBarControllerIfSuccessLogin), name: NSNotification.Name(rawValue: "TestLoginSuccess"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(TestSingOutSuccess), name: NSNotification.Name(rawValue: "TestSignOutSuccess"), object: nil)
    
    prepareTabBarViewControllers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBar.selectionIndicatorImage = nil
    self.selectedIndex = 0
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func reloadTabBarControllerIfSuccessLogin() {
    self.setViewControllers([mainViewController,qRCodePaymentViewController,actionCertificationViewController,mapViewController,moreViewController], animated: true)
    
    self.selectedIndex = 0
  }
  
  @objc func TestSingOutSuccess() {
    self.setViewControllers([qRCodePaymentViewController,actionCertificationViewController,mapViewController,moreViewController], animated: true)
  }
  
  func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    color.setFill()
    UIRectFill(rect)
    
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    let numberOfItems = CGFloat(tabBar.items!.count)
    let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
    let selectionIndicatorImage = self.imageWithColor(color:.red, size: tabBarItemSize).resizableImage(withCapInsets: .zero)
    self.tabBar.selectionIndicatorImage = selectionIndicatorImage
    
    var storyboard:UIStoryboard
    switch item.title {
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "TabBarController_MapTitle", commit: ""):
      storyboard = UIStoryboard.init(name: "MapViewController", bundle: nil)
      let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController")
      present(mapViewController, animated: true, completion: nil)
      break
      
    case LanguageTool.sharedInstance().customzieLocalizedString(key: "TabBarController_MoreTitle", commit: ""):
      storyboard = UIStoryboard.init(name: "MoreViewController", bundle: nil)
      let moreViewController = storyboard.instantiateViewController(withIdentifier: "MoreViewController")
      present(moreViewController, animated: true, completion: nil)
      break
      
    default:
      break
    }
  }
  
  func prepareTabBarViewControllers() {
    
    var storyboard:UIStoryboard
    
    storyboard = UIStoryboard.init(name: "MainViewController", bundle: nil)
    mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    
    
    storyboard = UIStoryboard.init(name: "ActionCertificationViewController", bundle: nil)
    actionCertificationViewController = storyboard.instantiateViewController(withIdentifier: "ActionCertificationViewController") as! ActionCertificationViewController
    
    storyboard = UIStoryboard.init(name: "QRCodePaymentViewController", bundle: nil)
    qRCodePaymentViewController =
      storyboard.instantiateViewController(withIdentifier: "QRCodePaymentViewController") as! UINavigationController
    
    storyboard = UIStoryboard.init(name: "MapViewController", bundle: nil)
    mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewTabBarController")
    
    storyboard = UIStoryboard.init(name: "MoreViewController", bundle: nil)
    moreViewController = storyboard.instantiateViewController(withIdentifier: "MoreViewTabBarController")
    
    mainViewController.title = tabBarItmeTitleArray[0]
    actionCertificationViewController.title = tabBarItmeTitleArray[1]
    qRCodePaymentViewController.title = tabBarItmeTitleArray[2]
    mapViewController.title = tabBarItmeTitleArray[3]
    moreViewController.title = tabBarItmeTitleArray[4]
    
    if(Singleton.sharedInstance().getTestLogin()) {
      self.viewControllers = [mainViewController,
                              qRCodePaymentViewController,
                              actionCertificationViewController,
                              mapViewController,
                              moreViewController]
      
    } else {
      self.viewControllers = [qRCodePaymentViewController,
                              actionCertificationViewController,
                              mapViewController,
                              moreViewController]
    }
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
