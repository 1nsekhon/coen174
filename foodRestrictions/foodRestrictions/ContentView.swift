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
    
    @StateObject var apiHappenings = OpenAiInteraction()
    
    @State var doneScanning = false
    
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
                NavigationLink(destination: PythonCodeView()) {
                    Text("Accept Scan")
                }.simultaneousGesture(TapGesture().onEnded {
                    txt(items: vm.recognizedItems)
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
    
    func txt(items: [RecognizedItem]){
        //Translate recognized items into string to be written
        var toWrite = ""
        var b = ""
        var d = ""
        
        for item in vm.recognizedItems {
            switch item {
                case .barcode(let barcode):
                    b = barcode.payloadStringValue ?? "barcode didn't work but isn't supposed to anyways"
                    
                case .text(let text):
                    toWrite = toWrite + " " + text.transcript
                    
                @unknown default:
                    d = "wrong"
            }
        }
        
    
        
        //Set up filepath
        let fileName = "Menu"
        let DocumentDirURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appending(component: fileName).appendingPathExtension("txt")
        
        print("File Path: \(fileURL.path)")
        
        
        
        //Write string to filepath
        
        do{
            try toWrite.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError{
            print("Failed to write to URL")
            print(error)
        }
        
        print("Write is done")
    }
}
