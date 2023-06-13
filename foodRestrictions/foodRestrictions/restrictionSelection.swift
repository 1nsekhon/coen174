//
//  restrictionSelection.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 5/23/23.
//

import SwiftUI

struct restrictionSelection: View {
    //@State private var rstrTxt = ""
    
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        switch vm.dataScannerAccessStatus {
        case .scannerAvailable:
            VStack {
                
                ZStack {
                    let selectText = UIImage(named: "ic-Iinstructions")
                    
                    if let selectText = UIImage(named: "ic-Iinstructions") {
                        Image(uiImage: selectText)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 383.42, height: 70) // Match the Figma width and height
                            .position(x: -39 + 383.42 / 2, y: 111 + 70 / 2) // Match the Figma position (x, y)
                    }
                }
     
                
                VStack {
                    HStack {
                        ZStack {
                            let noFruit = UIImage(named: "ic-nofruitoption")
                        
                            
                            NavigationLink(destination: ContentView().environmentObject(vm)) {
                                if let noFruit = UIImage(named: "ic-nofruitoption") {
                                Image(uiImage: noFruit)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 107, height: 107)
                                .position(x: 14 + 107/2, y: 107/2)
                                }
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                rstrTxt = "fruit"
                                print(rstrTxt)
                            })
                            .frame(width: 107, height: 107)
                            .position(x: 105/2, y: 107/2)
                            
                        }
                        
                        ZStack {
                            let noMeat = UIImage(named: "ic-nomeatoption")
                            
                            NavigationLink(destination: ContentView().environmentObject(vm)) {
                                if let noMeat = UIImage(named: "ic-nomeatoption") {
                                    Image(uiImage: noMeat)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 107, height: 107)
                                        .position(x: 14 + 107/2, y: 107/2)
                                }
                                
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                rstrTxt = "meat"
                                print(rstrTxt)
                            })
                            .frame(width: 107, height: 107)
                            .position(x: 100/2, y: 107/2)
                            
                        }
                        
                        ZStack {
                            let noGluten = UIImage(named: "ic-noglutenoption")

                            NavigationLink(destination: ContentView().environmentObject(vm)) {
                                if let noGluten = UIImage(named: "ic-noglutenoption") {
                                    Image(uiImage: noGluten)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 107, height: 107)
                                        .position(x: 14 + 107/2, y: 107/2)
                                }
                                
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                rstrTxt = "gluten"
                                print(rstrTxt)
                            })
                            .frame(width: 107, height: 107)
                            .position(x: 100/2, y: 107/2)
                        }
                    }
                }
            }
            
            
        case .cameraNotAvailable:
            Text("Your device doesn't have a camera")
            
        case .scannerNotAvailable:
            Text("Your device doesn't have support for scanning text with this app")
            
        case .cameraAccessNotGranted:
            Text("Please provide access to the camera in Settings")
            
        case .notDetermined:
            Text("Requesting camera access")
        }
    }
}

struct UILabelWrapperView: UIViewRepresentable {
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        // Update the UILabel's appearance or properties here if needed
    }
}

struct restrictionSelection_Previews: PreviewProvider {
    static var previews: some View {
        restrictionSelection()
    }
}
