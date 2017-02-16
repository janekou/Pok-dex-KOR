//
//  CalcAppraisalVC.swift
//  포켓몬감별사
//
//  Created by Jane on 11/02/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit

class CalcAppraisalVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var teamSegments: UISegmentedControl!
    @IBOutlet var appraisalList: UITableView!

    @IBAction func segmentChanged(_ sender: Any) {
        appraisalList.reloadData()
    }
    
    
    let headerTitles = ["개체값 관련 대사", "스탯 관련 대사", "title3"]
    let redList = [["말할 게 없어. 든든하겠어!","아주 강해, 자랑해도 되겠어!","보통의 강함이라고 생각해!", "배틀이 적성은 아니지만 난 좋아해"], ["HP", "공격", "방어"], ["최고야! 가슴이 뜨거워져!", "훌륭해! 두근거려!", "꽤 강하네. 배틀에서 활약할 것 같아!", "그럭저럭 강한거네."]]
    let blueList = [["경이롭고 예술적이야.","시선을 끄는 뭔가가 있어.","보통이상이야", "좀처럼 활약이 어려워 보인다"], ["HP", "공격", "방어"], ["측정할 수 없을 정도로 높아! 최고야!", "훌륭해! 놀라워!", "꽤 강하다고 말할 수 있군.", "그럭저럭이라고 할 수 있군."]]
    let yellowList = [["톱 레벨이야!","아주 강해!","보통이야.", "그저 그러네."], ["HP", "공격", "방어"], ["지금까지 본 것중에서도 최고의 부류야!", "훌륭해! 정말이야!", "꽤 강한데! 내가 보증하지!", "그럭저럭, 이야!"]]
    
    var selectedRows = [String:NSIndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        (teamSegments.subviews[2] as UIView).tintColor = UIColor.red
        (teamSegments.subviews[1] as UIView).tintColor = UIColor.blue
        (teamSegments.subviews[0] as UIView).tintColor = UIColor(red: 254.0/255.0, green: 216.0/255.0, blue: 80.0/255.0, alpha: 1.0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        return nil

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        switch (teamSegments.selectedSegmentIndex) {
        case 0:
            returnValue = redList.count
            break
        case 1:
            returnValue = blueList.count
            break
        case 2:
            returnValue = yellowList.count
            break
        default:
            break
        }
        
        return returnValue
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appraisalCell = appraisalList.dequeueReusableCell(withIdentifier: "appraisalCell", for: indexPath)
        
        switch (teamSegments.selectedSegmentIndex) {
        case 0:
            appraisalCell.textLabel?.text = redList[indexPath.section][indexPath.row]
            break
        case 1:
            appraisalCell.textLabel?.text = blueList[indexPath.section][indexPath.row]
            break
        case 2:
            appraisalCell.textLabel?.text = yellowList[indexPath.section][indexPath.row]
            break
        default:
            break
        }
        return appraisalCell
    }

    func addSelectedCellWithSection(indexPath:NSIndexPath) ->NSIndexPath? {
        let existingIndexPath = selectedRows["\(indexPath.section)"];
        if (existingIndexPath == nil) {
            selectedRows["\(indexPath.section)"]=indexPath;
        }else
        {
            selectedRows["\(indexPath.section)"]=indexPath;
            return existingIndexPath
        }
        
        return nil;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.appraisalList.cellForRow(at: indexPath)
        
        let previusSelectedCellIndexPath = self.addSelectedCellWithSection(indexPath: indexPath as NSIndexPath);
        
        if(previusSelectedCellIndexPath != nil) {
            let previusSelectedCell = self.appraisalList.cellForRow(at: previusSelectedCellIndexPath! as IndexPath)
            
            previusSelectedCell?.accessoryType = .none
            cell?.accessoryType = .checkmark
            tableView.deselectRow(at: previusSelectedCellIndexPath! as IndexPath, animated: true);
        } else {
            cell?.accessoryType = .checkmark
        }
        
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let appraisalCell = appraisalList.cellForRow(at: indexPath as IndexPath)
//        
//        switch indexPath.section {
//        case 0:
//            appraisalCell?.accessoryType = .none
//            break
//        case 1:
//            appraisalCell?.accessoryType = .checkmark
//            break
//        case 2:
//            appraisalCell?.accessoryType = .none
//            break
//        default:
//            break
//
//        }
//    }
//        if indexPath.section == 1 {
//            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//                cell.accessoryType = .checkmark
//            }
//        }
//        else {
//            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//                cell.accessoryType = .checkmark
//            }
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//                cell.accessoryType = .none
//            }
//        else if indexPath.section == 2 {
//            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//                cell.accessoryType = .none
//                }
//            }
//        }
//    }
}
