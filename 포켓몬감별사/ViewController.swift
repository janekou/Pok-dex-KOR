//
//  ViewController.swift
//  포켓몬도감
//
//  Created by Jane on 24/01/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit
import AVFoundation
//import Firebase
import GoogleMobileAds
//import AudioToolbox

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UITabBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bannerView: GADBannerView!

    
//    var searchController = UISearchController()
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var moves = [Move]()
    var typeRef = [Array<Double>]()
    var inSearchMode = false
    
    var interstitialAd : GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        bannerView.adUnitID = "ca-app-pub-1925911848721620/9930591193"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
                
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
        let path = Bundle.main.path(forResource: "attacks_2", ofType: "csv")!
        do {
            //moveset data
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            moves.append(Move(power: 0, cooldown: 0, dps: 0, moveName: "none", moveType: 0, moveForm: false))
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
                let m = Move(power: power, cooldown: cooldown, dps: dps, moveName: moveName, moveType: moveType, moveForm: attackType)
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
//                let min_cp = Int(row["min_cp"]!)!
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
                for i in 0...7 {
                    if Int(row["attack"+String(i)]!) != nil {
                        moveset.append(Int(row["attack"+String(i)]!)!)
                    }
                }
                for i in moveset {
                    if(moves[i].moveForm) {
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
    
//    // MARK: -  ADMOB BANNER
//    func initAdMobBanner() {
//        
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            // iPhone
//            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
//            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 320, height: 50)
//        } else  {
//            // iPad
//            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
//            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 468, height: 60)
//        }
//        
//        adMobBannerView.adUnitID = ADMOB_BANNER_UNIT_ID
//        adMobBannerView.rootViewController = self
//        adMobBannerView.delegate = self
//        view.addSubview(adMobBannerView)
//        
//        let request = GADRequest()
//        adMobBannerView.load(request)
//    }
//    
//    
//    // Hide the banner
//    func hideBanner(_ banner: UIView) {
//        UIView.beginAnimations("hideBanner", context: nil)
//        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
//        UIView.commitAnimations()
//        banner.isHidden = true
//    }
//    
//    // Show the banner
//    func showBanner(_ banner: UIView) {
//        UIView.beginAnimations("showBanner", context: nil)
//        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - 2*(banner.frame.size.height), width: banner.frame.size.width, height: banner.frame.size.height)
//        UIView.commitAnimations()
//        banner.isHidden = false
//    }
//    
//    // AdMob banner available
//    func adViewDidReceiveAd(_ view: GADBannerView) {
//        showBanner(adMobBannerView)
//    }
//    
//    // NO AdMob banner available
//    func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
//        hideBanner(adMobBannerView)
//    }
  
//    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
//        print("Banner loaded successfully")
//        tableView.tableHeaderView?.frame = bannerView.frame
//        tableView.tableHeaderView = bannerView
//        
//    }
//
//    func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
//        print("Fail to receive ads")
//        print(error)
//    }
    
}
