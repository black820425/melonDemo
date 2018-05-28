//
//  LoginViewPageViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/7.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class LoginViewPageViewController: UIPageViewController {
  
  var showPagePreviousIndex = 0
  var loginViewController: LoginViewController!
  var viewControllersArray = [UIViewController]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let generalLoginViewController = storyboard?.instantiateViewController(withIdentifier: "GeneralLoginViewController")
    let biometricViewController = storyboard?.instantiateViewController(withIdentifier: "BiometricViewController")
    let gestureUnlockViewController = storyboard?.instantiateViewController(withIdentifier: "GestureUnlockViewController")

    viewControllersArray = [generalLoginViewController,biometricViewController,gestureUnlockViewController] as! [UIViewController]
    
    self.setViewControllers([generalLoginViewController!], direction: .forward, animated: false, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func showPage(index:NSInteger) {
    let view = viewControllersArray[index]
    
    if(showPagePreviousIndex < index) {
      showPagePreviousIndex = index
      self.setViewControllers([view], direction: .forward, animated: true, completion: nil)
      
    } else {
      showPagePreviousIndex = index
      self.setViewControllers([view], direction: .reverse, animated: true, completion: nil)
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

extension LoginViewPageViewController: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    if var previousIndex = viewControllersArray.index(of: viewController) {
      previousIndex = previousIndex-1
      if(previousIndex >= 0 && previousIndex < (viewControllersArray.count)) {
        return viewControllersArray[previousIndex]
      }
    }
    return nil
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    if var nextIndex = viewControllersArray.index(of: viewController) {
      nextIndex = nextIndex+1
      if(nextIndex < viewControllersArray.count) {
        return viewControllersArray[nextIndex]
      }
    }
    return nil
  }
}
