//
//  MediaItem.swift
//  Draggable
//
//  Created by Po hin Ma on 24/4/2023.
//
//
//import SwiftUI
//import AVKit
//
//protocol Draggable {
//    var position: CGSize { get set }
//}
//
//struct MediaItem: Identifiable, Draggable {
//    let id = UUID()
//    let image: UIImage?
//    let videoURL: URL?
//    var position: CGSize
//
//    init(image: UIImage? = nil, videoURL: URL? = nil) {
//        self.image = image
//        self.videoURL = videoURL
//        self.position = CGSize.zero
//    }
//}
//
//struct TextItem: Identifiable, Draggable {
//    var id = UUID()
//    var text: String
//    var position: CGSize
//}
//
//enum DraggableItem: Draggable {
//    case mediaItem(MediaItem)
//    case textItem(TextItem)
//
//    var position: CGSize {
//        get {
//            switch self {
//            case .mediaItem(let mediaItem):
//                return mediaItem.position
//            case .textItem(let textItem):
//                return textItem.position
//            }
//        }
//        set {
//            switch self {
//            case .mediaItem(var mediaItem):
//                mediaItem.position = newValue
//                self = .mediaItem(mediaItem)
//            case .textItem(var textItem):
//                textItem.position = newValue
//                self = .textItem(textItem)
//            }
//        }
//    }
//}
