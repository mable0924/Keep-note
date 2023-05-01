//
//  MediaItem.swift
//  Draggable
//
//  Created by Po hin Ma on 24/4/2023.
//

import SwiftUI
import AVKit

struct MediaItem: Identifiable {
    let id = UUID()
    let image: UIImage?
    let videoURL: URL?
    var position: CGSize
    
    init(image: UIImage? = nil, videoURL: URL? = nil) {
        self.image = image
        self.videoURL = videoURL
        self.position = CGSize.zero
    }
}
