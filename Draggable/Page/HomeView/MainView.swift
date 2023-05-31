//
//  MainView.swift
//  Draggable
//
//  Created by Po hin Ma on 24/4/2023.
//

import SwiftUI


struct MainView: View {
    @State private var pages: [Page] = []
    @State private var selection: String? = "All Scenes"
    @State private var viewModels: [DraggablePageViewModel] = []
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    
    var columns: [GridItem] {
        let columnCount = isPad() ? 4 : 2
        return Array(repeating: .init(.flexible(), spacing: 10), count: columnCount)
    }
    
    let titles = ["All Scenes"]
    
    var body: some View {
        NavigationSplitView {
            List(titles, id: \.self, selection: $selection) { title in
                HStack(){
                    Text(title)
                    Spacer()
                    Text("\(pages.count)")
                }
            }
            .onAppear{
                self.pages = load()
                self.viewModels = self.pages.map { DraggablePageViewModel(page: $0) }
            }
            .onDisappear{
                self.pages = []
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("DidFinishLaunching"))) { _ in
                self.pages = load()
                self.viewModels = self.pages.map { DraggablePageViewModel(page: $0) }
            }
            .navigationTitle("Keep Note")
        } detail: {
            if selection != nil {
                NavigationStack{
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(pages.indices, id: \.self) { index in
                                SelectView(viewModel: viewModels[index], columnsCount: columns.count, index: index)
                            }
                        }
                        .padding(.all)
                    }

                    .navigationTitle("Scenes")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                let dateString = formatter.string(from: Date())
                                var page = Page(dateString)
                                pages.append(page)
                                viewModels.append(DraggablePageViewModel(page: page))
                                save(pages: pages)
                            }) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    }
                }
            } else {
                Text("Please select an item")
            }
        }
    }
}


func isPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}
