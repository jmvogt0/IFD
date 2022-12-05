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

var cubePositions :[SIMD3<Float>] = []
var cubeDistance :Float = 0

struct RealityKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
       let view = ARView()
        
        // Start AR session
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
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
            //debugPrint("Anchors added to the scene: ", anchors)
            self.focusEntity = FocusEntity(on: view, style: .classic(color: .yellow))
        }
        func calcDistance(cubePositions: [SIMD3<Float>]) -> Float{
            let distance = distance(cubePositions.first ?? [0,0,0], cubePositions.last ?? [0,0,0])
            return distance
        }
        
        @objc func handleTap() {
            guard let view = self.view, let focusEntity = self.focusEntity else { return }

            // Create a new anchor to add content to
            let anchor = AnchorEntity()
            view.scene.anchors.append(anchor)

            // Add a Box entity with a blue material
            let box = MeshResource.generateBox(size: 0.03, cornerRadius: 0.01)
            let material = SimpleMaterial(color: .yellow, isMetallic: true)
            let diceEntity = ModelEntity(mesh: box, materials: [material])
            diceEntity.position = focusEntity.position
            // Array schreiben um Positionen der Boxen zu speichern
            cubePositions.append(diceEntity.position)
            anchor.addChild(diceEntity)
            
            cubeDistance = calcDistance(cubePositions: cubePositions)
        }
    }
}

struct ContentView: View {
    @State var testvar :Float = cubeDistance
    @State var count:Int = 1
    
    var body: some View {
        RealityKitView()
            .ignoresSafeArea()
        
        //print(someResolution.width)
        
        
        VStack {
            HStack{
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("\(testvar)")
                Button(action: {
                    self.testvar = cubeDistance
                }) {
                    Image(systemName: "plus")
                }
                       
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
