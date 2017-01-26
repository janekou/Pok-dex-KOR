//
//  Pokemon.swift
//  포켓몬도감
//
//  Created by Jane on 24/01/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import Foundation

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: Int!
    fileprivate var _height: Int!
    fileprivate var _weight: Int!
    fileprivate var _attack: Int!
    
    
    var name: String {
        return _name
    }
    
    var height: Int {
        return _height
    }
    
    var weight: Int {
        return _weight
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int, height: Int, weight: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._height = height
        self._weight = weight
    }
}
