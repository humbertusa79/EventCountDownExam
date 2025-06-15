//
//  EventCountDownApp.swift
//  EventCountDown
//
//  Created by HumbertoPartida on 5/26/25.
//

import SwiftUI

@main
struct EventCountDownApp: App {
    @State private var viewModel = EventsViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(viewModel)
        }
    }
}
