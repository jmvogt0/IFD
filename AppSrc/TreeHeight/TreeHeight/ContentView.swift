//
//  ContentView.swift
//  TreeHeight
//
//  Created by Jan Vogt on 18.11.22.
//

import ARKit
import RealityKit
import SwiftUI
import FocusEntity

struct RealityKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
       let view = ARView()
        
        // Start AR session
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        
        // Add coaching overlay
       let coachingOverlay = ARCoachingOverlayView()
       coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       coachingOverlay.session = session
       coachingOverlay.goal = .horizontalPlane
       view.addSubview(coachingOverlay)
        
        // Set debug options
       #if DEBUG
       /* view.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry] */
       #endif
        
        // Handle ARSession events via delegate
        context.coordinator.view = view
        session.delegate = context.coordinator
        
        // Handle taps
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap)
            )
        )
        
       return view
    }

    func updateUIView(_ view: ARView, context: Context) {
    }
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    class Coordinator: NSObject, ARSessionDelegate {
        weak var view: ARView?
        var focusEntity: FocusEntity?

        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard let view = self.view else { return }
            debugPrint("Anchors added to the scene: ", anchors)
            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
        }
        
        @objc func handleTap() {
            guard let view = self.view, let focusEntity = self.focusEntity else { return }

            // Create a new anchor to add content to
            let anchor = AnchorEntity()
            view.scene.anchors.append(anchor)

            // Add a Box entity with a blue material
            let box = MeshResource.generateBox(size: 0.01, cornerRadius: 0.01)
            let material = SimpleMaterial(color: .blue, isMetallic: true)
            let diceEntity = ModelEntity(mesh: box, materials: [material])
            diceEntity.position = focusEntity.position

            anchor.addChild(diceEntity)
            print (anchor)
        }
    }
}
struct AnchorPoints {
    let pos1 = "test";
}
struct Resolution {
    var width = 0
    var height = 0
}

struct ContentView: View {
    var body: some View {
        RealityKitView()
            .ignoresSafeArea()
        
        let someResolution = Resolution()
        //print(someResolution.width)
        
        
        VStack {
            HStack{
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
