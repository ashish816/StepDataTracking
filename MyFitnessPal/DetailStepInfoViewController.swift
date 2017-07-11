//
//  DetailStepInfoViewController.swift
//  MyFitnessPal
//
//  Created by Ashish Mishra on 7/11/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import UIKit

class DetailStepInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var detailStepInfoTableView : UITableView!
    var stepInfo : StepDataInfo?

    let numberOfRowsForDetailTable = 5
    let detailViewControllerTitle = "Details"
    let detailTableViewIdentifier = "DetailStepDataCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = detailViewControllerTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsForDetailTable
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailTableViewIdentifier, for: indexPath) as! DetailStepDataCell
        switch indexPath.row {
        case 0:
            cell.metricName.text = "Number Of Steps"
            cell.metricValue.text = "\(String(describing: self.stepInfo!.numberOfSteps.intValue))"
        case 1:
            cell.metricName.text = "Distance" + "\n" + "(meters)"
            cell.metricValue.text = "\(String(describing: self.stepInfo!.distance.intValue))"
        case 2:
            cell.metricName.text = "Average Pace" + "\n" + "(seconds per meter)"
            cell.metricValue.text = "\(String(describing: self.stepInfo!.averageActivePace.intValue))"
        case 3:
            cell.metricName.text = "Floors Ascended"
            cell.metricValue.text = "\(String(describing: self.stepInfo!.floorsAscended.intValue))"
        case 4:
            cell.metricName.text = "Floors Descended"
            cell.metricValue.text = "\(String(describing: self.stepInfo!.floorsDescended.intValue))"
        default: break
        }
        
        return cell
    }

}
