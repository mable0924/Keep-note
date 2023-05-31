//
//  Page.swift
//  Draggable
//
//  Created by Po hin Ma on 24/4/2023.
//

import Foundation

struct Page: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String = "Scene"
    var draggableItems: [DraggbleObject] = []
    var editTime: String = ""
    
    init(_ editTime: String) {
        self.editTime = editTime
    }
    
    mutating func remove(at index: Int) {
        draggableItems.remove(at: index)
    }
    
    static func ==(lhs: Page, rhs: Page) -> Bool {
        return lhs.id == rhs.id
    }
}

// save page
func save(pages: [Page]) {
    do {
        let data = try JSONEncoder().encode(pages)
        UserDefaults.standard.set(data, forKey: "pages")
        print("Save Scene")
    } catch {
        print("Failed to save pages: \(error)")
    }
}

// load page
func load() -> [Page] {
    guard let data = UserDefaults.standard.data(forKey: "pages") else { return [] }
    do {
        let pages = try JSONDecoder().decode([Page].self, from: data)
        return pages
    } catch {
        print("Failed to load pages: \(error)")
        return []
    }
}

func deleteOldData() {
    UserDefaults.standard.removeObject(forKey: "pages")
}
