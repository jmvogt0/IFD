//
//  Calc.swift
//  TreeHeight
//
//  Created by Jan Vogt on 09.12.22.
//

import Foundation

struct Calc {
    class Triangle {
        func calcHeight (distance: Double, angle: Double) -> Double {
            print(angle)
            return distance * tan(angle)
        }
    }
}

