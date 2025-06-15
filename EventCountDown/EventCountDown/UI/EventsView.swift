//
//  EventsView.swift
//  EventCountDown
//
//  Created by HumbertoPartida on 5/26/25.
//

import SwiftUI

struct EventsView: View {
    @Environment(EventsViewModel.self) private var viewModel
    var body: some View {
        VStack {
            Text("Events List")
            List(viewModel.events, id: \.self) { event in
                EventRow(event: event)
            }
        }
    }
}

#Preview {
    let events = [Event(id: UUID(),
                        title: "EVENT 1",
                        date: Date().addingTimeInterval(-45),
                        textColor: .black),
                  Event(id: UUID(),
                        title: "Event2",
                        date: Date().addingTimeInterval(-3600),
                        textColor: .green)]
    EventsView().environment(EventsViewModel(events: events))
}
