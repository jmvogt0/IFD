//
//  ContentView.swift
//  TreeHeightUI
//
//  Created by Jan Vogt on 23.11.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: DetailView()) {
                    Text("PressMe")
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
								NavigationLink(destination: MeasureView()) {
								Image(systemName: "plus")
							}
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
