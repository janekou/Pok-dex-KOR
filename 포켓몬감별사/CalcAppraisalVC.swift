//
//  CalcAppraisalVC.swift
//  포켓몬감별사
//
//  Created by Jane on 11/02/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit

class CalcAppraisalVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var teamSegements: UISegmentedControl!
    @IBOutlet weak var appraisalList: UITableView!
    
    @IBAction func segementActionChanged(sender: AnyObject) {
        appraisalList.reloadData()
    }

    
    let redList:[String] = ["말할 게 없어. 든든하겠어!","아주 강해, 자랑해도 되겠어!","보통의 강함이라고 생각해!", "배틀이 적성은 아니지만 난 좋아해"]
    let blueList:[String] = ["경이롭고 예술적이야.","시선을 끄는 뭔가가 있어.","보통이상이야", "좀처럼 활약이 어려워 보인다"]
    let yellowList:[String] = ["톱 레벨이야!","아주 강해!","보통이야.", "그저 그러네."]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        switch(teamSegements.selectedSegmentIndex) {
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
        let appraisalCell = tableView.dequeueReusableCell(withIdentifier: "appraisalCell", for: indexPath)
        
        switch(teamSegements.selectedSegmentIndex) {
        case 0:
            appraisalCell.textLabel?.text = redList[indexPath.row]
            break
        case 1:
            appraisalCell.textLabel?.text = blueList[indexPath.row]
            
            break
        case 2:
            appraisalCell.textLabel?.text = yellowList[indexPath.row]
            
            break
        default:
            break
        }
        
        return appraisalCell
    }
    
    
    func myMethod() {}
    
class CalcViewController: UIViewController {
    private var calcAppraisalVC: CalcAppraisalVC!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CalcAppraisalVC, segue.identifier == "CalcAppraisalVC" {
            
            self.calcAppraisalVC = vc
        }
    }
    
    //  Now in other methods you can reference `embeddedViewController`.
    //  For example:
    override func viewDidAppear(_ animated: Bool) {
        self.calcAppraisalVC.myMethod()
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
