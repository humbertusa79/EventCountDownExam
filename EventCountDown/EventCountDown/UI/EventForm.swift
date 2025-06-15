//
//  EventForm.swift
//  EventCountDown
//
//  Created by HumbertoPartida on 5/26/25.
//

import SwiftUI

enum Mode {
    case add
    case edit(Event)
}

struct EventForm: View {
    
    @State private var title: String
    @State private var date: Date
    @State private var color: Color
    let mode: Mode
    var onSave: ((Event) -> Void)?
    
    init(title: String,
         date: Date,
         color: Color,
         mode: Mode,
         onSave: ((Event) -> Void)? = nil) {
        self.title = title
        self.date = date
        self.color = color
        self.mode = mode
        self.onSave = onSave
    }
    

    var body: some View {
        Form {
            Section {
                TextField("Event title",
                          text: $title)
                DatePicker("Date",
                           selection: $date,
                           displayedComponents: [.date, .hourAndMinute])
                ColorPicker("Title color", selection: $color)
            }
        }.navigationTitle(navTitle)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let event = Event(id: UUID(),
                                          title: title,
                                          date: date,
                                          textColor: color)
                        onSave?(event)
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        
                    }
                }
            }
    }
    
    private var navTitle: String {
        switch mode {
        case .add:
            return "Add event"
        case .edit(let event):
            return "Edit \(event.title)"
        }
    }
}

struct EventForm_Preview: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var previewTitle = "Event Super Title"
        @State private var previewDate = Date.now
        @State private var previewColor = Color.red
        var body: some View {
            return EventForm(title: previewTitle,
                             date: previewDate,
                             color: previewColor,
                             mode: .add,
                             onSave: nil)
        }
    }
    static var previews: some View {
        PreviewWrapper()
    }
}

#Preview {
    EventForm_Preview.PreviewWrapper()
}
