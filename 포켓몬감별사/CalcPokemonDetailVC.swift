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
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonLvl: UILabel!
    @IBOutlet weak var pokemonCp: UILabel!
    @IBOutlet weak var PokemonHp: UILabel!
    @IBOutlet weak var myPokeMoveSet: UILabel!
    
    

    var name = String()
//    var level = String()
    var cp = String()
    var hp = String()
    var max_cp = String()
    var typeRef = [Array<Double>]()
    var pokemon: Pokemon!

//    var pokemon = [Pokemon]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonName.text = name
//        pokemonLvl.text = name
        pokemonCp.text = cp
        PokemonHp.text = hp
        myPokeMoveSet.text = "내 " + name + "의 스킬세트"
        
        
//        self.title = name
    }
    

}
