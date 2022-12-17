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
        NavigationView {
            VStack{
                Spacer()
                    .frame(height: 50.0)
                HStack(){
                    VStack(){
                        Image("TreeIcon")
                        Text("Height: \(UserDefaults.standard.double(forKey: "LastTreeHeight")) m")
                    }
                }
            }
        }
    }
}
