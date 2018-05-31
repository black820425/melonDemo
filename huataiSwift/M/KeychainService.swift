//
//  KeychainService.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/30.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit
import Security

// Arguments for the keychain queries
let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

class KeychainService: NSObject {
  
  
  class func savePassword(service: String, account:String, data: Array<Int>) {
    
    let myData = NSKeyedArchiver.archivedData(withRootObject: data)

      // Instantiate a new default keychain query
      let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account, myData], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
      
      // Add the new keychain item
      let status = SecItemAdd(keychainQuery as CFDictionary, nil)
      
      if (status != errSecSuccess) {    // Always check the status
        
        if #available(iOS 11.3, *) {
          if let err = SecCopyErrorMessageString(status, nil) {
            print("Write failed: \(err)")
          }
        } else {
          // Fallback on earlier versions
        }
      }
//    if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
//
//      // Instantiate a new default keychain query
//      let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
//
//      // Add the new keychain item
//      let status = SecItemAdd(keychainQuery as CFDictionary, nil)
//
//      if (status != errSecSuccess) {    // Always check the status
//        if #available(iOS 11.3, *) {
//          if let err = SecCopyErrorMessageString(status, nil) {
//            print("Write failed: \(err)")
//          }
//        } else {
//          // Fallback on earlier versions
//        }
//      }
//    }
  }
  
  class func loadPassword(service: String, account:String) -> Array<Int>? {
    
    // Instantiate a new default keychain query
    // Tell the query to return a result
    // Limit our results to one item
    let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
    
    var dataTypeRef :AnyObject?
    
    // Search for the keychain items
    let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
    var contentsOfKeychain: Array<Int>?
    
    if status == errSecSuccess {
      if let retrievedData = dataTypeRef as? Data {
        
        if let objects = NSKeyedUnarchiver.unarchiveObject(with: retrievedData) as? [Int] {
          contentsOfKeychain = objects
        } else {
          print("Error while unarchiveObject")
        }
        
      }
    } else {
      print("Nothing was retrieved from the keychain. Status code \(status)")
    }
    
    return contentsOfKeychain
  }
  
  class func updatePassword(service: String, account:String, data: String) {
    if let dataFromString: Data = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
      
      // Instantiate a new default keychain query
      let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
      
      let status = SecItemUpdate(keychainQuery as CFDictionary, [kSecValueDataValue:dataFromString] as CFDictionary)
      
      if (status != errSecSuccess) {
        
        if #available(iOS 11.3, *) {
          if let err = SecCopyErrorMessageString(status, nil) {
            print("Read failed: \(err)")
          }
        } else {
          // Fallback on earlier versions
        }
      }
    }
  }
  
  class func removePassword(service: String, account:String) {
    
//    let query = [
//      kSecClass as String: kSecClassGenericPassword,
//      kSecAttrAccount as String: key
//    ]
    
    // Instantiate a new default keychain query
    let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, account, kCFBooleanTrue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue])

    // Delete any existing items
    let status = SecItemDelete(keychainQuery as CFDictionary)
    if (status != errSecSuccess) {
      if #available(iOS 11.3, *) {
        if let err = SecCopyErrorMessageString(status, nil) {
          print("Remove failed: \(err)")
        }
      } else {
        // Fallback on earlier versions
      }
    }
    
  }

}
