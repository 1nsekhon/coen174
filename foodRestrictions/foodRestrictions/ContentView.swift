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
            /*HStack {
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
                    .position(x:  20 + 107/2, y: 107/2)
                    
                }
                
                ZStack {
                    let noMeat = UIImage(named: "ic-nomeatoption")
                    
                    NavigationLink(destination: ContentView().environmentObject(vm)) {
                        if let noMeat = UIImage(named: "ic-nomeatoption") {
                            Image(uiImage: noMeat)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 107, height: 107)
                                .position(x: 142/2, y: 79/2)
                        }
                        
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        rstrTxt = "meat"
                        print(rstrTxt)
                    })
                    .frame(width: 107, height: 107)
                    .position(x: 142/2, y: 79/2)
                    
                }
                
                ZStack {
                    let noGluten = UIImage(named: "ic-noglutenoption")

                    NavigationLink(destination: ContentView().environmentObject(vm)) {
                        if let noGluten = UIImage(named: "ic-noglutenoption") {
                            Image(uiImage: noGluten)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 107, height: 107)
                                .position(x: 263/2, y: 79/2)
                        }
                        
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        rstrTxt = "gluten"
                        print(rstrTxt)
                    })
                    .frame(width: 107, height: 107)
                    .position(x: 263/2, y: 79/2)
                }
            }*/
            
            DataScannerView(recognizedItems: $vm.recognizedItems,
                            recognizedDataType: vm.recognizedDataType,
                            recognizesMultipleItems: vm.recognizesMultipleItems)
            .frame(width: 349, height: 446)
            .background { Color.black }
            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 + 50)
            .ignoresSafeArea()
            .id(vm.dataScannerViewId)
            
            
        return VStack {
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
            let done = UIImage(named: "ic-done")
            NavigationLink(destination: apiCall()) {
                if let done = UIImage(named: "ic-done") {
                Image(uiImage: done)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 185.51, height: 59)
                .position(x: 101 + 185.51/2, y: 600/2)
                }
            }.simultaneousGesture(TapGesture().onEnded {
                condenseString(items: vm.recognizedItems)
            })
                
                /*Export to txt file here
                NavigationLink(destination: apiCall()) {
                    Text("Accept Scan")
                }.simultaneousGesture(TapGesture().onEnded {
                    condenseString(items: vm.recognizedItems)
                })
                 */
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
    }
}
