//
//  GetPushDeviceTokenViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/6/8.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit



class GetPushDeviceTokenViewController: UIViewController {
  
  @IBOutlet weak var cutomizeTextField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func getPushTokenPress(_ sender: Any) {
    if let DeviceTokenString = UserDefaults.standard.object(forKey: "DeviceTokenString") as? String {
      cutomizeTextField.text = DeviceTokenString
    } else {
      cutomizeTextField.text = "未取得DeviceToken"
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
