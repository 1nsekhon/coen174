//
//  unitTestView.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 5/29/23.
//

import SwiftUI
import Foundation

struct unitTestView: View {
    var body: some View {
        // Usage:
        let folderName = "Menu Bank"
        var _ = readTextFilesInFolder(folderName: folderName)
        
        Text("called readTextFilesInFolder")
    }
    
    //takes folder name as an input
    func readTextFilesInFolder(folderName: String) {
        //uses bundle to get the url
        guard let folderURL = Bundle.main.url(forResource: folderName, withExtension: nil) else {
            print("Error: Folder not found.")
            return
        }
        
        //iterate through files in the folder
        let fileManager = FileManager.default
        let fileEnumerator = fileManager.enumerator(at: folderURL, includingPropertiesForKeys: nil)
        
        var count = 0
        
        //if txt, reads
        while let fileURL = fileEnumerator?.nextObject() as? URL {
            if fileURL.pathExtension == "txt" {
                count = count + 1
                do {
                    let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
                    print(count)
                    
                    if(unitTest.caseInsensitiveCompare(fileContents) == .orderedSame){
                        print("true for \(count)\n")
                    }
                    
                    //print("File: \(fileURL.lastPathComponent)\nContents: \(fileContents)\n")
                } catch {
                    print("Error reading file: \(fileURL.lastPathComponent)\n\(error)\n")
                }
            }
        }
    }
}
