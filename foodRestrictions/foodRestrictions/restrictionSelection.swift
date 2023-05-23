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
            
            VStack{
                HStack{
                    NavigationLink(destination: ContentView().environmentObject(vm)) {
                        Text("No Meat")
                    }.simultaneousGesture(TapGesture().onEnded {
                        rstrTxt = "meat"
                        print(rstrTxt)
                    })
                    
                    NavigationLink(destination: ContentView().environmentObject(vm)) {
                        Text("No Gluten")
                    }.simultaneousGesture(TapGesture().onEnded {
                        rstrTxt = "gluten"
                        print(rstrTxt)
                    })
                    
                    NavigationLink(destination: ContentView().environmentObject(vm)) {
                        Text("No Fruit")
                    }.simultaneousGesture(TapGesture().onEnded {
                        rstrTxt = "fruit"
                        print(rstrTxt)
                    })
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
