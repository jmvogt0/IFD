//
//  DetailView.swift
//  TreeHeightUI
//
//  Created by Jan Vogt on 25.11.22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                    .frame(height: 50.0)
                    HStack(){
                        VStack(){
                            ZStack(){
                                Color(UIColor.init(named: "TreeIconBackgroundColor") ?? .black)
                                VStack(){
                                    Text("\(String(format: "%.2f", UserDefaults.standard.double(forKey: "LastTreeHeight")))m")
                                        .padding(10)
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
                        }
                    }
                Spacer()
                    .frame(height: 100.0)
                Button(
                    action: { self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "arrow.forward")
                        //.imageScale(.large)
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                        .foregroundColor(Color(UIColor.init(named: "ButtonSymbolColor") ?? .black))
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
