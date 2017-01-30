//
//  PokemonDetailVC.swift
//  포켓몬도감
//
//  Created by Jane on 25/01/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController,UIGestureRecognizerDelegate {

    // 
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var max_cp: UILabel!
    @IBOutlet weak var stamina: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var textview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "#" + String(pokemon.pokedexId) + " " + pokemon.name
        let navigationTitleFont = UIFont(name: "morris9", size: 16)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        nameLbl.text = "#" + String(pokemon.pokedexId) + " " + pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        height.text = String(format: "%.2f", pokemon.height/10.0) + "m"
        weight.text = String(format: "%.2f", pokemon.weight/10.0) + "kg"
        attack.text = String(pokemon.attack)
        defense.text = String(pokemon.defense)
        max_cp.text = String(pokemon.max_cp)
        stamina.text = String(pokemon.stamina)
        
        
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
    
    func swipeGesture() {
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
