//
//  PlayerViewController.swift
//  simple-video
//
//  Created by Daniel Perry on 6/30/24.
//

import SwiftUI
import AVKit
import AVFoundation

struct PlayerViewController: UIViewControllerRepresentable {
    let player: AVPlayer
    let onExitFullscreen: () -> Void

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let viewController = AVPlayerViewController()
        viewController.player = player
        viewController.entersFullScreenWhenPlaybackBegins = true
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, onExitFullscreen: onExitFullscreen)
    }
}

class Coordinator: NSObject, AVPlayerViewControllerDelegate {
    var parent: PlayerViewController
    let onExitFullscreen: () -> Void
    
    init(_ parent: PlayerViewController, onExitFullscreen: @escaping () -> Void) {
        self.parent = parent
        self.onExitFullscreen = onExitFullscreen
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: any UIViewControllerTransitionCoordinator) {
        onExitFullscreen()
    }
}
