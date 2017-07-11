//
//  MyFitnessPalTests.swift
//  MyFitnessPalTests
//
//  Created by Ashish Mishra on 7/8/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import XCTest
@testable import MyFitnessPal

class MyFitnessPalTests: XCTestCase {
    
    var stepDataViewController : StepDataViewController?
    var stepDataManager : StepDataManager = StepDataManager()
    
    override func setUp() {
        super.setUp()
        self.stepDataViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StepDataViewController") as? StepDataViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testStepDataFetchedSuceesfully() {
        self.stepDataManager.fetchDataForLastTenDays { (stepData, error) in
            XCTAssertEqual(self.stepDataManager.lastTenDaysData.count, 10)
        }
    }
    
    func testStepDataStubbedSucessfully () {
        self.stepDataManager.fetchDataForLastTenDays { (stepData, error) in
            for oneDayData in stepData! {
                XCTAssertNotEqual(oneDayData.numberOfSteps.intValue, 0)
            }
        }
    }
    
    func testNumberOfSectionsInStepTable() {
        let stepDataTableView = self.stepDataViewController?.stepDataTableView
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
            XCTAssertEqual(stepDataTableView?.numberOfSections, 10)
        }
    }
    
}
