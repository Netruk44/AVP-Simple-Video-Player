//
//  ContentView.swift
//  simple-video
//
//  Created by Daniel Perry on 6/30/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
import AVKit

struct ContentView: View {
    @State private var videoURL: URL?
    @State private var isDocumentPickerPresented = false
    @State private var player: AVPlayer?

    var body: some View {
        VStack {
            if let player = player {
                PlayerViewController(player: player) {
                    // OnExitFullscreen
                    player.pause()
                    self.player = nil
                    self.videoURL = nil
                }.onAppear() {
                    player.play()
                }
            } else if videoURL != nil {
                ProgressView()
            }else {
                Text("Simple Video Player")
                    .font(.title)
                    .padding(.top, 10)
                
                Spacer()
                
                Button(action: {
                    isDocumentPickerPresented.toggle()
                }) {
                    Text("Open a video")
                        .frame(width: 200, height: 100)
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $isDocumentPickerPresented) {
            DocumentPicker { url in
                videoURL = url
                
                // Load asysnchronously
                Task {
                    player = AVPlayer(url: url)
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
