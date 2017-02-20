//
//  CalcPokemonDetailVC.swift
//  포켓몬감별사
//
//  Created by Jane on 09/02/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CalcPokemonDetailVC: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var myPokemonName: UILabel!
    @IBOutlet weak var myPokemonImg: UIImageView!
    @IBOutlet weak var myPokeMoveSet: UILabel!
    @IBOutlet weak var myPokemonCp: UILabel!
    @IBOutlet weak var myPokemonHp: UILabel!
    @IBOutlet weak var baseAttack: UILabel!
    @IBOutlet weak var baseDefense: UILabel!
    @IBOutlet weak var baseStamina: UILabel!
    @IBOutlet weak var max_cp: UILabel!

    @IBOutlet weak var ivStack0: UIStackView!
    @IBOutlet weak var ivStack1: UIStackView!    
    @IBOutlet weak var ivRange: UILabel!
    @IBOutlet weak var ivAttack: UILabel!
    @IBOutlet weak var ivDefense: UILabel!
    @IBOutlet weak var ivStamina: UILabel!


    
    @IBOutlet weak var bannerView: GADBannerView!

    
    var pokemon: Pokemon!
    var myPokeName = String()
    var myPokeCp = String()
    var myPokeHp = String()
    var mySdCost = String()
    var typeRef = [Array<Double>]()
    var sdToCpm = [String:[String]]()//600 = [0.2,0.3]
    var cpms = [String]()
    
    var interstitialAd : GADInterstitial!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        bannerView.adUnitID = "ca-app-pub-1925911848721620/9930591193"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        parseCPMCSV()
        myPokemonName.text = String(pokemon.pokedexId) + myPokeName
        myPokemonImg.image = UIImage(named: "\(pokemon.pokedexId)")
        myPokeMoveSet.text = "내 " + myPokeName + "의 스킬세트"
        myPokemonCp.text = myPokeCp
        myPokemonHp.text = myPokeHp
        baseAttack.text = String(pokemon.attack)
        baseDefense.text = String(pokemon.defense)
        baseStamina.text = String(pokemon.stamina)
        max_cp.text = String(pokemon.max_cp)
        
        
        
        
        
        
        getIV(hp:Int(myPokeHp)!, cp:Int(myPokeCp)!, mySdCost:mySdCost)
        
        print (possIVs.count)
        var perc = [Double]()
        for iv in possIVs {
            print ("possible")
            print ("att " + String(iv[0]))
            print ("def " + String(iv[1]))
            print ("sta " + String(iv[2]))
            perc.append(Double(iv[0]+iv[1]+iv[2])/45)
            
        }
        ivAttack.text = String(possIVs[0][0])
        ivDefense.text = String(possIVs[0][1])
        ivStamina.text = String(possIVs[0][2])
        
        perc = perc.sorted(by: <)
        for p in perc {
            print (String(p))
        
        if perc.count == 1 {
            ivRange.text = String(format: "%0.1f", perc[0]*100) + "%"
            ivStack1.removeFromSuperview()

        }else {
            ivRange.text = String(format: "%0.1f", perc[0]*100) + "~" + String(format: "%0.1f", perc[perc.count-1]*100) + "%"
            ivStack0.removeFromSuperview()
        }
        
        }
        
        
        
        
        
        
        /**
        
        //hp = ecpm* (baseStm + IndStm)
        var indSta = [Int]()
        var sta = 0
        for cpm in sdToCpm[mySdCost]! {
            sta = Int(round(Double(myPokeHp)!/Double(cpm)!)) - pokemon.stamina
//            print (sta)
            indSta.append(sta)
        }
        
        var possVal = [Int:[Double]]();
        var knownVal = 0.0;
        var vals = [Double]()
        //(BaseSta + IndSta)^0.5 * (ECpM)^2 / 10
        for sta in indSta {
            for cpm in sdToCpm[mySdCost]! {
                knownVal = pow(Double(pokemon.stamina + sta),0.5) * pow(Double(cpm)!,2) / 10
                if(possVal[sta]==nil) {
                    vals = [Double]()
                } else {
                    vals = possVal[sta]!
                }
                print (knownVal);
                vals.append(knownVal)
                possVal[sta] = vals
            }
        }
         */
        
        // cp =(BaseAtk + IndAtk) * (BaseDef + IndDef)^0.5 * possVal
        // IndAtk = (cp / (BaseDef + IndDef)^0.5 * possVal) - BaseAtk
        // cp / possval = ((cp/possval / (BaseDef + IndDef)^0.5)) * (BaseDef + IndDef)^0.5
        
        
        // cp =(BaseAtk + (cp / (BaseDef + IndDef)^0.5 * possVal) - BaseAtk) * (BaseDef + IndDef)^0.5 * possVal
        
        

    }
    
    
    
    func compSta (sta: Int, cpm: Double) -> Double  {
        let sta = Double(pokemon.stamina+sta) * cpm
        return max(10,sta)
    }
    
    func compAtt (att: Int, cpm: Double) -> Double {
        let att = Double(pokemon.attack+att) * cpm
        return max(10,att)
    }
    
    func compDef (def: Int, cpm: Double) -> Double {
        let def = Double(pokemon.defense+def) * cpm
        return max(10,def)
    }
    
    func getCp (sta: Int, att: Int, def: Int, cpm: Double) -> Int {
        let cp = Int(floor( 0.1 * pow(compSta(sta:sta,cpm:cpm),0.5) * compAtt(att:att,cpm:cpm) * pow(compDef(def:def,cpm:cpm),0.5)))
        return cp
    }
    
    
    //        sdToCpm["4000"] = [0.667934,0.674577537,0.68116492,0.687680648]
    
    var possIVs = [[Int]]()
    
    func getIV (hp:Int, cp:Int, mySdCost:String){
        
        
        for cpm in sdToCpm[mySdCost]! {
            
            let m = Double(cpm)!
            
            //possible staminas
            var pSta = [Int]()
            //get stamina based on hp
            for i in 0...15 {
                if(Int(floor(compSta(sta:i,cpm:m))) == hp) {
                    pSta.append(i);
                }
            }
            
            for sta in pSta {
                for def in 0...15 {
                    for att in 0...15{
                        let possCp = getCp(sta: sta, att:att, def: def, cpm: m)
                        if(cp==possCp) {
                            possIVs.append([att, def, sta])
                        }
                        
                    }
                }
            }
        }
    }
    
    

    
    func parseCPMCSV() {
        let path = Bundle.main.path(forResource: "cpm", ofType: "csv")!
        do {
            //cpm and dust data
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                let cpm = row["cpm"]!
//                let pokeLvl = Int(row["pokeLvl"]!)!
//                let powerup_num = Int(row["powerup_num"]!)!
                let sd_lvl = row["sd_lvl"]!
//                let candy_lvl = Int(row["candy_lvl"]!)!
//                let sd_cum = Int(row["sd_cum"]!)!
//                let candy_cum = Int(row["candy_cum"]!)!
                if(sdToCpm[sd_lvl] == nil) {
                    cpms = [String]()
                } else {
                    cpms = sdToCpm[sd_lvl]!
                }
                cpms.append(cpm)
                sdToCpm[sd_lvl] = cpms
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    

}
