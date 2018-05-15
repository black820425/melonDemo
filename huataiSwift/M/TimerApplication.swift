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
    // 2 minutes
    return 6
  }
  
  private var idleTimer: Timer?
  
  // resent the timer because there was user interaction
  private func resetIdleTimer() {
    
    if let idleTimer = idleTimer {
      idleTimer.invalidate()
    }
    
    
    idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                     target: self,
                                     selector: #selector(TimerApplication.timeHasExceeded),
                                     userInfo: nil,
                                     repeats: false)
  }
  
  // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
  @objc private func timeHasExceeded() {
    NotificationCenter.default.post(name: NSNotification.Name.init("TestSignOutSuccess"), object: nil)
  }
  
  var islogin = true
  
  override func sendEvent(_ event: UIEvent) {
    super.sendEvent(event)
    
    if islogin {
      
      if idleTimer != nil {
        self.resetIdleTimer()
      }
      
      if let touches = event.allTouches {
        for touch in touches where touch.phase == UITouchPhase.began {
          self.resetIdleTimer()
        }
      }
    }
  }
  
  @objc func LoginSuccessTest() {
    
    if let idleTimer = idleTimer {
      idleTimer.invalidate()
    }
    idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                     target: self,
                                     selector: #selector(TimerApplication.timeHasExceeded),
                                     userInfo: nil,
                                     repeats: false)
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
