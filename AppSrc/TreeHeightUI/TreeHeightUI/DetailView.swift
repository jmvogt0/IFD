//
//  DetailView.swift
//  TreeHeightUI
//
//  Created by Jan Vogt on 25.11.22.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var cubeSettings: CubeSettings
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                    .frame(height: 50.0)
                    HStack(){
                        VStack(){
                            Image("TreeIcon")
                            Text("Height: \(cubeSettings.height)")
                        }
                    }
                Spacer()
                    .frame(height: 100.0)
                NavigationLink(destination: MainPage()) {
								Image(systemName: "plus")
							}.buttonStyle(PlainButtonStyle())
                

            }
        }
        .environmentObject(cubeSettings)
        .navigationBarBackButtonHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
