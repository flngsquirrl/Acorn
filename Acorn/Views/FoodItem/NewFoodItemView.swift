//
// NewFoodItemView.swift
// Acorn
//
// Created by flngsquirrl on 01/03/2025.

import SwiftUI
import VisionKit

struct NewFoodItemView: View {
    @Environment(\.dismiss) var dismiss

    @State private var scannedDate: Date?
    @State private var showDateScanner = false

    @State var itemName: String = ""
    @State var goodUntil: Date = .now

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Item name", text: $itemName)
                    .padding(12)
                    .background(.background.secondary)
                    .border(.secondary)

                DateInput(date: $goodUntil)

                Spacer()

                saveButton
                cancelButton
            }
            .navigationTitle("New item")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .sheet(isPresented: $showDateScanner) {
                ScannerView(scannedDate: $scannedDate)
            }
            .onChange(of: scannedDate) { _, newValue in
                if let newValue {
                    goodUntil = newValue
                }
            }
            .background(.background.secondary)
        }
    }

    var formattedDate: String? {
        scannedDate?.formatted(date: .numeric, time: .omitted) ?? nil
    }

    var scannerAvailable: Bool {
        DataScannerViewController.isSupported &&
            DataScannerViewController.isAvailable
    }
}

extension NewFoodItemView {
    var saveButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Save")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.primary)
    }

    var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .buttonStyle(.secondary)
    }
}

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedDate: Date?

    @MainActor
    class Coordinator: DataScannerViewControllerDelegate {
        @Binding var scannedDate: Date?
        var controller: DataScannerViewController?

        init(scannedDate: Binding<Date?>) {
            _scannedDate = scannedDate
        }

        func dataScanner(_: DataScannerViewController, didTapOn item: RecognizedItem) {
            if case let .text(text) = item {
                processScanned(text: text.transcript)
            }

            controller?.stopScanning()
            controller?.dismiss(animated: true)
        }

        func processScanned(text: String) {
            let dates = Date.detect(from: text)
            if !dates.isEmpty {
                scannedDate = dates[0]
            }
        }

        func startScanning() throws {
            try controller?.startScanning()
        }

        func dataScanner(_: DataScannerViewController,
                         becameUnavailableWithError _: DataScannerViewController.ScanningUnavailable) {
            print("----- DataScanner is unavailable -----")
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(scannedDate: $scannedDate)
    }

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.text(textContentType: .dateTimeDuration)],
            qualityLevel: .balanced,
            recognizesMultipleItems: true,
            isHighlightingEnabled: true
        )
        context.coordinator.controller = controller
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_: DataScannerViewController, context: Context) {
        try? context.coordinator.startScanning()
    }
}

extension Date {
    static func detect(from text: String) -> [Date] {
        let types: NSTextCheckingResult.CheckingType = [.date]
        var results: [Date] = []
        if let detector = try? NSDataDetector(types: types.rawValue) {
            let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
            for match in matches {
                if let date = match.date {
                    results.append(date)
                    print("Extracted Date: \(date.formatted(date: .numeric, time: .omitted))")
                }
            }
        }
        return results
    }
}

#Preview {
    NewFoodItemView()
}
