//
//  ContentView.swift
//  visionos-usdz-realitykit
//
//  Created by Sebastian Kotarski on 30/06/2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var startAnimation = false

    var body: some View {
        VStack {
            Button("soves(eng: \"fly\")") {
                startAnimation = true
            }.padding3D(.all)

            RealityView { content in
                if let dragon = loadEntity() {
                    content.add(dragon)
                    dragon.isEnabled = false
                    dragon.transform.scale = .init(0.1, 0.1, 0.1)
                    dragon.transform.translation.y = dragon.transform.translation.y - 1
                }
            } update: { content in
                if startAnimation {
                    guard let dragon = content.entities.first else { return }

                    dragon.isEnabled = true
                    dragon.availableAnimations.forEach { animation in
                        dragon.playAnimation(animation.repeat(), transitionDuration: 3)
                    }
                }
            }
        }
    }

    private func loadEntity() -> Entity? {
        try? Entity.load(
            named: "Scene",
            in: realityKitContentBundle
        )
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
