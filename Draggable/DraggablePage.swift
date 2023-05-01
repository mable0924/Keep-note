//
//  DraggablePage.swift
//  Draggable
//
//  Created by Po hin Ma on 24/4/2023.
//

import SwiftUI
import AVKit

struct DraggablePage: View {
    @State private var player: AVPlayer?
    @Binding var page: Page
    @State private var showingMediaPicker = false
    @State private var showingTextEntry = false
    @State private var showingActionSheet = false
    @State private var scale: CGFloat = 1.0
    @State private var originalScale: CGFloat = 1.0
    @State private var viewScale: CGFloat = 1.0
    @State private var size: CGFloat = 1.0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Button(action: {
                        showingActionSheet.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(title: Text("新增項目"), buttons: [
                            .default(Text("新增圖片")) { showingMediaPicker.toggle() },
                            .default(Text("新增文字")) { page.draggableItems.append(DraggbleObject(image: nil, videoURL: nil, text: "點兩下來輸入文字", width: 200, height: 200)) },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $showingMediaPicker) {
                        MediaPicker(mediaItems: $page.draggableItems)
                    }
                }
                .padding()
                .background(Color.white)
                
                Spacer()
            }
            
            ForEach(page.draggableItems.indices, id: \.self) { index in
                if let image = page.draggableItems[index].image {
                    DraggableView(draggableItem: $page.draggableItems[index], page: $page, index: index){
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                } else if let text = page.draggableItems[index].text {
                    DraggableView(draggableItem: $page.draggableItems[index], page: $page, index: index){
                        Text(text)
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    
                    Text(String(format: "%.0f%%", originalScale * scale * 100))
                        .font(.system(size: 14, weight: .bold))
                        .padding(6)
                        .background(Color.black.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 0))
                    Spacer()
                }
                
            }
            
        }
    }
}

// 波點background -- calculate from GeometryReader ( not done )
struct DottedPatternView: View {
    let dotSpacing: CGFloat
    let patternSize: CGSize
    let scale: CGFloat
    
    var body: some View {
        VStack(spacing: dotSpacing > dotSpacing * scale ? dotSpacing / scale : dotSpacing) {
            ForEach(0..<Int(patternSize.height > patternSize.height * scale ? patternSize.height / scale : patternSize.height), id: \.self) { _ in
                HStack(spacing: dotSpacing > dotSpacing * scale ? dotSpacing / scale : dotSpacing) {
                    ForEach(0..<Int(patternSize.width > patternSize.width * scale ? patternSize.width / scale : patternSize.width), id: \.self) { _ in
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 2 / scale, height: 2 / scale)
                    }
                }
            }
        }
    }

}
