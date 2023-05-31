//
//  DraggablePageViewModel.swift
//  Draggable
//
//  Created by Po hin Ma on 29/5/2023.
//

import Foundation
import AVFoundation
import Combine

class DraggablePageViewModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published var draggableItems: [DraggbleObject] = []
    @Published var isPresented: Bool = false
    @Published var player: AVPlayer?
    @Published var showingMediaPicker = false
    @Published var showingTextEntry = false
    @Published var showingActionSheet = false
    @Published var scale: CGFloat = 1.0
    @Published var originalScale: CGFloat = 1.0
    @Published var viewScale: CGFloat = 1.0
    @Published var size: CGFloat = 1.0
    @Published var page: Page
    @Published var oldEditTime: String
    @Published var check: Bool = true
    
    var cancellable: AnyCancellable?
    
    init(page: Page) {
        self.page = page
        oldEditTime = page.editTime
        cancellable = $page.sink(receiveValue: { [weak self] page in
            self?.savePage(page)
        })
        
    }
    // page舊時間 == 舊時間 X做
    // 每次退出 變舊page + 舊時間
    // 正常： 新時間 ！＝ 舊時間
    // 做第一次 佢有新時間 之後舊時間就無用
    func savePage(_ page: Page) {
        var pages = load()
        if let index = pages.firstIndex(where: {$0.id == page.id}) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: Date())
            pages[index] = page
            pages[index].editTime = dateString
            save(pages: pages)
//
//            if pages[index].editTime == page.editTime {
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                let dateString = formatter.string(from: Date())
//                pages[index] = page
//                pages[index].editTime = dateString
//                save(pages: pages)
//                check = false
//                print("check to false")
//            }
//            print(check)
//            print(pages[index].editTime)
//            print(page.editTime)
//            if pages[index].editTime != page.editTime && !check{
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                let dateString = formatter.string(from: Date())
//                pages[index] = page
//                print(dateString)
//                print()
//                pages[index].editTime = dateString
//                save(pages: pages)
//            }
//            if check {
//                check = !check
//            }
        }
    }

        
    func loadPage() {
        guard let data = UserDefaults.standard.data(forKey: "page") else { return }
        do {
            let page = try JSONDecoder().decode(Page.self, from: data)
            self.page = page
        } catch {
            print("Failed to load page: \(error)")
        }
    }
}
