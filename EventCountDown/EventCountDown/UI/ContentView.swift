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
        VStack {
            EventsView()
        }
    }
}

#Preview {
    ContentView()
}
