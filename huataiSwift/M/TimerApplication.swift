//
//  TimerApplication.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/14.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class TimerApplication: UIApplication {
  
  private var timeoutInSeconds: TimeInterval {
    return 1 * 10
  }
  
  private var idleTimer: Timer?
  
  // resent the timer because there was user interaction
  private func resetIdleTimer() {
    
    if let idleTimer = idleTimer {
      idleTimer.invalidate()
    }
    
    if(Singleton.sharedInstance().getTestLogin()) {
      
      idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                       target: self,
                                       selector: #selector(TimerApplication.timeHasExceeded),
                                       userInfo: nil,
                                       repeats: false)
    } else {
      //..
    }
  }
  
  // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
  @objc private func timeHasExceeded() {
    
    Singleton.sharedInstance().setTestLogin(bool: false)
    NotificationCenter.default.post(name: NSNotification.Name.init("TestSignOutSuccess"), object: nil)

    let alertController = UIAlertController(title: "系統訊息", message: "您已超過未操作時間，系統自動性登出", preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: "確定", style: .default, handler: nil)
    alertController.addAction(confirmAction)
    
    UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
  }
  
  override func sendEvent(_ event: UIEvent) {
    super.sendEvent(event)
    
    if idleTimer != nil {
      self.resetIdleTimer()
    }
    
    if let touches = event.allTouches {
      for touch in touches where touch.phase == UITouchPhase.began {
        self.resetIdleTimer()
      }
    }
  }
  
  func topViewController(rootViewController: UIViewController) -> UIViewController? {
    
    if(rootViewController.isKind(of: UINavigationController.self)) {
      let navigation = rootViewController as! UINavigationController
      return topViewController(rootViewController:navigation.visibleViewController!)
      
    } else if(rootViewController.isKind(of: UITabBarController.self)){
      let tabBarController = rootViewController as! UITabBarController
      return topViewController(rootViewController:tabBarController.selectedViewController!)
    }
    
    return rootViewController
  }
}
