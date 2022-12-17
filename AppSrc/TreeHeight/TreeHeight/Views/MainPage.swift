//
//  ContentView.swift
//  TreeHeightUI
//
//  Created by Jan Vogt on 23.11.22.
//

import SwiftUI

struct MainPage: View {
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: DetailView()) {
                    Text("Last Tree")
                }
                Spacer()
                    .frame(height: 50.0)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(){
                        Image("TreeIcon")
                        Image("TreeIcon")
                        Image("TreeIcon")
                        Image("TreeIcon")
                        Image("TreeIcon")
                    }
                }
                Spacer()
                    .frame(height: 100.0)
								NavigationLink(destination: ContentView()) {
								Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 32.0, height: 32.0)
                                        .foregroundColor(Color(UIColor.init(named: "ButtonSymbolColor") ?? .black))
							}
                                .buttonStyle(.bordered)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
