//
//  CalcPokemonDetailVC.swift
//  포켓몬감별사
//
//  Created by Jane on 09/02/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit

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

    
    
    var pokemon: Pokemon!
    var myPokeName = String()
    var myPokeCp = String()
    var myPokeHp = String()
    var typeRef = [Array<Double>]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPokemonName.text = String(pokemon.pokedexId) + myPokeName
        myPokemonImg.image = UIImage(named: "\(pokemon.pokedexId)")
        myPokeMoveSet.text = "내 " + myPokeName + "의 스킬세트"
        myPokemonCp.text = myPokeCp
        myPokemonHp.text = myPokeHp
        baseAttack.text = String(pokemon.attack)
        baseDefense.text = String(pokemon.defense)
        baseStamina.text = String(pokemon.stamina)
        max_cp.text = String(pokemon.max_cp)



//        self.title = name
    }
    

}
