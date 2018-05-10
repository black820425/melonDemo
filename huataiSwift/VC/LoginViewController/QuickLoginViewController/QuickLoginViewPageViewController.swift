//
//  QuickLoginViewPageViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/7.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class QuickLoginViewPageViewController: UIPageViewController {
  
  var showPagePreviousIndex: Int = 0
  var viewControllersArray = [UIViewController]()
  var quickLoginViewController: QuickLoginViewController!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let biometricViewController = storyboard?.instantiateViewController(withIdentifier: "BiometricViewController")
    let gestureUnlockViewController = storyboard?.instantiateViewController(withIdentifier: "GestureUnlockViewController")
    
    viewControllersArray = [biometricViewController,gestureUnlockViewController] as! [UIViewController]
  }
  
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
