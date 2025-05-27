//
//  EventRepository.swift
//  EventCountDown
//
//  Created by HumbertoPartida on 5/26/25.
//

import Foundation

protocol EventManagable {
    func fetchAllEvents() -> LinkedList<Event>
    func fetchEvent(id: UUID) -> Event?
    func addEvent(event: Event)
    func remove(event: Event)
}
