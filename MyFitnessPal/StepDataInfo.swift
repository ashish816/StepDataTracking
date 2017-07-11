//
//  StepDataInfo.swift
//  MyFitnessPal
//
//  Created by Ashish Mishra on 7/10/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class StepDataInfo: NSObject {
    
    var startDate : Date?
    var endDate : Date?
    var numberOfSteps : NSNumber = NSNumber(value :arc4random_uniform(10000))
    var distance : NSNumber = NSNumber(value : arc4random_uniform(100))
    var averageActivePace : NSNumber = NSNumber(value : arc4random_uniform(10))
    var floorsAscended : NSNumber = NSNumber(value: arc4random_uniform(10))
    var floorsDescended : NSNumber = NSNumber(value : arc4random_uniform(10))
}
