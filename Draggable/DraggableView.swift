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
    @Binding var mediaItem: MediaItem
    @State private var initialPosition: CGSize = .zero
    
    let content: () -> Content
    let player: AVPlayer?
    
    init(mediaItem: Binding<MediaItem>, player: AVPlayer? = nil, @ViewBuilder content: @escaping () -> Content) {
        self._mediaItem = mediaItem
        self.player = player
        self.content = content
        
        initialPosition = self.mediaItem.position
    }
    
    var body: some View {
        content()
            .offset(x: mediaItem.position.width + dragState.translation.width, y: mediaItem.position.height + dragState.translation.height)
            .gesture(
                LongPressGesture(minimumDuration: 0)
                    .sequenced(before: DragGesture())
                    .updating($dragState, body: { (value, state, transaction) in
                        
                        switch value {
                            case .first(true):
                                state = .pressing
//                                initialPosition = mediaItem.position
                            case .second(true, let drag):
//                                state = .dragging(translation: drag?.translation ?? .zero)
                            if let dragTranslation = drag?.translation {
                                let deltaX = initialPosition.width + dragTranslation.width
                                let deltaY = initialPosition.height + dragTranslation.height
                                mediaItem.position = CGSize(width: deltaX, height: deltaY)
                            }
                            
                        default:
                            break
                        }
                        
                    })
                    .onEnded({ (value) in
                        
//                        guard case .second(true, let drag?) = value else {
//                            return
//                        }
                        initialPosition = mediaItem.position
//                        withAnimation(.easeInOut) {
//                            mediaItem.position = CGSize(width: mediaItem.position.width + drag.translation.width, height: mediaItem.position.height + drag.translation.height)
//                        }
                    })
                            )
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
