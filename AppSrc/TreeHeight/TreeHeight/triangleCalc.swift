//
//  triangleCalc.swift
//  TreeHeight
//
//  Created by Jan Vogt on 05.12.22.
//

import Foundation
class triangleCalc {
    func calcHeight (distance: Double, angle: Double) -> Double {
        print(angle)
        return distance * tan(angle)
    }
}
