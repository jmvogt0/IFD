//
//  MeasureView.swift
//  TreeHeightUI
//
//  Created by Jan Vogt on 25.11.22.
//

import SwiftUI

struct MeasureView: View {
	@State var count:Int = 1
	@State private var action: Int? = 0
    var body: some View {
			NavigationView {
				VStack{
					NavigationLink(destination: DetailView(), tag: 1, selection: $action) {}
	
					Image("baumBild")
					Spacer()
					Text("Schritt \(count) / 3")
						Button(action: {
							if(self.count < 3){
								self.count += 1
							}
							else {
								self.action = 1
							}
						}) {
							Image(systemName: "plus")
						}
				}
			}
			.navigationBarBackButtonHidden(true)
    }
}

struct MeasureView_Previews: PreviewProvider {
    static var previews: some View {
        MeasureView()
    }
}
