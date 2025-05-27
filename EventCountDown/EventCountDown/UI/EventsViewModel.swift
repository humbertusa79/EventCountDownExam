//
//  EventsViewModel.swift
//  EventCountDown
//
//  Created by HumbertoPartida on 5/26/25.
//

import Foundation
import SwiftUI

final class EventsRepository: EventManagable {
    private var events: LinkedList<Event> = LinkedList()
    func fetchAllEvents() -> LinkedList<Event> {
        return events
    }
    
    func fetchEvent(id: UUID) -> Event? {
        guard let node = events.nodeAt(id: id)?.value else { return nil }
        return node
    }
    
    func addEvent(event: Event) {
        events.enqueue(value: event)
    }
    
    func remove(event: Event) {
        events.deleteNodeAt(id: event.id)
    }
}


final class EventsViewModel: ObservableObject {
    private let repository: EventsRepository
    @Published var events: LinkedList<Event>?
    
    init(repository: EventsRepository) {
        self.repository = repository
        loadEvents()
    }
    
    func loadEvents() {
        events = repository.fetchAllEvents()
    }
}
