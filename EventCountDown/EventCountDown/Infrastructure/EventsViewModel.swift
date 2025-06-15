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
    var events: [Event]
    
    private var currentDate = Date.now
    private var cancellables: [AnyCancellable] = []
    
    init(events: [Event] = [], currentDate: Foundation.Date = Date.now) {
        self.events = events
        self.currentDate = currentDate
        
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
}
