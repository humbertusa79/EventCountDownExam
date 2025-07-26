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
    
    var event: Event? {
        switch self {
        case .add:
            return nil
        case .edit(let event):
            return event
        }
    }
}

struct EventForm: View {
    let mode: Mode
    @Bindable var viewModel: EventsViewModel
    @State var date: Date
    @State var color: Color
    @Environment(\.dismiss) private var dismiss
    var onSave: ((Event) -> Void)?
    
    init(mode: Mode,
         viewModel: EventsViewModel,
         onSave: ((Event) -> Void)? = nil) {
        self.mode = mode
        self.viewModel = viewModel
        self.date = mode.event?.date ?? .now
        self.color = mode.event?.textColor ?? .black
        self.onSave = onSave
    }
    

    var body: some View {
        Form {
            Section {
                TextField("Event title",
                          text: $viewModel.inputText)
                if !viewModel.isValid {
                    Text("Field cannot be empty")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                DatePicker("Date",
                           selection: $date,
                           displayedComponents: [.date, .hourAndMinute])
                ColorPicker("Title color", selection: $color)
            }
        }
        .navigationTitle(navTitle)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let event = Event(id: UUID(),
                                      title: viewModel.inputText,
                                      date: date,
                                      textColor: color)
                    onSave?(event)
                    dismiss()
                }.disabled(!viewModel.isValid)
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
            return EventForm(
                
                mode: .edit(Event(id: UUID(),
                                  title: "Test",
                                  date: .now,
                                  textColor: .red)),
                viewModel: EventsViewModel(),
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
