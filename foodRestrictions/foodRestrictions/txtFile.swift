//
//  ViewController.swift
//  txt
//
//  Created by Megan Wiser on 5/10/23.
//  With help from this tutorial https://www.youtube.com/watch?v=e2N0kV5YQ18 from Seemu Apps
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Set up filepath
        let fileName = "Test"
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
        
        
        
        //Write string to filepath
        let writeString = "We love COEN 174"
        
        do{
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError{
            print("Failed to write to URL")
            print(error)
        }
        
        
        
        //Read new contents of file
        readString = ""
        
        do{
            readString = try String(contentsOf: fileURL)
        }catch let error as NSError{
            print("Failed to read file")
            print(error)
        }
        
        print("Contents of the file: \(readString)")
    }


}

