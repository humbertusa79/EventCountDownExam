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
        NavigationStack {
            List(viewModel.eventList, id: \.self) { event in
                NavigationLink(value: event) {
                    EventRow(event: event)
                }
            }
            .navigationTitle("Events List")
            .navigationDestination(for: Event.self) { event in
                EventForm(mode: .edit(event)) { event in
                    viewModel.edit(newEvent: event)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: EventForm(mode: .add) { event in
                        viewModel.save(newEvent: event)
                    }) {
                        Image(systemName: "plus")
                    }
                }
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
