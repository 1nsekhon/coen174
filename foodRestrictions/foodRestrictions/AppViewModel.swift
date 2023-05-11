//
//  AppViewModel.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 4/27/23.
//

import AVKit
import Foundation
import SwiftUI
import VisionKit

enum ScanType: String {
   
    case barcode, text
    
}


enum DataScannerAccessStatusType {
    
    case notDetermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    
    case scannerAvailable
    case scannerNotAvailable
    
}

@MainActor
final class AppViewModel: ObservableObject {
   
    //Scanner access
    @Published var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined
    
    //Scanning the items
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var scanType: ScanType = .text
    @Published var textContentType: DataScannerViewController.TextContentType?
    @Published var recognizesMultipleItems = true
    
    
    var recognizedDataType: DataScannerViewController.RecognizedDataType {
        scanType == .barcode ? .barcode() :
            .text(textContentType: textContentType)
    }

    var headerText: String {
        if recognizedItems.isEmpty {
            return "Scanning \(scanType.rawValue)"
        } else {
            return "Recognized \(recognizedItems.count) item(s)"
        }
    }
    
    var dataScannerViewId: Int {
        var hasher = Hasher()
        hasher.combine(scanType)
        hasher.combine(recognizesMultipleItems)
        if let textContentType {
            hasher.combine(textContentType)
        }
        
        return hasher.finalize()
    }

    //Are you able to scan on this device?
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    //Is the scanner available and if it is, can we use it?
    func requestDataScannerAccessStatus() async {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            
            dataScannerAccessStatus = .cameraNotAvailable
            return
            
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .authorized:
            dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            
        case .restricted, .denied:
            dataScannerAccessStatus = .cameraAccessNotGranted
            
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            
            if granted {
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            } else {
                dataScannerAccessStatus = .cameraAccessNotGranted
            }
            
        default: break
        
        }
        
    }
    
}
