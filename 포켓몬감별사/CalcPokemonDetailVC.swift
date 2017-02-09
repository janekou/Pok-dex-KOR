//
//  CalcPokemonDetailVC.swift
//  포켓몬감별사
//
//  Created by Jane on 09/02/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit

class CalcPokemonDetailVC: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonLvl: UILabel!
    @IBOutlet weak var pokemonCp: UILabel!
    @IBOutlet weak var PokemonHp: UILabel!
    
    

    var name = String()
//    var level = String()
    var cp = String()
    var hp = String()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonName.text = name
//        pokemonLvl.text = name
        pokemonCp.text = cp
        PokemonHp.text = hp
        
        
        self.title = pokemonName.text;
    }
    

}
