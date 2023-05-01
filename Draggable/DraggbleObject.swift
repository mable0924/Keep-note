//
//  DraggbleObject.swift
//  Draggable
//
//  Created by Po hin Ma on 26/5/2023.
//
import SwiftUI

struct DraggbleObject: Identifiable {
    let id = UUID()
    let image: UIImage?
    let videoURL: URL?
    var position: CGSize = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2)
    var text: String?
    var scale: CGFloat = 1.0
    var width: CGFloat
    var height: CGFloat
    
    
    init(image: UIImage?, videoURL: URL?, text: String?, width: CGFloat, height: CGFloat) {
        self.image = image
        self.videoURL = videoURL
        self.text = text
        self.width = width
        self.height = height
    }
}
