//
//  LanguageTool.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/24.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class LanguageTool {
  
  var AppLanguage = "appLanguage"
  
  private static var object:LanguageTool?
  
  static func sharedInstance() -> LanguageTool {
    if object == nil {
      object = LanguageTool()
      
    }
    return object!
  }
  
  func initLanguage() {

    if((currentLanguage()) != nil) {
      //..
    } else {
      systemLanguage()
    }
  }
  
  func currentLanguage() -> String? {
    if let language = UserDefaults.standard.object(forKey: AppLanguage) {
      return language as? String
    }
    
    return nil
  }
  
  func setLanguage(language: String) {
    UserDefaults.standard.set(language, forKey: AppLanguage)
    UserDefaults.standard.synchronize()
  }
  
  func systemLanguage() {
    var languageCode = NSLocale.preferredLanguages[0]
    
    if(languageCode.contains("zh-Hant")) {
      languageCode = "zh-Hant"
      
    } else if(languageCode.contains("zh-Hants")) {
      languageCode = "zh-Hans"
      
    } else if(languageCode.contains("en")) {
      languageCode = "en"
    }
    //en
    //zh-Hant
    //zh-Hants
    
    //en-US
    //zh-Hant-TW
    setLanguage(language: "zh-Hant")
  }
  
  func customzieLocalizedString(key: String,commit: String) -> String {
    
    let language = UserDefaults.standard.object(forKey: AppLanguage) as! String
    let bundle = Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj")!)
        
    return NSLocalizedString(key, tableName: nil, bundle: bundle!, value: "", comment: commit)
  }
}
