//
//  Example.swift
//

import SwiftUI
import ParticleKit

struct Confetti: Particle {
    func createContents() -> CGImage? {
        "🎊".bitmapped()
    }
    
    func configure(cell: CAEmitterCell) {
    }
}

struct SwiftUIView: View {
    @State var creationRate: Float = 5
    @State var velocity: Float = 100
    var body: some View {
        VStack {
            Text("Velocity: \(velocity)")
            Slider(value: $velocity, in: 0...500)
            TabView {
                VStack {
                    Text("Creation rate: \(creationRate)")
                    Slider(value: $creationRate, in: 0...10)
                    Button("Toggle") {
                        (creationRate > 0) ? (creationRate = 0) : (creationRate = 1)
                    }
                    ParticlesView(items: [Emoji(of: "🌧")],
                                  size: (300, 500),
                                  creationRate: $creationRate,
                                  velocity: $velocity)
                }
                .tabItem {
                    Text("Default")
                }
                ParticlesView(emitterType: .point(CGPoint(x: 100, y: 100)),
                              items: [Confetti()],
                              size: (300, 500),
                              creationRate: Binding.constant(2.0),
                              velocity: $velocity)
                    .tabItem {
                        Text("Custom")
                    }
                ParticlesView(emitterType: .point(CGPoint(x: 100, y: 100)),
                              items: [UIImage(systemName: "person.circle")!.cgImage!],
                              size: (300, 500),
                              creationRate: Binding.constant(2.0),
                              velocity: $velocity)
                    .tabItem {
                        Text("Direct image")
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
