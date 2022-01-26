//
//  ParticlesUIView.swift
//  

import Foundation
import SwiftUI
import UIKit

public enum EmitterType {
    case point(CGPoint)
    case full
}

public class ParticlesUIView: UIView {
    public let particlesEmitter = CAEmitterLayer()
    var emitterType: EmitterType
    var items: [CAEmitterCell]
    
    /// Intialize the emitter with items conforming to `Particle`
    public init(items: [Particle],
                emitterType: EmitterType,
                frame: CGRect,
                creationRate: Float = 10,
                lifetime: Float = 10,
                velocity: Float = 100
    ) {
        self.items = items.map {
            let cell = CAEmitterCell()
            cell.contents = $0.createContents()
            cell.birthRate = 1
            cell.velocity = 1
            cell.lifetime = 1
            
            // default config. set these again if you need to
            cell.emissionLongitude = .pi
            cell.emissionRange = .pi / 4
            cell.spinRange = .pi * 2
            cell.scaleRange = 0.25
            cell.scale = 1.0 - cell.scaleRange
            
            $0.configure(cell: cell)
            return cell
        }
        
        self.emitterType = emitterType
        self.particlesEmitter.birthRate = creationRate
        self.particlesEmitter.lifetime = lifetime
        self.particlesEmitter.velocity = velocity
        super.init(frame: frame)
    }
    
    /// Intialize the emitter directly with `CAEmitterCell` array
    public init(items: [CAEmitterCell],
                emitterType: EmitterType,
                frame: CGRect,
                creationRate: Float = 10,
                lifetime: Float = 10,
                velocity: Float = 100
    ) {
        self.items = items
        
        self.emitterType = emitterType
        self.particlesEmitter.birthRate = creationRate
        self.particlesEmitter.lifetime = lifetime
        self.particlesEmitter.velocity = velocity
        super.init(frame: frame)
    }
    
    /// Initialize the emitter with an array of CGImage. Cells will be created using the image as content.
    public init(items: [CGImage],
                emitterType: EmitterType,
                frame: CGRect,
                creationRate: Float = 10,
                lifetime: Float = 10,
                velocity: Float = 100
    ) {
        self.items = items.map {
            let cell = CAEmitterCell()
            cell.contents = $0
            cell.birthRate = 1
            cell.velocity = 1
            cell.lifetime = 1
            
            // default config. set these again if you need to
            cell.emissionLongitude = .pi
            cell.emissionRange = .pi / 4
            cell.spinRange = .pi * 2
            cell.scaleRange = 0.25
            cell.scale = 1.0 - cell.scaleRange
            
            return cell
        }
        
        self.emitterType = emitterType
        self.particlesEmitter.birthRate = creationRate
        self.particlesEmitter.lifetime = lifetime
        self.particlesEmitter.velocity = velocity
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setCreationRate(_ rate: Float) {
        self.particlesEmitter.birthRate = rate
    }
    
    public func setLifetime(_ lifetime: Float) {
        self.particlesEmitter.lifetime = lifetime
    }
    
    /// Call this method once after initializing the view. Starts emitting particles and sets frame size.
    public func emitParticles() {
        particlesEmitter.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        
        layer.masksToBounds = true
        particlesEmitter.backgroundColor = UIColor.clear.cgColor
        particlesEmitter.emitterMode = .outline
        particlesEmitter.emitterShape = .line
        switch emitterType {
        case .point(let point):
            particlesEmitter.emitterSize = CGSize(width: 1.0, height: 1.0)
            particlesEmitter.emitterPosition = point
        case .full:
            particlesEmitter.emitterSize = CGSize(width: bounds.width, height: bounds.height)
            particlesEmitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.minY)
        }
        particlesEmitter.needsDisplayOnBoundsChange = true
        particlesEmitter.emitterCells = items
        particlesEmitter.beginTime = CACurrentMediaTime()
        layer.addSublayer(particlesEmitter)
    }
}
