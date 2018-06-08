//
//  ProjectAPI.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/2.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

//華泰測試機
//let kServerURL = "http://10.1.9.101/NConsumerBank/TicApp/TicMainAction"

//QA機
let kServerURL = "https://nibwebq.hwataibank.com.tw/NConsumerBank/TicApp/TicMainAction"

class ProjectAPI {
  
  private static var object:ProjectAPI?
  
  static func Object() -> ProjectAPI {
    if object == nil {
      object = ProjectAPI()
      
    }
    return object!
  }
  
  typealias PassArrayBlock = (String) -> Void
  
  func connectAPIWithUrl(method: String, parmaterDic: [String:String], closures: @escaping PassArrayBlock) {
    
    // prepare URLRequest
    let url = URL(string: kServerURL)
    guard let _ = url else { return }
    var request = URLRequest(url: url!,cachePolicy:NSURLRequest.CachePolicy.reloadIgnoringCacheData,timeoutInterval: 60)
    request.httpMethod = "POST"
    
    // UDID.
    let identifierForVendor = UIDevice.current.identifierForVendor
    // YYYYMMDDHHMMSS.
    let des_IV_YMDHMSString = DES3Util.des_IV_YMDHMSString()
    // UDID + YYYYMMDDHHMMSS.
    let vidKeyString = (identifierForVendor?.uuidString)! + des_IV_YMDHMSString!
    // vidKeyString convert data
    let data = vidKeyString.data(using: .utf8)
    
    // vidKeyString use 3DES and unPack.
    let vidEncrypt = unPackMethod(desData: DES3Util.encrypt(data))
    
    // parpare put data in dictionary
    let dic: [String: [String: String]] =
      ["Header":["Version":"1.4",
                 "OSVer":"9.3.5",
                 "Platform":"ios",
                 "Model":"iPhone",
                 "VID":vidEncrypt,
                 "Mobile_IP":"192.168.11.98",
                 "TX_SN":des_IV_YMDHMSString!,
                 "TX_id":"QCA00006","Session_id":"",
                 "UDID":(identifierForVendor?.uuidString)!],
       "Body":parmaterDic]
    
    // prepare put unPack String
    var encryptString = String()
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
      // jsonString use 3DES and unPack.
      encryptString = unPackMethod(desData: DES3Util.encrypt(jsonData))
      
      let bodyData = "opName=\(method)&opInput=\(encryptString)"
      let myData = bodyData.data(using: .utf8)
      request.httpBody = myData
      
      let task = URLSession.shared.dataTask(with: request) {
        (data, response, error) -> Void in
        
        if error != nil {
          print("error=\(String(describing: error))")
          return
        }
        
        
        if let data = data {
          //將收到的資料轉成字串print出來看看
          if let responseString = String(data: data, encoding: .utf8) {
            print("responseString = \(responseString)")
            
            self.packMethod(pvDataString: responseString)
            
            closures(responseString)
          }
          
        }
      }
      task.resume()
      
    } catch {
      print("JSONSerialization error: \(error.localizedDescription)")
    }
  }
  
  func unPackMethod(desData: Data) -> String {
    
    var bytH = 0
    var bytL = 0
    let byteBase48 = 48
    var pvDataString = ""
    
    let array = [UInt8](desData)
    
    for index in 0...(array.count-1) {
      //print("\(String(format:"%2X", array[index]))")
      
      //放 Hi-byte
      bytH = Int(array[index]/16)
      if(bytH > 9) {
        bytH = bytH + byteBase48 + 7
        
      } else {
        bytH = bytH + byteBase48
      }
      pvDataString = pvDataString + String(Character(UnicodeScalar(bytH)!))
      
      //放 Lo-byte
      bytL = Int(array[index]%16)
      if(bytL > 9) {
        bytL = bytL + byteBase48 + 7
        
      } else {
        bytL = bytL + byteBase48
      }
      pvDataString = pvDataString + String(Character(UnicodeScalar(bytL)!))
      
    }
    
    return pvDataString
  }
  
  func packMethod(pvDataString:String) {
    
    let hexaBytes = pvDataString.hexa2Bytes
    print("hexaBytes --> \(hexaBytes)")
    
    let myData = NSData(bytes: hexaBytes, length: hexaBytes.count)
    print(print("\(myData as NSData)"))
    
    
    if let decrypt = DES3Util.decrypt(myData as Data?) {
      print("decrypt --> \(decrypt)")
      
      do {
        let dic = try JSONSerialization.jsonObject(with: decrypt, options: .mutableContainers)
        print("dic --> \(dic)")
        
      } catch {
        print("json error \(error)")
      }
    }
    
  }
}

extension String {
  var hexa2Bytes: [UInt8] {
    let hexa = Array(self)
    return stride(from: 0, to: count, by: 2).compactMap { UInt8(String(hexa[$0..<$0.advanced(by: 2)]), radix: 16) }
  }
}


