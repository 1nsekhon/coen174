//
//  ContentView.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 4/26/23.
//  With help from https://www.youtube.com/watch?v=QQjLOlkxpvc
//

import SwiftUI
import VisionKit

struct ContentView: View {
    
    @EnvironmentObject var vm: AppViewModel
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("All", .none)
    ]
    
    var body: some View {
        switch vm.dataScannerAccessStatus {
            
        case .scannerAvailable:
            mainView
            
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
    
    private var mainView: some View {
        VStack {
            DataScannerView(recognizedItems: $vm.recognizedItems,
                            recognizedDataType: vm.recognizedDataType,
                            recognizesMultipleItems: vm.recognizesMultipleItems)
            .background { Color.gray.opacity(0.3) }
            .ignoresSafeArea()
            .id(vm.dataScannerViewId)
            
            VStack {
                headerView
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(vm.recognizedItems) { item in
                            switch item {
                                case .barcode(let barcode):
                                    Text(barcode.payloadStringValue ?? "Unknown barcode")
                                
                                case .text(let text):
                                    Text(text.transcript)
                                    //Export to txt file here
                                
                                @unknown default:
                                    Text("Unknown")
                            }
                        }
                    }
                    
                    .padding()
                }
            }
        }
        
        .onChange(of: vm.scanType) { _ in vm.recognizedItems = [] }
        .onChange(of: vm.textContentType) { _ in vm.recognizedItems = [] }
        .onChange(of: vm.recognizesMultipleItems) { _ in vm.recognizedItems = [] }
    }
    
    private var headerView: some View {
    
        VStack {
            Text(vm.headerText).padding(.top)
        }.padding(.horizontal)
    }
    
}
