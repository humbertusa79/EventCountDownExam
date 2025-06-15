//
//  ContentView.swift
//  EventCountDown
//
//  Created by HumbertoPartida on 5/26/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack {
            EventsView()
        }
        .navigationTitle("Events form")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    path.append("add")
                }) {
                    Image(systemName: "plus")
                }
            }
        }.navigationDestination(for: String.self) { value in
            if value == "add" {
                EventForm()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
