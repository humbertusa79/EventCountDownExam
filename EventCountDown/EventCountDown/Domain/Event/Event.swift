//
//  Event.swift
//  EventCountDown
//
//  Created by HumbertoPartida on 5/26/25.
//

import Foundation
import SwiftUICore

struct Event: Hashable, Comparable, Identifiable {
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
    
    var id: UUID
    var title: String
    var date: Date
    var textColor: Color
    
    init(id: UUID, title: String, date: Date, textColor: Color) {
        self.id = id
        self.title = title
        self.date = date
        self.textColor = textColor
    }
}
