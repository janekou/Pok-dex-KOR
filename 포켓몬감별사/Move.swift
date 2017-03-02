//
//  Move.swift
//  포켓몬도감
//
//  Created by Jane on 30/01/2017.
//  Copyright © 2017 Jane. All rights reserved.
//

import Foundation

class Move {
    fileprivate var _power: Int!
    fileprivate var _cooldown: Double!
    fileprivate var _dps: Double!
    fileprivate var _moveName: String!
    fileprivate var _moveType: Int!
    fileprivate var _moveForm: Bool!
    
    var power: String {
        return String(_power)
    }
    var coolDown: String {
        return String(format: "%.1f", _cooldown/1000)
    }
    var dps: String {
//        return String(format: "%.1f", Double(_power)/(_cooldown/1000))
        return String(format: "%.1f", _dps/100)
    }
    var moveName: String {
        return _moveName
    }
    var moveType: Int {
        return _moveType
    }
    var moveForm: Bool {
        return _moveForm
    }
    init(power: Int, cooldown: Double, dps: Double, moveName: String, moveType: Int, moveForm: Bool) {
        self._power = power
        self._cooldown = cooldown
        self._dps = dps
        self._moveName = moveName
        self._moveType = moveType
        self._moveForm = moveForm
    }
}
