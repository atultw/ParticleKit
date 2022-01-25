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
    let particlesEmitter = CAEmitterLayer()
    var emitterType: EmitterType
    var items: [Particle]
    
    var creationRate: Float
    var lifetime: Float
    var velocity: Float
    
    public init(items: [Particle],
                emitterType: EmitterType,
                frame: CGRect,
                creationRate: Float = 10,
                lifetime: Float = 10,
                velocity: Float = 100
    ) {
        self.items = items
        self.emitterType = emitterType
        self.creationRate = creationRate
        self.lifetime = lifetime
        self.velocity = velocity
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func emitParticles() {
        particlesEmitter.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        
        //        particlesEmitter.frame = self.frame
        layer.masksToBounds = true
        particlesEmitter.backgroundColor = UIColor.clear.cgColor
        particlesEmitter.emitterMode = .outline
        particlesEmitter.emitterShape = .line
        particlesEmitter.velocity = velocity
        switch emitterType {
        case .point(let point):
            particlesEmitter.emitterSize = CGSize(width: 1.0, height: 1.0)
            particlesEmitter.emitterPosition = point
        case .full:
            particlesEmitter.emitterSize = CGSize(width: bounds.width, height: bounds.height)
            particlesEmitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.minY)
        }
        //        particlesEmitter.needsDisplayOnBoundsChange = true
        particlesEmitter.emitterCells = items.map {
            let cell = CAEmitterCell()
            cell.contents = $0.createContents()
            cell.birthRate = creationRate
            cell.velocity = 1
            cell.lifetime = lifetime
            return $0.createCell(from: cell)
        }
        particlesEmitter.beginTime = CACurrentMediaTime()
        layer.addSublayer(particlesEmitter)
    }
    
    func stopParticles() {
//        particlesEmitter.beginTime = CACurrentMediaTime()
        self.particlesEmitter.birthRate = 0
    }
    
    func startParticles() {
        particlesEmitter.beginTime = CACurrentMediaTime()
        self.particlesEmitter.birthRate = 1
    }
}
