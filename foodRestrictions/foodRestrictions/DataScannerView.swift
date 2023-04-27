//
//  DataScannerView.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 4/27/23.
//

import Foundation
import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable {
    
    @Binding var recognizedItems: [RecognizedItem]
    
    //user selects whether they want to scan qr/bar code or text
    //for our purposes, should be hardcoded to text
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    
    //user selects whether they want to scan multiple items or not
    //for our purposes, should be hardcoded to true
    let recognizesMultipleItems: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        
        let vc = DataScannerViewController(
            recognizedDataTypes: [recognizedDataType],
            qualityLevel: .balanced,
            recognizesMultipleItems: recognizesMultipleItems,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        
        return vc
        
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
        
    }
    
    func makeCoordinator() -> Coordinator {
        
        Coordinator(recognizedItems: $recognizedItems)
        
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        
        @Binding var recognizedItems: [RecognizedItem]
        
        init(recognizedItems: Binding<[RecognizedItem]>) {
            
            self._recognizedItems = recognizedItems
            
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            
            print("didTapOn \(item)")
            
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
         
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            
            recognizedItems.append(contentsOf: addedItems)
            
            print("didAddItems \(addedItems)")
            
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            
            self.recognizedItems = recognizedItems.filter {
                
                item in
                !removedItems.contains(where: {$0.id == item.id})
                
            }
            
            print("didRemovedItems \(removedItems)")
            
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            
            print("became unavailable with error \(error.localizedDescription)")
            
        }
        
    }
    
}
