//
//  Example.swift
//

import SwiftUI
import ParticleKit

fileprivate struct SwiftUIView: View {
    @State var active = true
    var body: some View {
        VStack {
            Button("Toggle") {
                active.toggle()
            }
            TabView {
                ParticlesView(emitting: $active,
                              items: [Emoji(of: "🎊")],
                              size: (300, 500))
                    .tabItem {
                        Text("Default")
                    }
                ParticlesView(emitting: $active,
                              emitterType: .point(CGPoint(x: 100, y: 100)),
                              items: [Emoji(of: "🎊", birthRate: 5)],
                              size: (300, 500),
                              creationRate: 5)
                    .tabItem {
                        Text("Single Point")
                    }
                ParticlesView(emitting: $active,
                              items: [Emoji(of: "🎊")],
                              size: (300, 500),
                              creationRate: 5,
                              lifetime: 5,
                              speed: 100)
                    .tabItem {
                        Text("Custom")
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
