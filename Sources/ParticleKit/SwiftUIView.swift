//
//  SwiftUIView.swift
//  

import SwiftUI

public struct ParticlesView: UIViewRepresentable {
    var emitterType: EmitterType
    var size: (Int, Int)
    var items: [CAEmitterCell]
    
    @Binding var creationRate: Float
    @Binding var lifetime: Float
    @Binding var velocity: Float
            
//    public init(emitting: Binding<Bool>,
//                emitterType: EmitterType = .full,
//                items: [Particle], size: (Int, Int),
//                creationRate: Float = 20,
//                lifetime: Float = 10,
//                speed: CGFloat = 200
//    ) {
//        self._emitting = emitting
//        self.items = items
//        self.emitterType = emitterType
//        self.size = size
//        self._creationRate = Binding.constant(creationRate)
//        self._lifetime = Binding.constant(lifetime)
//        self._speed = Binding.constant(speed)
//    }
    
    public init(emitterType: EmitterType = .full,
                items: [CAEmitterCell],
                size: (Int, Int),
                creationRate: Binding<Float> = Binding.constant(10),
                lifetime: Binding<Float> = Binding.constant(10),
                velocity: Binding<Float> = Binding.constant(100)
    ) {
        self.items = items
        self.emitterType = emitterType
        self.size = size
        self._creationRate = creationRate
        self._lifetime = lifetime
        self._velocity = velocity
    }
    
    public init(emitterType: EmitterType = .full,
                items: [Particle],
                size: (Int, Int),
                creationRate: Binding<Float> = Binding.constant(10),
                lifetime: Binding<Float> = Binding.constant(10),
                velocity: Binding<Float> = Binding.constant(100)
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
        self.size = size
        self._creationRate = creationRate
        self._lifetime = lifetime
        self._velocity = velocity
    }
    
    public init(emitterType: EmitterType = .full,
                items: [CGImage],
                size: (Int, Int),
                creationRate: Binding<Float> = Binding.constant(10),
                lifetime: Binding<Float> = Binding.constant(10),
                velocity: Binding<Float> = Binding.constant(100)
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
        self.size = size
        self._creationRate = creationRate
        self._lifetime = lifetime
        self._velocity = velocity
    }
    
    public func makeUIView(context: Context) -> ParticlesUIView {
        let view = ParticlesUIView(items: items, emitterType: emitterType, frame: CGRect(x: 0, y: 0, width: size.0, height: size.1), creationRate: creationRate, lifetime: lifetime, velocity: velocity)
        view.particlesEmitter.beginTime = CACurrentMediaTime()
        view.emitParticles()
        return view
    }
    
    public func updateUIView(_ uiView: ParticlesUIView, context: Context) {
        uiView.particlesEmitter.velocity = velocity
        uiView.particlesEmitter.birthRate = creationRate
    }
}
