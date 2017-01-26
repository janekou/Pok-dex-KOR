//
//  PokemonDetailVC.swift
//  포켓몬도감
//
//  Created by Jane on 25/01/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    // 
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var typeLbl1: UILabel!
    @IBOutlet weak var typeLbl2: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var textview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = "#" + String(pokemon.pokedexId) + " " + pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        heightLbl.text = String(pokemon.height/10) + "m"
        weightLbl.text = String(pokemon.weight) + "kg"
        textview.font = UIFont(name: "morris9", size: 13)
        textview.isSelectable = false
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
