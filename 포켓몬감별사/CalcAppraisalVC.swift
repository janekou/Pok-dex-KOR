//
//  CalcAppraisalVC.swift
//  포켓몬감별사
//
//  Created by Jane on 11/02/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit

class CalcAppraisalVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var teamSegments: UISegmentedControl!
    @IBOutlet weak var appraisalList: UITableView!
    

    @IBAction func segmentActionChanged(_ sender: Any) {
        appraisalList.isHidden = false
        
//        let array = teamSegments.subviews
//        array[2].tintColor = UIColor.red
//        array[1].tintColor = UIColor.blue
//        array[0].tintColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
//        
//        appraisalList.reloadData()

        
//        if teamSegments.selectedSegmentIndex == 0 {
//            teamSegments.subviews[2].tintColor = UIColor.red
//        }
//        else if teamSegments.selectedSegmentIndex == 1 {
//            teamSegments.subviews[1].tintColor = UIColor.blue
//        }
//        else if teamSegments.selectedSegmentIndex == 2 {
//            teamSegments.subviews[0].tintColor = UIColor.yellow
//        }
    }

    
    let redList = ["말할 게 없어. 든든하겠어!","아주 강해, 자랑해도 되겠어!","보통의 강함이라고 생각해!", "배틀이 적성은 아니지만 난 좋아해"]
    let blueList = ["경이롭고 예술적이야.","시선을 끄는 뭔가가 있어.","보통이상이야", "좀처럼 활약이 어려워 보인다"]
    let yellowList = ["톱 레벨이야!","아주 강해!","보통이야.", "그저 그러네."]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let array = teamSegments.subviews
        array[2].tintColor = UIColor.red
        array[1].tintColor = UIColor.blue
        array[0].tintColor = UIColor(red: 254.0/255.0, green: 216.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        
    
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if teamSegments.selectedSegmentIndex == 0 {
            return redList.count
        }
        else if teamSegments.selectedSegmentIndex == 1 {
            return blueList.count
        }
        else if teamSegments.selectedSegmentIndex == 2 {
            return yellowList.count
        }
        return 0
    }
        
//        var returnValue = 0
//
//        switch(teamSegements.selectedSegmentIndex) {
//        case 0:
//            returnValue = redList.count
//            break
//        case 1:
//            returnValue = blueList.count
//
//            break
//        case 2:
//            returnValue = yellowList.count
//
//            break
//        default:
//            break
//            
//        }
//        
//        return returnValue

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appraisalCell = tableView.dequeueReusableCell(withIdentifier: "appraisalCell", for: indexPath)
        
        if teamSegments.selectedSegmentIndex == 0 {
            appraisalCell.textLabel?.text = redList[indexPath.row]
        }
        else if teamSegments.selectedSegmentIndex == 1 {
            appraisalCell.textLabel?.text = blueList[indexPath.row]
        }
        else if teamSegments.selectedSegmentIndex == 2 {
            appraisalCell.textLabel?.text = yellowList[indexPath.row]
        }
        return appraisalCell
    }
    
//        switch(teamSegements.selectedSegmentIndex) {
//        case 0:
//            appraisalCell.textLabel?.text = redList[indexPath.row]
//            break
//        case 1:
//            appraisalCell.textLabel?.text = blueList[indexPath.row]
//            
//            break
//        case 2:
//            appraisalCell.textLabel?.text = yellowList[indexPath.row]
//            
//            break
//        default:
//            break
//        }
//        
//        return appraisalCell
}
