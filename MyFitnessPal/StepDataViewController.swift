//
//  ViewController.swift
//  MyFitnessPal
//
//  Created by Ashish Mishra on 7/8/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit
import CoreMotion

class StepDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let heighForHeaderInSection : CGFloat = 50
    let stepDataSectionHeaderDateFormat = "MMM d, yyyy"
    let stepDataViewControllerTitle = "Step Tracker"
    let sectionHeaderLabelFont = "Helvetica Neue"
    let stepDataCellIdentifier = "DailyStepDataCell"
    let stepDataToDetailSegueId = "StepInfoToDetailInfo"
    
    var lastTenDaysData = [StepDataInfo]()
    var stepDataManager : StepDataManager?
    @IBOutlet var stepDataTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = stepDataViewControllerTitle
        self.stepDataManager = StepDataManager()
        self.stepDataManager?.fetchDataForLastTenDays(completionHandler: { (stepData, error) in
            if error == nil {
                self.lastTenDaysData = stepData!
                DispatchQueue.main.async {
                    self.stepDataTableView.reloadData()
                }
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return lastTenDaysData.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heighForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        let pedometer = self.lastTenDaysData[section] as StepDataInfo
         headerLabel.text = pedometer.startDate?.toString(dateFormat: stepDataSectionHeaderDateFormat)
        headerLabel.backgroundColor = UIColor.white
        headerLabel.font = UIFont(name: sectionHeaderLabelFont, size: 20)
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return headerLabel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stepInfo = self.lastTenDaysData[indexPath.section] as StepDataInfo
        let cell = tableView.dequeueReusableCell(withIdentifier: stepDataCellIdentifier, for: indexPath) as! DailyStepTableViewCell
        cell.dailyStepsLabel?.text = "Daily Steps"  + "\n" + "\(stepInfo.numberOfSteps)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: stepDataToDetailSegueId, sender: indexPath)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var indexpath = sender as! IndexPath
        let destination = segue.destination as! DetailStepInfoViewController
        destination.stepInfo = self.lastTenDaysData[indexpath.section]
    }
}

extension Date {
    func midNightDate() -> Date {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = .current
        let newDate = cal.startOfDay(for: self)
        return newDate
    }
    
    func toString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
