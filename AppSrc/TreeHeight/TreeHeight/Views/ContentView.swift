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
import CoreMotion

var cubePositions :[SIMD3<Float>] = []
var cubeDistance :Float = 0
var cubeCount :Int = 0
var finished :Bool = false

// AR View
struct RealityKitView: UIViewRepresentable {
    
    let view = ARView()
    
    func makeUIView(context: Context) -> ARView {
        
        // Start AR session
        let session = view.session
        let config = ARWorldTrackingConfiguration()
        session.run(config)
        
        // Add coaching overlay
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        view.addSubview(coachingOverlay)
        
        // Handle ARSession events via delegate
        context.coordinator.view = view
        session.delegate = context.coordinator
        
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
        func countCubes(cubePositions: [SIMD3<Float>])  -> Int{
            let count :Int = cubePositions.count
            return count
        }
        
        func addCube(view: ARView, didUpdate frame: ARFrame) {
            
            let transform = frame.camera.transform.columns.3
            let devicePosition = simd_float3(x: transform.x, y: transform.y, z: transform.z)
            
            // Create a new anchor to add content to
            let anchor = AnchorEntity()
            view.scene.anchors.append(anchor)
            
            // Add a Box entity with a blue material
            let box = MeshResource.generateBox(size: 0.02, cornerRadius: 0.01)
            let material = SimpleMaterial(color: .red, isMetallic: true)
            let diceEntity = ModelEntity(mesh: box, materials: [material])
            diceEntity.position = devicePosition
            // Array schreiben um Positionen der Boxen zu speichern
            cubePositions.append(diceEntity.position)
            anchor.addChild(diceEntity)
            
            cubeDistance = calcDistance(cubePositions: cubePositions)
            
            cubeCount = countCubes(cubePositions: cubePositions)
        }
    }
}

struct ContentView: View {
    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    @EnvironmentObject var cubeSettings :CubeSettings
    
    @State var finished :Bool = false
    
    
    var body: some View {
            return Group {
                if finished {
                    DetailView()
                }
                else {
                    MeasureView(finished: $finished)
                }
            }
            .environmentObject(cubeSettings)
        }
}

struct MeasureView: View {
    @EnvironmentObject var cubeSettings: CubeSettings
    
    @State var gyroRunning :Bool = false
    var gyro = Gyro.Gyros()
    //Dreieck für die Berechnung der Höhe
    var triangle = Calc.Triangle()
    @State var treeHeight :Double = 0
    
    @State var btnCount :Int = 0
    
    @Binding var finished :Bool
    
    let arView = RealityKitView()
    
    let coord = RealityKitView.Coordinator()
    
    @State var anleitungText :String = "iPhone an Baumstamm halten"
    
    
    // irgendwie das hier mit der Variable beheben
    @State var deviceRotation :Double = 0
    
    //Date things
    let saveDate = Calc.SaveDate()
    var body: some View {
        ZStack{
            arView
                .ignoresSafeArea()
                .environmentObject(cubeSettings)
            VStack(){
                ZStack(){
                    Color(UIColor.init(named: "AnleitungBackgroundColor") ?? .black)
                    Text(anleitungText)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }
                .frame(width: 150.0, height: 75.0)
                    .padding([.bottom], 150)
                    .cornerRadius(5)
            }
            Image(systemName: "ring.circle")
                .resizable()
                .frame(width: 32.0, height: 32.0)
                .foregroundColor(Color(UIColor.init(named: "ButtonSymbolColor") ?? .black))
                
        }
            VStack {
                Text("Schritt \(btnCount + 1) / 2")
                HStack{
                    Button(
                        action: {
                            coord.addCube(view :arView.view, didUpdate: arView.view.session.currentFrame!)
                            switch btnCount {
                            case 0:
                                print("1")
                                deviceRotation = gyro.rotation
                                gyro.startGyros()
                                gyroRunning = true
                                anleitungText = "Vom Baum entfernen und Baumspitze markieren"

                            case 1:
                                print("2")
                                gyro.stopGyros()
                                gyroRunning = false
                                deviceRotation = gyro.rotation
                                self.finished = true
                                cubeSettings.distance = Double(cubeDistance)
                                cubeSettings.height = triangle.calcHeight(distance: cubeSettings.distance, angle: deviceRotation)
                                UserDefaults.standard.set(cubeSettings.height, forKey:"LastTreeHeight")
                                
                                cubeSettings.date = saveDate.formatDate(date: Date.init())
                                UserDefaults.standard.set(cubeSettings.date, forKey:"LastTreeHeightDate")
                                arView.view.session.pause()
                            default: print("Error")
                            }
                        self.btnCount += 1
                    }){
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 32.0, height: 32.0)
                            .foregroundColor(Color(UIColor.init(named: "ButtonSymbolColor") ?? .black))
                    }
                    //.background(Color.green)
                    //.foregroundColor(.white)
                    //.border(1)
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            .environmentObject(cubeSettings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
