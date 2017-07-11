//
//  StepDataManager.swift
//  MyFitnessPal
//
//  Created by Ashish Mishra on 7/11/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit
import CoreMotion

class StepDataManager: NSObject {
    
    var pedoMeter : CMPedometer = CMPedometer()
    var lastTenDaysData = [StepDataInfo]()
    
    func fetchDataForLastTenDays(completionHandler : @escaping ([StepDataInfo]?, Error?) -> ()) {
        if CMPedometer.isStepCountingAvailable() {
            self.fetchDataForTenDaysIfDataAvailable(completionHandler: completionHandler)
        } else {
            self.mockDataForTenDays(completionHandler: completionHandler)
        }
    }
    
    private func fetchDataForTenDaysIfDataAvailable(completionHandler : @escaping ([StepDataInfo]?, Error?) -> ()) {
        
        var currentDate: Date = Date()
        
        let myGroup = DispatchGroup()
        for i in 1...10 {
            var aDayPriordate : Date?
            if i == 1{
                aDayPriordate = currentDate.midNightDate()
            }else {
                aDayPriordate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
            }
            
            myGroup.enter()
            
            self.pedoMeter.queryPedometerData(from: aDayPriordate!, to: currentDate, withHandler: { (pedometerData, error) in
                
                if error == nil {
                    let stepDataInfo = StepDataInfo()
                    stepDataInfo.startDate = aDayPriordate
                    stepDataInfo.endDate = currentDate
                    stepDataInfo.numberOfSteps = pedometerData?.numberOfSteps.intValue != 0  ? (pedometerData?.numberOfSteps)! : stepDataInfo.numberOfSteps
                    stepDataInfo.floorsAscended = pedometerData?.floorsAscended != nil ? (pedometerData?.floorsAscended)! : stepDataInfo.floorsAscended
                    stepDataInfo.floorsDescended = pedometerData?.floorsDescended != nil ? (pedometerData?.floorsDescended)! : stepDataInfo.floorsDescended
                    stepDataInfo.averageActivePace = pedometerData?.averageActivePace != nil ? (pedometerData?.averageActivePace)! : stepDataInfo.averageActivePace
                    stepDataInfo.distance = pedometerData?.distance != nil ? (pedometerData?.distance)! : stepDataInfo.distance
                    
                    self.lastTenDaysData.append(stepDataInfo)
                    myGroup.leave()
                }
                else {
                    completionHandler(nil, error)
                }
            })
            currentDate = aDayPriordate!
            
            myGroup.notify(queue: .main) {
                completionHandler(self.lastTenDaysData, nil)
            }
        }
    }
    
    private func mockDataForTenDays(completionHandler : @escaping ([StepDataInfo]?, Error?) -> ()) {
        var currentDate: Date = Date().midNightDate()
        
        for _ in 1...10 {
            let aDayPriordate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
            let stepDataInfo = StepDataInfo()
            stepDataInfo.startDate = aDayPriordate
            stepDataInfo.endDate = currentDate
            self.lastTenDaysData.append(stepDataInfo)
            currentDate = aDayPriordate!
        }
        completionHandler(self.lastTenDaysData,nil)
    }

}
