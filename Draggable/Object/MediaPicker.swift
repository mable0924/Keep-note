//
//  MediaPicker.swift
//  Draggable
//
//  Created by Po hin Ma on 24/4/2023.
//

import SwiftUI
import PhotosUI

struct MediaPicker: UIViewControllerRepresentable {
    @Binding var mediaItems: [DraggbleObject]
    @Environment(\.presentationMode) private var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images, .videos])
        configuration.selectionLimit = 0
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: MediaPicker

        init(_ parent: MediaPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            let itemProviders = results.map(\.itemProvider)
            for itemProvider in itemProviders {
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent.mediaItems.append(DraggbleObject(image: convertImageToBase64String(image: image), videoURL: nil, text: nil, width: image.size.width * 0.3, height: image.size.height * 0.3))
                            }
                        }
                    }
                } else if itemProvider.canLoadObject(ofClass: AVURLAsset.self) {
                    itemProvider.loadObject(ofClass: AVURLAsset.self) { [weak self] asset, error in
                        if let asset = asset as? AVURLAsset {
                            DispatchQueue.main.async {
                                print(asset.url)
                                self?.parent.mediaItems.append(DraggbleObject(image: nil,videoURL: convertURLToString(url: asset.url), text: nil, width: 200, height: 200))
                            }
                        }
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
