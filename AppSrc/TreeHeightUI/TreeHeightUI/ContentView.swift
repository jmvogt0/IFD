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
                TimelineView(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=TimelineSchedule@*/EveryMinuteTimelineSchedule()/*@END_MENU_TOKEN@*/) { context in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
                }
                    .foregroundColor(Color.green)
                Image(systemName: "plus")
                Text("bra")
                Text("test")
                Text("Test")
                    .multilineTextAlignment(.trailing)
                Text("bra")
                    .multilineTextAlignment(.leading)
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button("action1", action: {})
                                .padding(.bottom, 200.0)
                                .background(Color.green)
                        }
                        
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
