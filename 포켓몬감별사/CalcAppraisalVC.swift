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
    
    
    @IBOutlet weak var closeView: UIButton!
    let headerTitles = ["IV 총합", "종족치", "가장 높은 IV"]
    let redList = [["말할 게 없어. 든든하겠어!","아주 강해, 자랑해도 되겠어!","보통의 강함이라고 생각해!", "배틀이 적성은 아니지만 난 좋아해"], ["HP", "공격", "방어"], ["최고야! 가슴이 뜨거워져!", "훌륭해! 두근거려!", "꽤 강하네. 배틀에서 활약할 것 같아!", "그럭저럭 강한거네."]]
    let blueList = [["경이롭고 예술적이야.","시선을 끄는 뭔가가 있어.","보통이상이야", "좀처럼 활약이 어려워 보인다"], ["HP", "공격", "방어"], ["측정할 수 없을 정도로 높아! 최고야!", "훌륭해! 놀라워!", "꽤 강하다고 말할 수 있군.", "그럭저럭이라고 할 수 있군."]]
    let yellowList = [["톱 레벨이야!","아주 강해!","보통이야.", "그저 그러네."], ["HP", "공격", "방어"], ["지금까지 본 것중에서도 최고의 부류야!", "훌륭해! 정말이야!", "꽤 강한데! 내가 보증하지!", "그럭저럭, 이야!"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        
        (teamSegments.subviews[2] as UIView).tintColor = UIColor.red
        (teamSegments.subviews[1] as UIView).tintColor = UIColor.blue
        (teamSegments.subviews[0] as UIView).tintColor = UIColor(red: 254.0/255.0, green: 216.0/255.0, blue: 80.0/255.0, alpha: 1.0)
       
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
//        if section < headerTitles.count {
//            return headerTitles[section]
//        }
//        return nil
        return headerTitles[section]

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var returnValue = 0
        var returnValue:Int?
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
        
        return returnValue!
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = appraisalList.cellForRow(at: indexPath as IndexPath)
        let sectionNumber = indexPath.section
        tableView.deselectRow(at:indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let sr = tableView.indexPathsForSelectedRows
                if sr?.count == 0 {
                    selectedCell?.accessoryType = .checkmark
                } else {
                    for i in 0 ..< appraisalList.numberOfRows(inSection: sectionNumber) {
                        if let cell = appraisalList.cellForRow(at: IndexPath (row: i, section: sectionNumber)) {
                        cell.accessoryType = .none
                        }
                    }

                    if selectedCell?.accessoryType == .checkmark {
                        selectedCell?.accessoryType = .none
                    } else {
                        selectedCell?.accessoryType = .checkmark
                            }
            }
            break
        case 1:
            if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            break
        case 2:
            let sr = tableView.indexPathsForSelectedRows
            if sr?.count == 0 {
                selectedCell?.accessoryType = .checkmark
            } else {
                for i in 0 ..< appraisalList.numberOfRows(inSection: sectionNumber) {
                    if let cell = appraisalList.cellForRow(at: IndexPath (row: i, section: sectionNumber)) {
                        cell.accessoryType = .none
                    }
                }
                
                if selectedCell?.accessoryType == .checkmark {
                    selectedCell?.accessoryType = .none
                } else {
                    selectedCell?.accessoryType = .checkmark
                }
            }
            break
        default:
            break

        }
    }




}
