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
    @IBOutlet weak var myPokemonCp: UILabel!
    @IBOutlet weak var myPokemonHp: UILabel!
    @IBOutlet weak var myPokeMoveSet: UILabel!
    
    
    var pokemon: Pokemon!
    var myPokeName = String()
    var myPokeCp = String()
    var myPokeHp = String()
    var max_cp = String()
    var typeRef = [Array<Double>]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPokemonName.text = myPokeName
        myPokemonImg.image = UIImage(named: "\(pokemon.pokedexId)")
        myPokemonCp.text = myPokeCp
        myPokemonHp.text = myPokeHp
        myPokeMoveSet.text = "내 " + myPokeName + "의 스킬세트"
        
        
//        self.title = name
    }
    

}
