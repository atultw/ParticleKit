//
//  Example.swift
//

import SwiftUI
import ParticleKit

struct SwiftUIView: View {
    @State var creationRate: Float = 5
    @State var velocity: Float = 100
    var body: some View {
        VStack {
            Text("Creation rate: \(creationRate)")
            Text("Velocity: \(velocity)")
            Slider(value: $creationRate, in: 0...10)
            Slider(value: $velocity, in: 0...500)
            Button("Toggle") {
                (creationRate > 0) ? (creationRate = 0) : (creationRate = 1)
            }
            TabView {
                ParticlesView(items: [Emoji(of: "🌧")],
                              size: (300, 500),
                              creationRate: $creationRate,
                              velocity: $velocity)
                    .tabItem {
                        Text("Default")
                    }
                ParticlesView(emitterType: .point(CGPoint(x: 100, y: 100)),
                              items: [Emoji(of: "🌧")],
                              size: (300, 500),
                              creationRate: $creationRate,
                              velocity: $velocity)
                    .tabItem {
                        Text("Single Point")
                    }
            }
            
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SwiftUIView()
        }
    }
}
