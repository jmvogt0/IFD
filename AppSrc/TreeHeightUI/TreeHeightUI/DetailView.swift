//
//  DetailView.swift
//  TreeHeightUI
//
//  Created by Jan Vogt on 25.11.22.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                    .frame(height: 50.0)
                    HStack(){
                        Image("TreeIcon")
                    }
                Spacer()
                    .frame(height: 100.0)
							NavigationLink(destination: ContentView()) {
								Image(systemName: "plus")
							}.buttonStyle(PlainButtonStyle())
                

            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
