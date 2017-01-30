//
//  ViewController.swift
//  포켓몬도감
//
//  Created by Jane on 24/01/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        initAudio()
        parsePokemonCSV()
        
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "bgmusic", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: nil)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.stop()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon_KR4", ofType: "csv")!
        
        do {
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
                let evolution = Int(row["evolution"]!)!
                let type0 = Int(row["type0"]!)!
                let type1 = Int(row["type1"]!)!
                
                let poke = Pokemon(name: name, pokedexId: pokeId, height: Double(height), weight: Double(weight), max_cp: max_cp, attack: attack, defense: Int(defense), stamina: Int(stamina), evolution: evolution, type0: type0, type1: type1)
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
        
        print(poke.name)
    
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
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
        
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton!) {
        
        if musicPlayer.isPlaying {
            musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
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
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "PokemonDetailVC" {
//            if let detailsVC = segue.destination as? PokemonDetailVC {
//                if let poke = sender as? Pokemon {
//                    detailsVC.pokemon = poke
//                    
//                }
//            }
//        }
//    }
//    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            let navVC = segue.destination as? UINavigationController
            let detailVC = navVC?.viewControllers.first as! PokemonDetailVC
            if let poke = sender as? Pokemon{
            detailVC.pokemon = poke
            }
            }
        }
    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        let navVC = segue.destination as? UINavigationController
//        
//        let tableVC = navVC?.viewControllers.first as! YourTableViewControllerClass
//        
//        tableVC.yourTableViewArray = localArrayValue
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        
//        if (segue.identifier == "showItemSegue") {
//            let navController = segue.destinationViewController as UINavigationController
//            let detailController = navController.topViewController as ShowItemViewController
//            detailController.currentId = nextId!
//        }
//    }
//}
