//
//  Page.swift
//  Draggable
//
//  Created by Po hin Ma on 24/4/2023.
//

import Foundation

struct Page: Identifiable {
    let id = UUID()
    var draggableItems: [DraggbleObject] = []
    
    mutating func remove(at index: Int) {
        draggableItems.remove(at: index)
    }
}


