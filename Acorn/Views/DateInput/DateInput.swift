//
// DateInput.swift
// Acorn
//
// Created by flngsquirrl on 04/03/2025.

import SwiftUI
import VisionKit

struct DateInput: View {
    @Binding var date: Date

    @State private var showCalendar = false

    var body: some View {
        HStack(spacing: 0) {
            dateField

            if scannerAvailable {
                scannerButton
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .sheet(isPresented: $showCalendar) {
            CalendarView(date: $date)
                .presentationDetents(.init(arrayLiteral: .fraction(0.6)))
        }
    }

    var formattedDate: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }

    var scannerAvailable: Bool {
        true
//        DataScannerViewController.isSupported &&
//            DataScannerViewController.isAvailable
    }
}

extension DateInput {
    var dateField: some View {
        HStack {
            Text("Good until")
            Spacer()
            selectedDate
        }
        .padding(8)
        .background(.background.secondary)
        .fixedSize(horizontal: false, vertical: true)
        .border(.secondary)
        .frame(maxHeight: .infinity)
    }

    var selectedDate: some View {
        Text(formattedDate)
            .padding(4)
            .padding(.horizontal, 8)
            .background(.background.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                showCalendar.toggle()
            }
    }

    var scannerButton: some View {
        Button {} label: {
            Image(systemName: "camera.fill")
                .font(.title2)
                .padding(.horizontal)
                .frame(maxHeight: .infinity)
                .background(Color.primary)
                .foregroundStyle(Color.background)
        }
        .padding(.leading, 10)
    }
}

#Preview {
    NavigationStack {
        DateInput(date: .constant(.now))
            .padding()
            .frame(height: 300)
            .background(.background.secondary)
    }
}
