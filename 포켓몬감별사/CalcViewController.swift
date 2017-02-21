//
//  CalcViewController.swift
//  포켓몬감별사
//
//  Created by Jane on 08/02/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import UIKit
import GoogleMobileAds


class CalcViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var nameList: UITableView!
    @IBOutlet weak var cpInput: UITextField!
    @IBOutlet weak var hpInput: UITextField!
    @IBOutlet weak var sdInput: UITextField!
    @IBOutlet weak var yesorno: UISegmentedControl!
    @IBOutlet weak var sdPickerView: UIPickerView!
    
    @IBAction func goButton(_ sender: Any) {
//        if ( nameInput.text!.isEmpty || cpInput.text!.isEmpty || hpInput.text!.isEmpty || sdInput.text!.isEmpty || yesorno.selectedSegmentIndex == -1) {
//            showAlert(title: "빈칸이 있습니다", message: "채워랏")
//        }
//        else{
//            
//            return
//        }
    }
    
//    @IBAction func teamAppraisalBtn(_ sender: Any) {
//        if appraisalView.isHidden == true {
//            (sender as AnyObject).setTitle("⁶팀 리더 포켓몬 조사 ▲", for: .normal)
//        } else {
//            (sender as AnyObject).setTitle("⁶팀 리더 포켓몬 조사 ▼", for: .normal)
//        }
//        
//        appraisalView.isHidden = !appraisalView.isHidden
//    }

    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var moves = [Move]()
    var typeRef = [Array<Double>]()
    var inSearchMode = false
    var sdPickerOptions = ["200", "400", "600", "800", "1000", "1300", "1600", "1900", "2200", "2500", "3000", "3500", "4000", "4500", "5000", "6000", "7000", "8000", "9000", "10000"];
    
    //array with pokemon names
    var pokeNames = Array<String>()
    var autocompleteWords = [String]()

    let numberToolbar: UIToolbar = UIToolbar()
    
    var interstitialAd : GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        bannerView.adUnitID = "ca-app-pub-1925911848721620/9930591193"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
//        self.hideKeyboard()
        
        
        nameInput.addTarget(self, action: #selector(CalcViewController.didChangeText(_:)), for: .editingChanged)
//        nameInput.delegate = self
//        nameList.delegate = self
//        nameList.dataSource = self
//        sdPickerView.delegate = self
//        sdPickerView.dataSource = self
        nameList.isHidden = true

        
        // hide empty tableview cells
        let backgroundView = UIView(frame: CGRect.zero)
        let defaultBorderColor : UIColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        
        //nameList style
        nameList.tableFooterView = backgroundView
        nameList.separatorColor = UIColor.lightGray
        nameList.backgroundColor = UIColor.white
        nameList.separatorStyle = .singleLine
        nameList.separatorInset = UIEdgeInsets.init(top: 5, left: 15, bottom: 15, right: 15)
        nameList.layer.borderWidth = 0.5
        nameList.layer.borderColor = defaultBorderColor.cgColor
        nameList.layer.cornerRadius = 5
        
        sdPickerView.backgroundColor = UIColor.white
        sdPickerView.layer.borderWidth = 0.5
        sdPickerView.layer.borderColor = defaultBorderColor.cgColor
        sdPickerView.layer.cornerRadius = 5
        
        // yesorno segmentcontrol tint color
        let array = yesorno.subviews
        array[0].tintColor = defaultBorderColor
        array[1].tintColor = defaultBorderColor

        //add next button to numberpad + style
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "다음", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CalcViewController.returnBtn))
        ]
        numberToolbar.sizeToFit()
        cpInput.inputAccessoryView = numberToolbar
        hpInput.inputAccessoryView = numberToolbar
        sdInput.inputAccessoryView = numberToolbar

//        //disable keyboard for sdInput
//        sdInput.isUserInteractionEnabled = false
        
        parseType()
        parseMoves()
        parsePokemonCSV()
        createNameArray()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // next button on numberpad
    func returnBtn () {
        cpInput.resignFirstResponder()
        hpInput.resignFirstResponder()
        sdInput.resignFirstResponder()
    }

    // alert message popup
    func showAlert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController(title: "빈칸이 있습니다.", message: "정보를 모두 기입해 주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
//    func hideKeyboard() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(CalcViewController.dismissKeyboard))
//        
//        view.addGestureRecognizer(tap)
//    }
//    
//    func dismissKeyboard() {
//        view.endEditing(true)
//    }
    
//    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
//        if gestureRecognizer is UITapGestureRecognizer {
//            let location = touch.location(in: nameList)
//            return (nameList.indexPathForRow(at: location) == nil)
//        }
//        return true
//    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool
//    {
//        // Try to find next responder
//        if let nextField = nameInput.superview?.viewWithTag(nameInput.tag + 1) as? UITextField {
//            nextField.becomeFirstResponder()
//        } else {
//            // Not found, so remove keyboard.
//            nameInput.resignFirstResponder()
//        }
//        // Do not add a line break
//        return false
//    }
    
    // recognize input and unhide nameList
    func didChangeText(_ textField:UITextField) {
        
        if textField == nameInput {
            
            let substring = (textField.text! as NSString).replacingCharacters(in: NSRange(location: 0, length: textField.text!.characters.count), with: textField.text!)
            
            searchAutocompleteWordsWithSubstring(substring as String)
            
            if (textField.text?.isEmpty)! {
                nameList.isHidden = true
            } else {
            nameList.isHidden = false
            nameList.reloadData()
            }
        }
    }
    
    //do not show keyboard nor cursor
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == sdInput {
            self.view.endEditing(true)
            sdPickerView.isHidden = false
//            sdInput.resignFirstResponder()
            return false
        }
        return true
    }
    
    func searchAutocompleteWordsWithSubstring(_ substring: String) {
        // clean up array
        autocompleteWords.removeAll(keepingCapacity: false)
        
        for word in pokeNames
        {
            let myString: NSString! = word as NSString
            
            // do a case insensitive search for words in the .txt files
            let substringRange:NSRange! = myString.range(of: substring, options: .caseInsensitive)
            
            if (substringRange.location == 0)
            {
                autocompleteWords.append(word)
            }
        }
        
        nameList!.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocompleteWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "Cell")
        
        // make autocomplete cell text appear bold for the characters typed in
        let item = autocompleteWords[indexPath.row]
        let text = NSMutableAttributedString(string: item)
        let font = UIFont.boldSystemFont(ofSize: cell.textLabel!.font.pointSize)
        
        text.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: nameInput.text!.characters.count))
        
        cell.textLabel!.attributedText = text
        
        cell.textLabel?.textColor = UIColor.darkGray

        // no background color or selection style for cells
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pickedCell : UITableViewCell = tableView.cellForRow(at: indexPath)!
        nameInput.text = pickedCell.textLabel!.text
        nameList.isHidden = true
        
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath as IndexPath)
        cell!.contentView.backgroundColor = UIColor(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 0.1)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath as IndexPath)
        cell!.contentView.backgroundColor = .clear

    }
    
    
    ////////////////////////picker view delegate methods
    
    //number of columns in the picker element
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //number of rows of data in the UIPickerView element
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        print(sdPickerOptions.count)
        return sdPickerOptions.count;
    }
    
    //data for a specific row and specific component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sdPickerOptions[row]
    }
    
    //Update textfield text when row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sdInput.text = sdPickerOptions[row]
        sdPickerView.isHidden = true

    }
    
    //
    func addTextFiles(_ textFiles: [String]) {
        
        for textFile in textFiles {
            
            let path = Bundle.main.path(forResource: textFile, ofType: "txt")!
            
            let content = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
            
            pokeNames.append(contentsOf: content.components(separatedBy: "\n"))
        }
    }

    
    
    //cancel search by touching other part of the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

   
    
    func createNameArray() {
        for i in 0...pokemon.count-1 {
            pokeNames.append(pokemon[i].name)
        }
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
                    t.append(Double(row[String(i)]!)!)
                }
                typeRef.append(t)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parseMoves() {
        let path = Bundle.main.path(forResource: "attacks_1", ofType: "csv")!
        do {
            //moveset data
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            moves.append(Move(power: 0, cooldown: 0, dps: 0, moveName: "none", moveType: 0, attackType: false))
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
                let m = Move(power: power, cooldown: cooldown, dps: dps, moveName: moveName, moveType: moveType, attackType: attackType)
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
                for i in 0...4 {
                    if Int(row["attack"+String(i)]!) != nil {
                        moveset.append(Int(row["attack"+String(i)]!)!)
                    }
                }
                for i in moveset {
                    if(moves[i].attackType) {
                        quickMoves.append(moves[i])
                    } else {
                        chargeMoves.append(moves[i])
                    }
                }
                
                
                let poke = Pokemon(name: name, pokedexId: pokeId, height: Double(height), weight: Double(weight), max_cp: max_cp, attack: attack, defense: Int(defense), stamina: Int(stamina), evolution: evo, type0: type0, type1: type1, quickMoves: quickMoves,chargeMoves: chargeMoves, desc: desc, candy: candy)
                pokemon.append(poke)
                
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    // pass data to CalcPokemonDetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CalcPokemonDetailVC" {
            let calcDetailVC = segue.destination as! CalcPokemonDetailVC
//                calcDetailVC.typeRef = typeRef
                calcDetailVC.myPokeName = nameInput.text!
                calcDetailVC.myPokeCp = cpInput.text!
                calcDetailVC.myPokeHp = hpInput.text!
                calcDetailVC.mySdCost = sdInput.text!
                calcDetailVC.powerUp = yesorno.selectedSegmentIndex
                filteredPokemon = pokemon.filter({$0.name.range(of: nameInput.text!) != nil})
            if(filteredPokemon.count>0) {
                calcDetailVC.pokemon = filteredPokemon[0]
            }
            
        } else {
            _ = segue.destination as! CalcAppraisalVC
        }
    }
}

