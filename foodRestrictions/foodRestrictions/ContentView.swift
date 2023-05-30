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
    
    @State var doneScanning = false
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("All", .none)
    ]
    
    var body: some View {
        mainView
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
                                Text(barcode.payloadStringValue ?? "Unknown barcode") //no longer relevant but ok
                                
                            case .text(let text):
                                Text(text.transcript)
                                
                            @unknown default:
                                Text("Unknown")
                            }
                        }
                    }
                    .padding()
                }
                
                //Export to txt file here
                NavigationLink(destination: apiCall()) {
                    Text("Accept Scan")
                }.simultaneousGesture(TapGesture().onEnded {
                    condenseString(items: vm.recognizedItems)
                })
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
    
    func condenseString(items: [RecognizedItem]){
        //Translate recognized items into string to be written
        var toWrite = ""
        
        for item in vm.recognizedItems {
            switch item {
                case .barcode(let barcode):
                    var _ = barcode.payloadStringValue ?? "barcode didn't work but isn't supposed to anyways"
                    
                case .text(let text):
                    toWrite = toWrite + " " + text.transcript
                    
                @unknown default:
                    var _ = "wrong"
            }
        }
    
        print("Condensed")
        
        menuTxt = toWrite
        unitTest = toWrite
    }
}
