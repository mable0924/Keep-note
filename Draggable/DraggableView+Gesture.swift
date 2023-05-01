//
//  DraggableView.swift
//  Draggable
//
//  Created by Po hin Ma on 23/4/2023.
//

import SwiftUI
import AVKit

struct DraggableView<Content>: View where Content: View {
    @GestureState private var dragState = DragState.inactive
    @GestureState private var magnificationFactor: CGFloat = 1.0
    @Binding var draggableItem: DraggbleObject
    @Binding var page: Page
    @State private var initialPosition: CGSize = .zero
    @State private var selected = false
    
    let index: Int
    let content: () -> Content
    let player: AVPlayer?
    
    init(draggableItem: Binding<DraggbleObject>, page: Binding<Page>, index: Int, player: AVPlayer? = nil, @ViewBuilder content: @escaping () -> Content) {
        self._draggableItem = draggableItem
        self._page = page
        self.index = index
        self.player = player
        self.content = content
    }

    
    var body: some View {
        content()
            .offset(x: dragState.translation.width, y: dragState.translation.height)
            .frame(width: draggableItem.width * magnificationFactor, height: draggableItem.height * magnificationFactor)
            .position(x: draggableItem.position.width,
                      y: draggableItem.position.height)
            .onAppear {
                initialPosition = draggableItem.position
            }
            .onTapGesture {
                print("Tap detected")
                selected.toggle()
            }
            .gesture(
                MagnificationGesture()
                    .updating($magnificationFactor) { value, state, transaction in
                        state = value
                    }
                    .onEnded{ scale in
                        draggableItem.width *= scale
                        draggableItem.height *= scale
                    }
            )
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0)
                    .sequenced(before: DragGesture())
                    .updating($dragState, body: { (value, state, transaction) in
                        
                        switch value {
                        case .first(true):
                            state = .pressing
                        case .second(true, let drag):
                            if let dragTranslation = drag?.translation {
                                let deltaX = initialPosition.width + dragTranslation.width
                                let deltaY = initialPosition.height + dragTranslation.height
                                draggableItem.position = CGSize(width: deltaX, height: deltaY)
                            }
                        default:
                            break
                        }
                        
                    })
                    .onEnded({ (value) in
                        initialPosition = draggableItem.position
                    })
            )
            
            .overlay {
                if selected {
                    HStack {
                        Image(systemName: "doc.on.doc")
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 00, trailing: 10))
                        Image(systemName: "trash")
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 00, trailing: 10))
                            .onTapGesture {
                                var newPage = page
                                newPage.remove(at: index)
                                page = newPage
                            }
                    }
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(30)
                    .clipped()
                    .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                    .position(x: draggableItem.position.width,
                              y: draggableItem.position.height + ( draggableItem.height / 2 ) + 50)
                }
            }
    }
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive, .pressing:
                return false
            case .dragging:
                return true
            }
        }
    }
}
