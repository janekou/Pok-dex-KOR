//
//  PokemonDetailVC.swift
//  포켓몬도감
//
//  Created by Jane on 25/01/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit
import QuartzCore

class PokemonDetailVC: UIViewController,UIGestureRecognizerDelegate {
    
    //
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var max_cp: UILabel!
    @IBOutlet weak var stamina: UILabel!
    @IBOutlet weak var evoImg: UIImageView!
    @IBOutlet weak var type0: UILabel!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var bmove0: UILabel!
    @IBOutlet weak var bmove1: UILabel!
    @IBOutlet weak var smove0: UILabel!
    @IBOutlet weak var smove1: UILabel!
    @IBOutlet weak var smove2: UILabel!
    @IBOutlet weak var bmove0_dmg: UILabel!
    @IBOutlet weak var bmove1_dmg: UILabel!
    @IBOutlet weak var smove0_dmg: UILabel!
    @IBOutlet weak var smove1_dmg: UILabel!
    @IBOutlet weak var smove2_dmg: UILabel!
    @IBOutlet weak var bmove0_cd: UILabel!
    @IBOutlet weak var bmove1_cd: UILabel!
    @IBOutlet weak var smove0_cd: UILabel!
    @IBOutlet weak var smove1_cd: UILabel!
    @IBOutlet weak var smove2_cd: UILabel!
    @IBOutlet weak var bmove0_dps: UILabel!
    @IBOutlet weak var bmove1_dps: UILabel!
    @IBOutlet weak var smove0_dps: UILabel!
    @IBOutlet weak var smove1_dps: UILabel!
    @IBOutlet weak var smove2_dps: UILabel!
    @IBOutlet weak var bmove0_type: UILabel!
    @IBOutlet weak var bmove1_type: UILabel!
    @IBOutlet weak var smove0_type: UILabel!
    @IBOutlet weak var smove1_type: UILabel!
    @IBOutlet weak var smove2_type: UILabel!
    
    @IBOutlet weak var bmove10: UILabel!
    @IBOutlet weak var bmove11: UILabel!
    @IBOutlet weak var bmove12: UILabel!
    @IBOutlet weak var smove10: UILabel!
    @IBOutlet weak var smove11: UILabel!
    @IBOutlet weak var smove12: UILabel!
    @IBOutlet weak var smove20: UILabel!
    @IBOutlet weak var smove21: UILabel!
    @IBOutlet weak var smove22: UILabel!
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var textview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
        
        
        self.navigationController?.navigationBar.topItem?.title = "#" + String(pokemon.pokedexId) + " " + pokemon.name
        let navigationTitleFont = UIFont(name: "morris9", size: 18)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        nameLbl.text = "#" + String(pokemon.pokedexId) + " " + pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        height.text = String(format: "%.2f", pokemon.height/10.0) + "m"
        weight.text = String(format: "%.2f", pokemon.weight/10.0) + "kg"
        attack.text = String(pokemon.attack)
        defense.text = String(pokemon.defense)
        max_cp.text = String(pokemon.max_cp)
        stamina.text = String(pokemon.stamina)
        evoImg.image = UIImage(named: "\(pokemon.evolution)")
        //        type0.text = String(pokemon.type0)
        //        type1.text = String(pokemon.type1)
        
        //type labels settings
        setTypeLabel(l: type0, n: pokemon.type0)
        setTypeLabel(l: type1, n: pokemon.type1)
        
        
        if(pokemon.quickMoves.count==1) {
            setMoveLabelB0(m: pokemon.quickMoves[0])
            removeLabelB1()
        } else {
            setMoveLabelB0(m: pokemon.quickMoves[0])
            setMoveLabelB1(m: pokemon.quickMoves[1])
        }
        
        switch pokemon.chargeMoves.count {
        case 1:
            setMoveLabelS0(m: pokemon.chargeMoves[0])
            removeLabelS1()
            removeLabelS2()
        case 2:
            setMoveLabelS0(m: pokemon.chargeMoves[0])
            setMoveLabelS1(m: pokemon.chargeMoves[1])
            removeLabelS2()
        case 3:
            setMoveLabelS0(m: pokemon.chargeMoves[0])
            setMoveLabelS1(m: pokemon.chargeMoves[1])
            setMoveLabelS2(m: pokemon.chargeMoves[2])
        default:
            break
        }
        
        //textview.font = UIFont(name: "morris9", size: 13)
        //textview.isSelectable = false
        //        self.navigationController!.interactivePopGestureRecognizer?.delegate = self
        //        self.navigationController!.interactivePopGestureRecognizer?.isEnabled = true
        //        self.textview.delegate = self
        //        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self.view, action: #selector (self.swipeGesture))
        //        recognizer.direction = UISwipeGestureRecognizerDirection.left
        //        recognizer.delegate = self
        //        self.view.addGestureRecognizer(recognizer)
    }
    
    func setMoveLabelB0(m: Move) {
        bmove0.text = m.moveName
        bmove0_dmg.text = m.power
        bmove0_cd.text = m.coolDown
        bmove0_dps.text = m.dps
        setTypeLabel(l: bmove0_type, n: m.moveType)
        
    }
    
    func setMoveLabelB1(m: Move) {
        bmove1.text = m.moveName
        bmove1_dmg.text = m.power
        bmove1_cd.text = m.coolDown
        bmove1_dps.text = m.dps
        setTypeLabel(l: bmove1_type, n: m.moveType)
    }
    
    func removeLabelB1() {
        bmove10.removeFromSuperview()
        bmove11.removeFromSuperview()
        bmove12.removeFromSuperview()
        bmove1.removeFromSuperview()
        bmove1_dmg.removeFromSuperview()
        bmove1_cd.removeFromSuperview()
        bmove1_dps.removeFromSuperview()
        bmove1_type.removeFromSuperview()
    }
    
    func setMoveLabelS0(m: Move) {
        smove0.text = m.moveName
        smove0_dmg.text = m.power
        smove0_cd.text = m.coolDown
        smove0_dps.text = m.dps
        setTypeLabel(l: smove0_type, n: m.moveType)
    }
    
    func setMoveLabelS1(m: Move) {
        smove1.text = m.moveName
        smove1_dmg.text = m.power
        smove1_cd.text = m.coolDown
        smove1_dps.text = m.dps
        setTypeLabel(l: smove1_type, n: m.moveType)
    }
    
    func setMoveLabelS2(m: Move) {
        smove2.text = m.moveName
        smove2_dmg.text = m.power
        smove2_cd.text = m.coolDown
        smove2_dps.text = m.dps
        setTypeLabel(l: smove2_type, n: m.moveType)
    }
    
    func removeLabelS1() {
        smove10.removeFromSuperview()
        smove11.removeFromSuperview()
        smove12.removeFromSuperview()
        smove1.removeFromSuperview()
        smove1_dmg.removeFromSuperview()
        smove1_cd.removeFromSuperview()
        smove1_dps.removeFromSuperview()
        smove1_type.removeFromSuperview()
    }
    
    func removeLabelS2() {
        smove20.removeFromSuperview()
        smove21.removeFromSuperview()
        smove22.removeFromSuperview()
        smove2.removeFromSuperview()
        smove2_dmg.removeFromSuperview()
        smove2_cd.removeFromSuperview()
        smove2_dps.removeFromSuperview()
        smove2_type.removeFromSuperview()
    }
    
    
    
    func setTypeLabel(l: UILabel,n: Int) {
        l.textColor = UIColor.white
        l.layer.masksToBounds = true
        l.layer.cornerRadius = 8.0
        switch n {
        case 0:
            l.removeFromSuperview()
            
        case 1:
            l.text=String("노말")
            l.backgroundColor = hexStringToUIColor(hex: "#A8A878")
        case 2:
            l.text=String("격투")
            l.backgroundColor = hexStringToUIColor(hex: "#C03028")
        case 3:
            l.text=String("비행")
            l.backgroundColor = hexStringToUIColor(hex: "#A890F0")
        case 4:
            l.text=String("독")
            l.backgroundColor = hexStringToUIColor(hex: "#A040A0")
        case 5:
            l.text=String("땅")
            l.backgroundColor = hexStringToUIColor(hex: "#896E25")
        case 6:
            l.text=String("바위")
            l.backgroundColor = hexStringToUIColor(hex: "#B8A038")
        case 7:
            l.text=String("벌레")
            l.backgroundColor = hexStringToUIColor(hex: "#92A20F")
        case 8:
            l.text=String("고스트")
            l.backgroundColor = hexStringToUIColor(hex: "#705898")
        case 9:
            l.text=String("강철")
            l.backgroundColor = hexStringToUIColor(hex: "#676793")
        case 10:
            l.text=String("불꽃")
            l.backgroundColor = hexStringToUIColor(hex: "#F08030")
        case 11:
            l.text=String("물")
            l.backgroundColor = hexStringToUIColor(hex: "#6890F0")
        case 12:
            l.text=String("풀")
            l.backgroundColor = hexStringToUIColor(hex: "#78C850")
        case 13:
            l.text=String("전기")
            l.backgroundColor = hexStringToUIColor(hex: "#E0B301")
        case 14:
            l.text=String("에스퍼")
            l.backgroundColor = hexStringToUIColor(hex: "#F85888")
        case 15:
            l.text=String("얼음")
            l.backgroundColor = hexStringToUIColor(hex: "#53E9D9")
        case 16:
            l.text=String("드래곤")
            l.backgroundColor = hexStringToUIColor(hex: "#7038F8")
        case 17:
            l.text=String("악")
            l.backgroundColor = hexStringToUIColor(hex: "#705848")
        case 18:
            l.text=String("페어리")
            l.backgroundColor = hexStringToUIColor(hex: "#FFAEC9")
        default:
            break
        }
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
