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
    @IBOutlet weak var typeLbl1: UILabel!
    @IBOutlet weak var typeLbl2: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
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
        heightLbl.text = String(format: "%.2f", pokemon.height/10.0) + "m"
        weightLbl.text = String(format: "%.2f", pokemon.weight/10.0) + "kg"
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        //textview.font = UIFont(name: "morris9", size: 13)
        //textview.isSelectable = false
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(PokemonDetailVC.popViewController))
//        swipeRight.direction = UISwipeGestureRecognizerDirection.right
//        self.view.addGestureRecognizer(swipeRight)
        addTarget(PokemonDetailVC)
        let swiperight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(PokemonDetailVC.swiperight(_:)))
        swiperight.direction = .right
        self.view!.addGestureRecognizer(swiperight)
    }
    func swiperight(gestureRecognizer: UISwipeGestureRecognizer) {
        //Do what you want here
        //Load Signup view controller here
        
        let viewController: ViewController = ViewController(nibName: nil, bundle: nil)
            // and push it onto the 'navigation stack'
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    
//    func popViewController(gesture: UIGestureRecognizer) {
//        
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//            switch swipeGesture.direction {
//            case UISwipeGestureRecognizerDirection.right:
//                self.navigationController?.popViewController(animated:true)
//            default:
//                break
//            }
//        }
//    }
    
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
