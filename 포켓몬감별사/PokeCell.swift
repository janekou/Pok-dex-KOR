//
//  PokeCell.swift
//  포켓몬도감
//
//  Created by Jane on 24/01/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg:UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 20.0
        layer.borderWidth = 0
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
    
        nameLbl.text = "#" + String(self.pokemon.pokedexId) + " " + self.pokemon.name
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
