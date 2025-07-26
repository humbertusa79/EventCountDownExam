//
//  EventsViewModel.swift
//  EventCountDown
//
//  Created by HumbertoPartida on 5/26/25.
//

import Combine
import Foundation
import SwiftUI

@Observable
final class EventsViewModel {
    private var events: [Event]
    
    private var currentDate = Date.now
    private var cancellables: [AnyCancellable] = []
    var inputText: String = ""
    var isValid: Bool  {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        return !text.isEmpty
    }
    
    init(events: [Event] = [], currentDate: Foundation.Date = Date.now) {
        self.events = events
        self.currentDate = currentDate
    }
    
    var eventList: [Event] {
        return events
    }
    
    func save(newEvent: Event) {
        events.append(newEvent)
    }
    
    func edit(newEvent: Event) {
        let event = events.first {
            $0.id == newEvent.id
        }
        guard var event else {
            save(newEvent: newEvent)
            return
        }
        event.title = newEvent.title
        event.date = newEvent.date
        event.textColor = newEvent.textColor
    }
    
    private func startTimer() {
        Timer.publish(every: 60,
                      on: .main,
                      in: .common)
        .autoconnect()
        .sink { [weak self] now in
            self?.currentDate = now
        }.store(in: &cancellables)
    }
    
    func convertRelative(date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: currentDate)
    }

    func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}
