//
//  MainViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/7.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UIViewController,WKNavigationDelegate{
  
  var wkWebView:WKWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    wkWebView = WKWebView.init(frame: view.frame)
    wkWebView.navigationDelegate = self
    self.view.addSubview(wkWebView)
    let loadUrl = URL(string: "http://nibwebq.hwataibank.com.tw/VisualDesign/Index3.html")
    let customRequest = URLRequest(url: loadUrl!)
    wkWebView.load(customRequest)
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
  }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    
  }
  
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    print("WKWebView didFail Error --> \(error)")
  }
  
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    print("WKWebView didFail Error --> \(error)")
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
