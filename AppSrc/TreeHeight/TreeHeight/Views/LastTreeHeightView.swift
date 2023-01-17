//
//  LastTreeHeightView.swift
//  TreeHeight
//
//  Created by Jan Vogt on 18.12.22.
//

import SwiftUI

struct LastTreeHeightView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let treeFunctions = Calc.TreeFunctions()
        NavigationView {
            VStack{
                Spacer()
                    .frame(height: 50.0)
                HStack(){
                    VStack(){
                        ZStack(){
                            Color(UIColor.init(named: "TreeIconBackgroundColor") ?? .black)
                            VStack(){
                                HStack(spacing: 0){
                                    Text(UserDefaults.standard.string(forKey: "LastTreeHeightDate") ?? "")
                                    Spacer()
                                    Text("\(String(format: "%.2f", UserDefaults.standard.double(forKey: "LastTreeHeight")))m")
                                }
                                .padding(.top, 20)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                Image("ExperimentalTree")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(10)
                                Text("Fichte")
                                    .font(.title)
                                    .padding(10)
                            }
                        }
                        .frame(height: 400.0)
                        .cornerRadius(5)
                        .padding(10)
                        ZStack(){
                            Color(UIColor.init(named: "TreeIconBackgroundColor") ?? .black)
                            Text("Ungefähres Alter: \(treeFunctions.getAge(height: UserDefaults.standard.double(forKey: "LastTreeHeight")))")
                        }
                        .frame(height: 60.0)
                        .cornerRadius(5)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        
                        ZStack(){
                            Color(UIColor.init(named: "TreeIconBackgroundColor") ?? .black)
                            Text("Gespeichertes CO2: \(treeFunctions.getCo2(height: UserDefaults.standard.double(forKey: "LastTreeHeight")))")
                        }
                        .frame(height: 60.0)
                        .cornerRadius(5)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    }
                }
            }
        }
    }
}
