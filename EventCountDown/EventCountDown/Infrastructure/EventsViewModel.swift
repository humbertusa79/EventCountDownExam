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
    private var cancellable: AnyCancellable?
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
        startTimer()
    }
    
    func edit(newEvent: Event) {
        let event = events.first {
            $0.id == newEvent.id
        }
        guard let event else {
            save(newEvent: newEvent)
            return
        }
        guard let index = events.firstIndex(of: event) else {
            return
        }
        
        events.remove(at: index)
        events.insert(newEvent, at: index)
        startTimer()
        
        
    }
    
    private func startTimer() {
        guard events.isEmpty == false else { return }
        guard cancellable == nil else { return }
        cancellable = Timer.publish(every: 1,
                                    on: .main,
                                    in: .common)
        .autoconnect()
        .sink { [weak self] now in
            self?.currentDate = now
        }
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
