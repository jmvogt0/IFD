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
    class SaveDate {
        func formatDate (date :Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "de_DE")

            return dateFormatter.string(from: date)
        }
    }
    class TreeFunctions {
        func getAge (height: Double) -> String {
            var age = "0"
            
            if (height < 8){
                age = "jünger als 20 Jahre"
            }
            if (height > 8 && height < 15){
                age = "jünger als 60 Jahre"
            }
            if (height > 8 && height < 25){
                age = "jünger als 100 Jahre"
            }
            if (height > 8 && height < 30){
                age = "circa 140 Jahre"
            }
            if (height > 30){
                age = "circa 180 Jahre"
            }
            
            
            return age
        }
        func getCo2 (height: Double) -> String {
            var co2 = "0"
            
            if (height < 8){
                co2 = "weniger als 200kg CO2"
            }
            if (height > 8 && height < 15){
                co2 = "weniger als 200kg CO2"
            }
            if (height > 15 && height < 25){
                co2 = "circa 200-400kg CO2"
            }
            if (height > 25 && height < 30){
                co2 = "circa 1200-1800kg CO2"
            }
            if (height > 30){
                co2 = "circa 3.5 - 5 Tonnen CO2"
            }
            return co2
        }
    }
}

