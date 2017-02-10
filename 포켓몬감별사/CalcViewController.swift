//
//  CalcViewController.swift
//  포켓몬감별사
//
//  Created by Jane on 08/02/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit


class CalcViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var nameInput: AutoCompleteTextField!
    @IBOutlet weak var cpInput: UITextField!
    @IBOutlet weak var hpInput: UITextField!

    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var moves = [Move]()
    var typeRef = [Array<Double>]()
    var inSearchMode = false
    //array with pokemon names
    var pokeNames = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseType()
        parseMoves()
        parsePokemonCSV()
        createNameArray()
        configureTextField()
//        handleTextFieldInterfaces()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate func configureTextField(){
        nameInput.autoCompleteTextColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        nameInput.autoCompleteTextFont = UIFont(name: "HelveticaNeue-Light", size: 12.0)!
        nameInput.autoCompleteCellHeight = 35.0
        nameInput.maximumAutoCompleteCount = 20
        nameInput.hidesWhenSelected = true
        nameInput.hidesWhenEmpty = true
        nameInput.enableAttributedText = true
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.black
        attributes[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        nameInput.autoCompleteAttributes = attributes
    }
    
//    fileprivate func handleTextFieldInterfaces(){
//        nameInput.onTextChange = {[weak self] text in
//            if !text.isEmpty{
//                if let dataTask = self?.dataTask {
//                    dataTask.cancel()
//                }
//                self?.fetchAutocompletePlaces(text)
//            }
//        }
    
//        nameInput.onSelect = {[weak self] text, indexpath in
//            Location.geocodeAddressString(text, completion: { (placemark, error) -> Void in
//                if let coordinate = placemark?.location?.coordinate {
//                    self?.addAnnotation(coordinate, address: text)
//                    self?.mapView.setCenterCoordinate(coordinate, zoomLevel: 12, animated: true)
//                }
//            })
//        }
//    }

    
    
    //cancel search by touching other part of the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let calcDetailVC: CalcPokemonDetailVC = segue.destination as! CalcPokemonDetailVC
//        calcDetailVC.name = !
        calcDetailVC.cp = cpInput.text!
        calcDetailVC.hp = hpInput.text!
        
    }
    
    func createNameArray() {
        for i in 0...pokemon.count-1 {
            pokeNames.append(pokemon[i].name)
        }
    }

    func parseType() {
        let path = Bundle.main.path(forResource: "type_ref", ofType: "csv")!
        do {
            //moveset data
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            var t = Array<Double>()
            for _ in 1...18 {
                t.append(1)
            }
            typeRef.append(t)
            for row in rows {
                t = Array<Double>()
                for i in 1...18 {
                    t.append(Double(row[String(i)]!)!)
                }
                typeRef.append(t)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parseMoves() {
        let path = Bundle.main.path(forResource: "attacks", ofType: "csv")!
        do {
            //moveset data
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            moves.append(Move(power: 0,cooldown: 0,moveName: "none",moveType: 0,attackType: false))
            for row in rows {
                let power = Int(row["_power"]!)!
                let cooldown = Double(row["_damage_duration"]!)!
                let moveName = row["move"]!
                let moveType = Int(row["_typePokemon"]!)!
                var attackType = false
                if(row["_typeAttack"] == "basic") {
                    attackType = true
                }
                let m = Move(power: power,cooldown: cooldown,moveName: moveName,moveType: moveType,attackType: attackType)
                moves.append(m)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon_KR9", ofType: "csv")!
        do {
            //pokemon data
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier_KR"]!
                let height = Int(row["height"]!)!
                let weight = Int(row["weight"]!)!
                let max_cp = Int(row["max_cp"]!)!
                let attack = Int(row["attack"]!)!
                let defense = Int(row["defense"]!)!
                let stamina = Int(row["stamina"]!)!
                let type0 = Int(row["type0"]!)!
                let type1 = Int(row["type1"]!)!
                let desc = row["desc"]!
                let evolution = Int(row["evolution"]!)!
                var evo = [Int]()
                if(evolution > 0) {
                    //                    print (evolution)
                    for i in 0 ..< evolution {
                        let index = "evo"+String(i+1)
                        //                        print (index)
                        //                        print (name)
                        evo.append(Int(row[index]!)!)
                    }
                }
                var candy = 0
                if(row["candy"] != "") {
                    candy = Int(row["candy"]!)!
                }
                var quickMoves = Array<Move>()
                var chargeMoves = Array<Move>()
                
                var moveset = Array<Int>()
                for i in 0...4 {
                    if Int(row["attack"+String(i)]!) != nil {
                        moveset.append(Int(row["attack"+String(i)]!)!)
                    }
                }
                for i in moveset {
                    if(moves[i].attackType) {
                        quickMoves.append(moves[i])
                    } else {
                        chargeMoves.append(moves[i])
                    }
                }
                
                
                let poke = Pokemon(name: name, pokedexId: pokeId, height: Double(height), weight: Double(weight), max_cp: max_cp, attack: attack, defense: Int(defense), stamina: Int(stamina), evolution: evo, type0: type0, type1: type1, quickMoves: quickMoves,chargeMoves: chargeMoves, desc: desc, candy: candy)
                pokemon.append(poke)
                
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
//    @IBAction func showPopUp(_ sender: Any) {
//        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID")
//        self.addChildViewController(popOverVC)
//        self.view.addSubview(popOverVC.view)
//        popOverVC.didMove(toParentViewController: self)
//    
//    }
//    

    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("prepare")
//        if segue.identifier == "sbPopUpID" {
//            print("popover check")
//            let popOverVC = segue.destination as PopUpViewController
//            popOverVC = UIModalPresentationStyle.popover
//            popOverVC!.delegate = self
//        }
//    }
//    
//    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
//        return UIModalPresentationStyle.none
//    }

}
