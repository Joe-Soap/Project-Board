//
//  CircuitKit.swift
//  Project Board
//
//  Created by Joe Soap on 2017/08/05.
//  Copyright © 2017 SinBros. All rights reserved.
//

import Foundation

protocol Component : class {
    
    weak var inputTerminal : Component? { get set }
    weak var outputTerminal : Component? { get set }
    var componentType : ComponentType { get }
}


protocol ActiveComponent : class {
    var output : EnergyMetric { get set }
}

protocol PassiveComponent : class {
    var energyDelta : EnergyMetric { get set 	}
}

struct EnergyMetric {
    var voltage : Double?
    var resistance : Double?
    var current : Double?
}

enum ComponentType {
    case passive
    case active
    case electromechanical
}




class GenericPassiveComponent : Component, PassiveComponent   {
    
    weak var inputTerminal: Component?
    weak var outputTerminal: Component?
    var componentType: ComponentType {
        get {
            return .passive
        }
    }
    
    var energyDelta: EnergyMetric
    
    init(with energyMetric:EnergyMetric) {
        energyDelta = energyMetric
    }
    
    func connectOutput(to: Component) {
        outputTerminal = to
    }
    
    
}
