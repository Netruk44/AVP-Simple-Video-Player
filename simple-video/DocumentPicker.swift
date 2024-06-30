//
//  DocumentPicker.swift
//  simple-video
//
//  Created by Daniel Perry on 6/30/24.
//

import SwiftUI
import UIKit
import AVKit

struct DocumentPicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            parent.onFilePicked(url)
        }
    }

    var onFilePicked: (URL) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.movie])
        documentPicker.delegate = context.coordinator
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
}
