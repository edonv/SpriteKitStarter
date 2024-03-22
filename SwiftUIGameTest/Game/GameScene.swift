//
//  GameScene.swift
//  GameTest Shared
//
//  Created by Edon Valdman on 3/22/24.
//

import SpriteKit

// MARK: Core Scene Logic

class GameScene: SKScene {
    
    fileprivate var label: SKLabelNode?
    fileprivate var spinnyNode: SKShapeNode?

    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFit
        
        return scene
    }
    
    private func setUpScene() {
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 4.0
            spinnyNode.run(.repeatForever(.rotate(byAngle: .pi, duration: 1)))
            spinnyNode.run(.sequence(
                [
                    .wait(forDuration: 0.5),
                    .fadeOut(withDuration: 0.5),
                    .removeFromParent()
                ]
            ))
        }
    }
    
    override func didMove(to view: SKView) {
        // Set up
        self.setUpScene()
    }

    private func makeSpinny(at pos: CGPoint, color: SKColor) {
        guard let spinny = self.spinnyNode?.copy() as! SKShapeNode? else { return }
        spinny.position = pos
        spinny.strokeColor = color
        self.addChild(spinny)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

// MARK: Shared Interactive Logic

extension GameScene {
    private func makeSpinnies(at locations: [CGPoint], color: SKColor) {
        for loc in locations {
            self.makeSpinny(at: loc, color: color)
        }
    }
    
    private func startTouches(at locations: [CGPoint]) {
        if let label = self.label {
            label.run(.gtPulse, withKey: "fadeInOut")
        }
        
        self.makeSpinnies(at: locations, color: .green)
    }
    
    private func moveTouches(at locations: [CGPoint]) {
        self.makeSpinnies(at: locations, color: .blue)
    }
    
    private func endTouches(at locations: [CGPoint]) {
        self.makeSpinnies(at: locations, color: .red)
    }
}

#if !os(macOS)
// MARK: Touch-based event handling

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startTouches(at: touches.map { $0.location(in: self) })
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveTouches(at: touches.map { $0.location(in: self) })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endTouches(at: touches.map { $0.location(in: self) })
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        endTouches(at: touches.map { $0.location(in: self) })
    }
}
#endif

#if os(macOS)
// MARK: Mouse-based event handling

extension GameScene {
    override func mouseDown(with event: NSEvent) {
        startTouches(at: [event.location(in: self)])
    }
    
    override func mouseDragged(with event: NSEvent) {
        moveTouches(at: [event.location(in: self)])
    }
    
    override func mouseUp(with event: NSEvent) {
        endTouches(at: [event.location(in: self)])
    }
}
#endif
