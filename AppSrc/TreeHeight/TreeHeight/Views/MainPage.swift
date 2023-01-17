//
//  ContentView.swift
//  TreeHeightUI
// 
//  Created by Jan Vogt on 23.11.22.
//

import SwiftUI

struct MainPage: View {
    //@EnvironmentObject var cubeSettings: CubeSettings
    @StateObject var cubeSettings = CubeSettings()
    
    var body: some View {
        NavigationView {
            VStack{
                HStack(alignment: .top){
                    Text("TreeHeight")
                        .font(.title)
                    Image("TreeHeightIcon")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                }
                Spacer()
                NavigationLink(destination: LastTreeHeightView()) {
                    //ScrollView(.horizontal, showsIndicators: false) {
                    HStack(){
                        ZStack(){
                            Color(UIColor.init(named: "TreeIconBackgroundColor") ?? .black)
                            VStack(){
                                HStack(spacing: 0){
                                    Text("Letzte Messung:")
                                    Spacer()
                                }
                                .padding(.leading, 20)
                                .padding(.top, 20)
                                HStack(spacing: 0){
                                    Text(cubeSettings.date)
                                    Spacer()
                                    Text("\(String(format: "%.2f", cubeSettings.height))m")
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                Image("ExperimentalTree")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(10)
                                Text("Fichte")
                                    .font(.title)
                                    .padding(10)
                                //.foregroundColor(.whit)
                            }
                        }
                        .frame(height: 400.0)
                        .cornerRadius(5)
                        .padding(10)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                //}
                Spacer()
                    .frame(height: 100.0)
                NavigationLink(destination: ContentView().environmentObject(cubeSettings)) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                        .foregroundColor(Color(UIColor.init(named: "ButtonSymbolColor") ?? .black))
                    }
                    .buttonStyle(.bordered)
                Spacer()
            }.environmentObject(cubeSettings)
        }.navigationBarBackButtonHidden(true)
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
