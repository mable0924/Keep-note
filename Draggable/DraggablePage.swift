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
                        showingMediaPicker.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $showingMediaPicker) {
                        MediaPicker(mediaItems: $page.mediaItems)
                    }
                }
                .padding()
                .background(Color.white)
                
                GeometryReader { geometry in
                    let dotSpacing: CGFloat = 20
                    let patternSize = CGSize(width: geometry.size.width / dotSpacing, height: geometry.size.height / dotSpacing)
                    ScrollView([.horizontal, .vertical], showsIndicators: false) {
                        
                        ZStack {
                            DottedPatternView(dotSpacing: dotSpacing, patternSize: patternSize, scale: originalScale)
                                .opacity(0.5)
                            ForEach(page.mediaItems.indices, id: \.self) { index in
                                if let image = page.mediaItems[index].image {
                                    DraggableView(mediaItem: $page.mediaItems[index]) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 200, height: 200)
                                    }
                                } else if let videoURL = page.mediaItems[index].videoURL {
                                    DraggableView(mediaItem: $page.mediaItems[index], player: AVPlayer(url: videoURL)) {
                                        VideoPlayer(player: player)
                                            .frame(width: 300, height: 200)
                                    }
                                    .onAppear {
                                        player?.play()
                                    }
                                    .onDisappear {
                                        player?.pause()
                                    }
                                }
                            }
                        }
                    }
                    .scaleEffect(viewScale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged{ value in
                                scale = min(max(value.magnitude, 0.1), 4)
                                viewScale = originalScale * scale
                            }
                            .onEnded { value in
                                scale = min(max(value.magnitude, 0.1), 4)
                                originalScale *= scale
                                scale = 1.0
                                viewScale = 1.0
                            }
                    )
                    
                    
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
