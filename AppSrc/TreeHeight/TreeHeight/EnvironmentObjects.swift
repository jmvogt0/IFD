//
//  EnvironmentObjects.swift
//  TreeHeight
//
//  Created by Jan Vogt on 16.12.22.
//

import Foundation

class CubeSettings: ObservableObject {
    @Published var distance = 0.00
    @Published var height :Double = UserDefaults.standard.double(forKey: "LastTreeHeight")
    @Published var date = UserDefaults.standard.string(forKey: "LastTreeHeightDate") ?? ""
}
