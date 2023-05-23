//
//  restrictionSelection.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 5/23/23.
//

import SwiftUI

struct restrictionSelection: View {
    var restrictionS = ""
    
    @EnvironmentObject var vm: AppViewModel
    
    var body: some View {
        switch vm.dataScannerAccessStatus {
            
        case .scannerAvailable:
            Text("Select your restrictions")
            
            var a = ""
            
            VStack{
                HStack{
                    Button("No Meat") {
                        a = "a"
                        print(a)
                    }
                    Button("No Gluten") {
                        a = "b"
                        print(a)
                    }
                    Button("No Fruit") {
                        a = "c"
                        print(a)
                    }
                }
                
                NavigationLink(destination: ContentView().environmentObject(vm)) {
                    Text("Move to Scan")
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

struct restrictionSelection_Previews: PreviewProvider {
    static var previews: some View {
        restrictionSelection()
    }
}
