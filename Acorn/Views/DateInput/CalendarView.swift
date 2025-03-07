//
// CalendarView.swift
// Acorn
//
// Created by flngsquirrl on 05/03/2025.

import SwiftUI

struct CalendarView: View {
    @Binding var date: Date

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            DatePicker("Pick a date", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Close")
                        .bold()
                        .padding(8)
                        .padding(.horizontal)
                        .foregroundStyle(Color.primary)
                        .border(Color.primary, width: 2)
                }

                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Apply")
                        .bold()
                        .padding(8)
                        .padding(.horizontal)
                        .foregroundStyle(Color.primary)
                        .border(Color.primary, width: 2)
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    CalendarView(date: .constant(.now))
        .border(.red, width: 2)
}
