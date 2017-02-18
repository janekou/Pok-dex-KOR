//
//  ViewController.swift
//  포켓몬도감
//
//  Created by Jane on 24/01/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UITabBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
//    var searchController = UISearchController()
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var moves = [Move]()
    var typeRef = [Array<Double>]()
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "포켓몬 이름 또는 번호"
        searchBar.returnKeyType = UIReturnKeyType.done
        parseType()
        parseMoves()
        parsePokemonCSV()
        
        
//        if( traitCollection.forceTouchCapability == .available){
//            registerForPreviewing(with: self as UIViewControllerPreviewingDelegate, sourceView: view)
//        }
//        
        
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            collection.backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            collection.backgroundView = blurEffectView
        }
        
        searchBar.isTranslucent = true
        searchBar.alpha = 0.7
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = UIColor.clear
        
        
        
//        self.title = "PoKéDeX"
//        self.navigationController?.navigationBar.titleTextAttributes =   [NSFontAttributeName: UIFont(name: "Pokemon Solid", size: 23)!, NSForegroundColorAttributeName: UIColor.white]
//        let navigationTitleFont = UIFont(name: "Pokemon Solid", size: 23)!
//        self.navigationController?.navigationBar.titleTextAttributes =   [NSFontAttributeName: navigationTitleFont, NSForegroundColorAttributeName: UIColor.white]
    }
    
    //cancel search by touching other part of the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
//                    print(i)
//                    print(row[String(i)]!)
                    t.append(Double(row[String(i)]!)!)
                }
                typeRef.append(t)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parseMoves() {
        let path = Bundle.main.path(forResource: "attacks_1", ofType: "csv")!
        do {
            //moveset data
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            moves.append(Move(power: 0, cooldown: 0, dps: 0, moveName: "none", moveType: 0, attackType: false))
            for row in rows {
                let power = Int(row["power"]!)!
                let cooldown = Double(row["cooldown"]!)!
                let dps = Double(row["dps"]!)!
                let moveName = row["moveName"]!
                let moveType = Int(row["moveType"]!)!
                var attackType = false
                if(row["moveForm"] == "basic") {
                    attackType = true
                }
                let m = Move(power: power, cooldown: cooldown, dps: dps, moveName: moveName, moveType: moveType, attackType: attackType)
                moves.append(m)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon_KR10", ofType: "csv")!
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
                
                
                let poke = Pokemon(name: name, pokedexId: pokeId, height: Double(height), weight: Double(weight), max_cp: max_cp, attack: attack, defense: Int(defense), stamina: Int(stamina), evolution: evo,type0: type0, type1: type1, quickMoves: quickMoves,chargeMoves: chargeMoves, desc: desc, candy: candy)
                pokemon.append(poke)
                
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            
            
            cell.configureCell(pokemon:poke)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    
    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 0.3
    }
    
    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 1
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        return 251
        //return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        return CGSize(width: 105, height: 105)
        let screenSize: CGRect = UIScreen.main.bounds; let screenWidth = screenSize.width
        return CGSize(width: (screenWidth/3)-0.5, height: (screenWidth/3)-0.5)
    }

        
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            if(isStringAnInt(string: searchBar.text!)) {
                let num = Int(searchBar.text!)
                
                filteredPokemon = pokemon.filter({$0.pokedexId == num})
                collection.reloadData()
            } else {
                let lower = searchBar.text!.lowercased()
            
                filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
                collection.reloadData()
            }
        }
    }

    
    //pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC",
            let detailVC = segue.destination as? PokemonDetailVC,
            let poke = sender as? Pokemon{
            detailVC.pokemon = poke
            detailVC.typeRef = typeRef
            detailVC.poke = pokemon
        }
    }
    
}
