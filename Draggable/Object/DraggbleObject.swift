//
//  DraggbleObject.swift
//  Draggable
//
//  Created by Po hin Ma on 26/5/2023.
//
import SwiftUI

struct DraggbleObject: Identifiable, Codable {
    let id = UUID()
    let image: String?
    let videoURL: String?
    var position: CGSize = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2)
    var text: String?
    var scale: CGFloat = 1.0
    var width: CGFloat
    var height: CGFloat
    
    
    init(image: String?, videoURL: String?, text: String?, width: CGFloat, height: CGFloat) {
        self.image = image
        self.videoURL = videoURL
        self.text = text
        self.width = width
        self.height = height
    }
}

// convert UIImage to Base64 String
func convertImageToBase64String(image: UIImage) -> String? {
    return image.jpegData(compressionQuality: 1.0)?.base64EncodedString()
}

func convertBase64StringToImage(base64String: String) -> UIImage? {
    if let data = Data(base64Encoded: base64String) {
        return UIImage(data: data)
    }
    return nil
}

// convert URL to String
func convertURLToString(url: URL) -> String {
    return url.absoluteString
}

func convertStringToURL(string: String) -> URL? {
    return URL(string: string)
}
