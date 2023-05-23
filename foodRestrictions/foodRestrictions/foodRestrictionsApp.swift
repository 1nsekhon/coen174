//
//  foodRestrictionsApp.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 4/26/23.
//

import SwiftUI

@main
struct foodRestrictionsApp: App {
    
    @StateObject private var vm = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                restrictionSelection()
                    .environmentObject(vm)
                    .task {
                        await vm.requestDataScannerAccessStatus()           //First time the user launches the app, asks for camera access
                    }
            }
        }
    }
}
