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
    @State private var isPresented = false
    
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
            .navigationTitle("Keep Note")
        } detail: {
            if let selection {
                NavigationStack{
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(pages) { page in
                                VStack() {
                                    Image(systemName: "scribble.variable")
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width / CGFloat(columns.count) * 0.35, height: UIScreen.main.bounds.width / CGFloat(columns.count) * 0.35)
                                        .padding(EdgeInsets(top: 20, leading: 45, bottom: 20, trailing: 45))
                                    Text("Scene \(pages.firstIndex(where: { $0.id == page.id })! + 1)")
                                        .font(.footnote)
                                        .frame(width: UIScreen.main.bounds.width / CGFloat(columns.count) * 0.35 + 90, height: 50)
                                        .background(Color.black.opacity(0.1))
                                }
                                .background(.white)
                                .cornerRadius(10)
                                .compositingGroup()
                                .shadow(radius: 3, x: 0, y: 0)
                                .onTapGesture {
                                    isPresented.toggle()
                                }
                                .fullScreenCover(isPresented: $isPresented, content: {
                                    DraggablePage(page: $pages[pages.firstIndex(where: { $0.id == page.id })!])
                                })
                            }
                        }
                        .padding(.all)
                    }

                    .navigationTitle("Scenes")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                pages.append(Page())
                            }) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    }
                }
//                NavigationStack{
//                    ScrollView {
//                        LazyVGrid(columns: columns, spacing: 10) {
//                            ForEach(pages) { page in
//                                NavigationLink(destination: DraggablePage(page: $pages[pages.firstIndex(where: { $0.id == page.id })!])) {
//                                    VStack() {
//                                        Image(systemName: "scribble.variable")
//                                            .resizable()
//                                            .frame(width: 80, height: 80)
//                                            .padding(EdgeInsets(top: 20, leading: 45, bottom: 20, trailing: 45))
//                                        Text("Scene \(pages.firstIndex(where: { $0.id == page.id })! + 1)")
//                                            .font(.footnote)
//                                            .frame(width:200, height:50)
//                                            .background(Color.black.opacity(0.1))
//                                    }
//                                    .background(.white)
//                                    .cornerRadius(10)
//                                    .compositingGroup()
//                                    .shadow(radius: 3, x: 0, y: 0)
//                                }
//                            }
//                        }
//                        .padding(.all)
//                    }
//                    .navigationTitle("Scenes")
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button(action: {
//                                pages.append(Page())
//                            }) {
//                                Image(systemName: "square.and.pencil")
//                            }
//                        }
//                    }
//                }
            } else {
                Text("Please select an item")
            }
        }
        //            .toolbarBackground(Color.orange, for: .navigationBar)
        
        
        
    }
    //        .navigationViewStyle(StackNavigationViewStyle())
}


func isPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}
