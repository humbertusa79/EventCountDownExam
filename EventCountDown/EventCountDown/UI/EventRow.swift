//
//  EventRow.swift
//  EventCountDown
//
//  Created by HumbertoPartida on 5/26/25.
//

import SwiftUI

struct EventRow: View {
    private var event: Event
    @Environment(EventsViewModel.self) var viewModel: EventsViewModel
    
    init(event: Event) {
        self.event = event
    }

    var body: some View {
        VStack {
            Text(event.title).font(.title2)
                .foregroundStyle(event.textColor)
            Text(viewModel.convertRelative(date: event.date))
        }
    }
}

#Preview {
    let event = Event(id: UUID(),
                      title: "E2 LA",
                      date: Date.now,
                      textColor: .blue)
    EventRow(event: event)
}
