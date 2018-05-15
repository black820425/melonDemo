//
//  QuickLoginSettingViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/15.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class QuickLoginSettingViewController: UIViewController {
  
  @IBOutlet weak var customizeScrollView: UIScrollView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  override func viewDidLayoutSubviews() {
    customizeScrollView.contentSize = CGSize(width: self.view.frame.width, height: customizeScrollView.contentSize.height)
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  
  @IBAction func popButtonAction(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  
  @IBAction func biomertriceSetButtonAction(_ sender: Any) {
    
  }
  
  @IBAction func gestureUnlockButtonAction(_ sender: Any) {
    let gestureUnlockSettingViewController =
      storyboard?.instantiateViewController(withIdentifier: "GestureUnlockSettingViewController") as! GestureUnlockSettingViewController
    navigationController?.pushViewController(gestureUnlockSettingViewController, animated: true)
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
