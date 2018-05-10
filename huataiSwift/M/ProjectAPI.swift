//
//  ProjectAPI.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/2.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit


class ProjectAPI {
  
  typealias PassArrayBlock = ([Int]) -> Void
  
  func connectAPIWithUrl(closures: PassArrayBlock){
    let str = "Hello"
    let myData = str.data(using: .utf8)
    
    let url = URL(string: "https://appcms.u-sync.com/cms-user/v1/ntua/news")
    guard let _ = url else { return }
    var request = URLRequest(url: url!,
                             cachePolicy:  NSURLRequest.CachePolicy.reloadIgnoringCacheData,
                             timeoutInterval: 10)
    request.httpMethod = "POST"
    request.httpBody = myData
    
    let task = URLSession.shared.dataTask(with: request) {
      (data, response, error) -> Void in
      
      if error != nil {
        print("error=\(String(describing: error))")
        return
      }
      
      print("response = \(String(describing: response))")
      
      if let data = data {
        //將收到的資料轉成字串print出來看看
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(responseString ?? "")")
        //let contentArray:Array = Array(data:data!,encod)
      }
      
    }
    task.resume()
    
    var array = [Int]()
    array = [1,3,4]
    
    closures(array)
  }
}
