//
//  PythonCodeView.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 5/10/23.
//

import SwiftUI
import TabularData

private var restriction: String = ""
private var menu: String = ""

struct PythonCodeView: View {
    @StateObject var apiHappenings = OpenAiInteraction()
    
    @State private var menuText: String = ""
    @State private var menuDF: DataFrame?
    
    var body: some View {
        VStack {
            let _ = txtReads(fileName: "Restriction")
            let _ = txtReads(fileName: "Menu")
            
            //call api
            let _ = ViewController()
        }
        .padding()
    }
}

struct doneView: View {
    var body: some View {
        Text("api call is done")
    }
}

func txtReads(fileName: String){
    
    //Set up filepath
    let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = DocumentDirURL.appending(component: fileName).appendingPathExtension("txt")
    
    print("File Path: \(fileURL.path)")
    
    
    
    //Read what was previously in the file
    var readString = ""
    
    do{
        readString = try String(contentsOf: fileURL)
    }catch let error as NSError{
        print("Failed to read file")
        print(error)
    }
    
    print("Contents of the file: \(readString)")
    
    if(fileName == "Restriction"){
        restriction = readString
    } else {
        menu = readString
    }
}
