//
//  ContentView.swift
//  Draggable
//
//  Created by Po hin Ma on 23/4/2023.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var player: AVPlayer?
    @State private var mediaItems: [MediaItem] = []
    @State private var showingMediaPicker = false

    var body: some View {
        NavigationView{
            ZStack {
                ForEach(mediaItems) { mediaItem in
                    if let image = mediaItem.image {
                        DraggableView {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                        }
                    } else if let videoURL = mediaItem.videoURL {
                        DraggableView(player: AVPlayer(url: videoURL)) {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingMediaPicker.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingMediaPicker) {
                MediaPicker(mediaItems: $mediaItems)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
