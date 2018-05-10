//
//  huataiSwiftTests.swift
//  huataiSwiftTests
//
//  Created by Bryan on 2018/4/4.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import XCTest
@testable import huataiSwift

class huataiSwiftTests: XCTestCase {
    var vc:UITabBarController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        vc = storyboard.instantiateInitialViewController() as! UITabBarController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPercentageCalculator() {
        XCTAssert(true)
    }
    
}
