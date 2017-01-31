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
    fileprivate var _height: Double!
    fileprivate var _weight: Double!
    fileprivate var _max_cp: Int!
    fileprivate var _attack: Int!
    fileprivate var _defense: Int!
    fileprivate var _stamina: Int!
    fileprivate var _evolution: Int!
    fileprivate var _type0: Int!
    fileprivate var _type1: Int!
    fileprivate var _quickMoves: Array<Move>!
    fileprivate var _chargeMoves: Array<Move>!
    
    
    var name: String {
        return _name
    }
    
    var height: Double {
        return _height
    }
    
    var weight: Double {
        return _weight
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var max_cp: Int {
        return _max_cp
    }
    
    var attack: Int {
        return _attack
    }
    
    var defense: Int {
        return _defense
    }
    
    var stamina: Int {
        return _stamina
    }
    
    var evolution: Int {
        return _evolution
    }
    
    var type0: Int {
        return _type0
    }
    
    var type1: Int {
        return _type1
    }
    
    var quickMoves: Array<Move> {
        return _quickMoves
    }
    
    var chargeMoves: Array<Move> {
        return _chargeMoves
    }
    
    
    init(name: String, pokedexId: Int, height: Double, weight: Double, max_cp: Int, attack: Int, defense: Int, stamina: Int, evolution: Int, type0: Int, type1: Int, quickMoves: Array<Move>, chargeMoves: Array<Move>) {
        self._name = name
        self._pokedexId = pokedexId
        self._height = height
        self._weight = weight
        self._max_cp = max_cp
        self._attack = attack
        self._defense = defense
        self._stamina = stamina
        self._evolution = evolution
        self._type0 = type0
        self._type1 = type1
        self._quickMoves = quickMoves
        self._chargeMoves = chargeMoves
    }
}
