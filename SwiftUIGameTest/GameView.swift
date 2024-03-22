//
//  GameView.swift
//  SwiftUIGameTest
//
//  Created by Edon Valdman on 3/22/24.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    private let scene = GameScene.newGameScene()
    
    var body: some View {
        SpriteView(
            scene: scene,
            transition: .crossFade(withDuration: 2),
            isPaused: false,
            preferredFramesPerSecond: 60,
            options: .ignoresSiblingOrder,
            debugOptions: [.showsFPS, .showsNodeCount]
        )
        .ignoresSafeArea()
    }
}

#Preview {
    GameView()
}
