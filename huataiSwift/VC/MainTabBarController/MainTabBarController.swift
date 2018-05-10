//
//  MainTabBarController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/4.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  var mainViewController = MainViewController()
  var qRCodePaymentViewController = UINavigationController()
  var mapViewController = UIViewController()
  var moreViewController = UIViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBar.unselectedItemTintColor = UIColor.white
    
    NotificationCenter.default.addObserver(self, selector: #selector(reloadTabBarControllerIfSuccessLogin), name: NSNotification.Name(rawValue: "TestLoginSuccess"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(TestSingOutSuccess), name: NSNotification.Name(rawValue: "TestSingOutSuccess"), object: nil)
    
    prepareTabBarViewControllers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBar.selectionIndicatorImage = nil
    self.selectedIndex = 0
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  
  @objc func reloadTabBarControllerIfSuccessLogin() {
    self.setViewControllers([mainViewController,qRCodePaymentViewController,mapViewController,moreViewController], animated: true)
  }
  
  @objc func TestSingOutSuccess() {
    self.setViewControllers([qRCodePaymentViewController,mapViewController,moreViewController], animated: true)
  }
  
  func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
    let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
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
    //    UIView.animate(withDuration: 0.3) {
    //    }
    
    var storyboard = UIStoryboard()
    switch item.title {
    case "服務據點":
      storyboard = UIStoryboard.init(name: "MapViewController", bundle: nil)
      let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController")
      present(mapViewController, animated: true, completion: nil)
      break
    case "更多":
      storyboard = UIStoryboard.init(name: "MoreViewController", bundle: nil)
      let moreViewController = storyboard.instantiateViewController(withIdentifier: "MoreViewController")
      present(moreViewController, animated: true, completion: nil)
      break
    default:
      break
    }
  }
  
  func prepareTabBarViewControllers() {
    var storyboard = UIStoryboard()
    
    storyboard = UIStoryboard.init(name: "MainViewController", bundle: nil)
    mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    
    storyboard = UIStoryboard.init(name: "QRCodePaymentViewController", bundle: nil)
    qRCodePaymentViewController = storyboard.instantiateViewController(withIdentifier: "QRCodePaymentViewController") as! UINavigationController
    
    storyboard = UIStoryboard.init(name: "MapViewController", bundle: nil)
    mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewTabBarController")
    
    storyboard = UIStoryboard.init(name: "MoreViewController", bundle: nil)
    moreViewController = storyboard.instantiateViewController(withIdentifier: "MoreViewTabBarController")
    
    self.viewControllers = [qRCodePaymentViewController,mapViewController,moreViewController]
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
