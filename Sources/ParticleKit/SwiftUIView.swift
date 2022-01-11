//
//  SwiftUIView.swift
//  

import SwiftUI

public struct ParticlesView: UIViewRepresentable {
    @Binding var emitting: Bool
    var emitterType: EmitterType
    var size: (Int, Int)
    var items: [Particle]
    
    var creationRate: Int
    var lifetime: Int
    var speed: Int
    
    public init(emitting: Binding<Bool>,
                emitterType: EmitterType = .full,
                items: [Particle], size: (Int, Int),
                creationRate: Int = 20,
                lifetime: Int = 10,
                speed: Int = 200
    ) {
        self._emitting = emitting
        self.items = items
        self.emitterType = emitterType
        self.size = size
        self.creationRate = creationRate
        self.lifetime = lifetime
        self.speed = speed
    }
    
    public func makeUIView(context: Context) -> ParticlesUIView {
        let view = ParticlesUIView(items: items, emitterType: emitterType, frame: CGRect(x: 0, y: 0, width: size.0, height: size.1), creationRate: creationRate, lifetime: lifetime, speed: speed)
        view.emitParticles()
        return view
    }
    
    public func updateUIView(_ uiView: ParticlesUIView, context: Context) {
        emitting ? uiView.startParticles() : uiView.stopParticles()
    }
}
