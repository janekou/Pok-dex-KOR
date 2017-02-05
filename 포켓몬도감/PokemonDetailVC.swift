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
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var max_cp: UILabel!
    @IBOutlet weak var stamina: UILabel!
    @IBOutlet weak var evoImg1: UIImageView!
    @IBOutlet weak var evoImg2: UIImageView!
    @IBOutlet weak var evoImg3: UIImageView!
    @IBOutlet weak var evoImg4: UIImageView!
    @IBOutlet weak var evoImg5: UIImageView!
    @IBOutlet weak var evoLbl1: UILabel!
    @IBOutlet weak var evoLbl2: UILabel!
    @IBOutlet weak var evoLbl3: UILabel!
    @IBOutlet weak var evoLbl4: UILabel!
    @IBOutlet weak var evoLbl5: UILabel!
    @IBOutlet weak var evoStack1: UIStackView!
    @IBOutlet weak var evoStack2: UIStackView!
    
    
    @IBOutlet weak var type0: UILabel!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var bmove: UILabel!
    @IBOutlet weak var smove: UILabel!
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
    
    @IBOutlet weak var bmove00: UILabel!
    @IBOutlet weak var bmove01: UILabel!
    @IBOutlet weak var bmove02: UILabel!
    @IBOutlet weak var bmove10: UILabel!
    @IBOutlet weak var bmove11: UILabel!
    @IBOutlet weak var bmove12: UILabel!
    
    @IBOutlet weak var baseStack0: UIStackView!
    @IBOutlet weak var baseStack1: UIStackView!
    
    @IBOutlet weak var smove00: UILabel!
    @IBOutlet weak var smove01: UILabel!
    @IBOutlet weak var smove02: UILabel!
    @IBOutlet weak var smove10: UILabel!
    @IBOutlet weak var smove11: UILabel!
    @IBOutlet weak var smove12: UILabel!
    @IBOutlet weak var smove20: UILabel!
    @IBOutlet weak var smove21: UILabel!
    @IBOutlet weak var smove22: UILabel!
    
    @IBOutlet weak var specialStack0: UIStackView!
    @IBOutlet weak var specialStack1: UIStackView!
    @IBOutlet weak var specialStack2: UIStackView!
    
    
    @IBOutlet weak var candy: UILabel!
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var textview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
        
        
        self.navigationController?.navigationBar.topItem?.title = "#" + String(pokemon.pokedexId) + " " + pokemon.name
        let navigationTitleFont = UIFont(name: "GodoM", size: 18)!
        self.navigationController?.navigationBar.titleTextAttributes =   [NSFontAttributeName: navigationTitleFont, NSForegroundColorAttributeName: UIColor.white]
        nameLbl.text = "#" + String(pokemon.pokedexId) + " " + pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        height.text = String(format: "%.2f", pokemon.height/10.0) + "m"
        weight.text = String(format: "%.2f", pokemon.weight/10.0) + "kg"
        attack.text = String(pokemon.attack)
        defense.text = String(pokemon.defense)
        max_cp.text = String(pokemon.max_cp)
        stamina.text = String(pokemon.stamina)
        setEvo(e: pokemon.evolution)
        if(pokemon.candy > 0) {
            candy.text = "필요한 캔디 수  " + String(pokemon.candy)
        } else {
            candy.text = "더 이상 진화하지 않는다."
        }
        //type labels settings
        setTypeLabel(l: type0, n: pokemon.type0)
        setTypeLabel(l: type1, n: pokemon.type1)
        desc.text = pokemon.desc
        
        if(pokemon.quickMoves.count==1) {
            setMoveLabelB0(m: pokemon.quickMoves[0])
            baseStack1.removeFromSuperview()
        } else if(pokemon.quickMoves.count>1) {
            setMoveLabelB0(m: pokemon.quickMoves[0])
            setMoveLabelB1(m: pokemon.quickMoves[1])
        } else {
            baseStack1.removeFromSuperview()
            baseStack0.removeFromSuperview()
        }
        
        switch pokemon.chargeMoves.count {
        case 0:
            specialStack0.removeFromSuperview()
            specialStack1.removeFromSuperview()
            specialStack2.removeFromSuperview()
        case 1:
            setMoveLabelS0(m: pokemon.chargeMoves[0])
            specialStack1.removeFromSuperview()
            specialStack2.removeFromSuperview()
        case 2:
            setMoveLabelS0(m: pokemon.chargeMoves[0])
            setMoveLabelS1(m: pokemon.chargeMoves[1])
            specialStack2.removeFromSuperview()
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
    
    func setEvo(e: Array<Int>) {
        switch e.count {
        case 0:
            evoStack1.removeFromSuperview()
            evoStack2.removeFromSuperview()
        case 1:
            //1 change 1, remove 3,4,5
            evoImg1.image = UIImage(named: String(e[0]))
            evoLbl1.text = String(pokemon.name)
            evoImg2.removeFromSuperview()
            evoLbl2.removeFromSuperview()
            evoImg3.removeFromSuperview()
            evoLbl3.removeFromSuperview()
            evoStack2.removeFromSuperview()
        case 2:
            //2 remove 1,2,3
            evoImg4.image = UIImage(named: String(e[0]))
            evoLbl4.text = String(pokemon.name)
            evoImg5.image = UIImage(named: String(e[1]))
            evoLbl5.text = String(pokemon.name)

            evoStack1.removeFromSuperview()
        case 3:
            //3 remove 4,5
            evoImg1.image = UIImage(named: String(e[0]))
            evoLbl1.text = String(pokemon.name)
            evoImg2.image = UIImage(named: String(e[1]))
            evoLbl2.text = String(pokemon.name)
            evoImg3.image = UIImage(named: String(e[2]))
            evoLbl3.text = String(pokemon.name)
            evoStack1.removeFromSuperview()
        case 5:
            evoImg1.image = UIImage(named: String(e[0]))
            evoLbl1.text = String(pokemon.name)
            evoImg2.image = UIImage(named: String(e[1]))
            evoLbl2.text = String(pokemon.name)
            evoImg3.image = UIImage(named: String(e[2]))
            evoLbl3.text = String(pokemon.name)
            evoImg4.image = UIImage(named: String(e[3]))
            evoLbl4.text = String(pokemon.name)
            evoImg5.image = UIImage(named: String(e[4]))
            evoLbl5.text = String(pokemon.name)
        default:
            break
        }
        
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
