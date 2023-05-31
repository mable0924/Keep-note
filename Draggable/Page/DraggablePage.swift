//
//  DraggablePage.swift
//  Draggable
//
//  Created by Po hin Ma on 24/4/2023.
//

import SwiftUI
import AVKit

struct DraggablePage: View {
    @ObservedObject var viewModel: DraggablePageViewModel
    @Environment(\.scenePhase) private var scenePhase
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        print("test")
                        isPresented.toggle()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.showingActionSheet.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    .actionSheet(isPresented: $viewModel.showingActionSheet) {
                        ActionSheet(title: Text("新增項目"), buttons: [
                            .default(Text("新增圖片")) { viewModel.showingMediaPicker.toggle() },
                            .default(Text("新增文字")) { viewModel.draggableItems.append(DraggbleObject(image: nil, videoURL: nil, text: "點兩下來輸入文字", width: 200, height: 200)) },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $viewModel.showingMediaPicker) {
                        MediaPicker(mediaItems: $viewModel.page.draggableItems)
                    }
                }
                .padding()
                .background(Color.white)
                
                Spacer()
            }
            
            ForEach($viewModel.page.draggableItems.indices, id: \.self) { index in
                if let image = viewModel.page.draggableItems[index].image {
                    DraggableView(draggableItem: $viewModel.page.draggableItems[index], page: $viewModel.page, index: index){
                        Image(uiImage: convertBase64StringToImage(base64String: image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                } else if let text = viewModel.page.draggableItems[index].text {
                    DraggableView(draggableItem: $viewModel.page.draggableItems[index], page: $viewModel.page, index: index){
                        Text(text)
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    
                    Text(String(format: "%.0f%%", viewModel.originalScale * viewModel.scale * 100))
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
