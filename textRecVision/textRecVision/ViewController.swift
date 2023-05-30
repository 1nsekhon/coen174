import Vision
import UIKit
import SwiftUI

var countVDL = 0

struct ContentView: View {
    var body: some View {
        NavigationView {
            ViewControllerWrapper()
                .navigationBarTitle("Image Recognition")
        }
        NavigationLink(destination: unitTestView()){
            Text("move to unit test")
        }
    }
}

struct ViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        let viewController = ViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // No updates needed
    }
}

class ViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Starting..."
        return label
    }()
    
    private var imageViews: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        
        // Specify the folder name that contains the photos
        let folderName = "FontSizePhotos"
        
        // Get the URLs of the image files in the folder
        guard let folderURL = Bundle.main.url(forResource: folderName, withExtension: nil) else {
            Swift.print("Error: Folder not found.")
            return
        }
        
        let fileManager = FileManager.default
        let fileEnumerator = fileManager.enumerator(at: folderURL, includingPropertiesForKeys: nil)
        
        while let fileURL = fileEnumerator?.nextObject() as? URL {
            if let image = UIImage(contentsOfFile: fileURL.path) {
                // Create an image view for each photo and add it to the array
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                imageViews.append(imageView)
                view.addSubview(imageView)
            }
        }
        
        // Call the recognizeText method for each image view
        for imageView in imageViews {
            recognizeText(image: imageView.image)
            countVDL = countVDL + 1
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Position the label and image views
        label.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.frame.size.width - 40, height: 200)
        
        let imageViewHeight = (view.frame.size.height - view.safeAreaInsets.top - 200) / CGFloat(imageViews.count)
        for (index, imageView) in imageViews.enumerated() {
            imageView.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 200 + CGFloat(index) * imageViewHeight, width: view.frame.size.width - 40, height: imageViewHeight)
        }
    }
    
    private func recognizeText(image: UIImage?) {
        guard let cgImage = image?.cgImage else {
            fatalError("Could not get CGImage from image.")
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                return
            }
            
            let text = observations.compactMap {
                $0.topCandidates(1).first?.string
            }.joined(separator: " ")
            
            DispatchQueue.main.async {
                self?.label.text = text
            }
            
            unitTest = text
        }
        
        do {
            try handler.perform([request])
        } catch {
            label.text = "\(error)"
        }
        
        let folderName = "Menu Bank"
        var _ = readTextFilesInFolder(folderName: folderName)
        
        print("done with readTextFilesInFolder round \(countVDL)")
    }
    
    //takes folder name as an input
    func readTextFilesInFolder(folderName: String) {
        print("inside readTextFilesInFolder")
        
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
                if countVDL != 0 {
                    removeWhitespace(from: fileURL)
                }
                
                count = count + 1
                do {
                    let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
                    //print(count)
                    
                    if(unitTest == fileContents){
                        print("true for \(count)\n")
                    }
                    
                    if count == 81 {
                        print("false for all\n")
                        print(unitTest)
                    }
                    
                    //print("File: \(fileURL.lastPathComponent)\nContents: \(fileContents)\n")
                } catch {
                    print("Error reading file: \(fileURL.lastPathComponent)\n\(error)\n")
                }
            }
        }
    }
    
    func removeWhitespace(from fileURL: URL) {
        do {
            // Read the content of the file
            var fileContent = try String(contentsOf: fileURL, encoding: .utf8)
            
            // Remove whitespace characters from the content
            fileContent = fileContent.replacingOccurrences(of: "\\s+", with: "", options: .regularExpression)
            
            // Write the modified content back to the file
            try fileContent.write(to: fileURL, atomically: true, encoding: .utf8)
            
            //print("Whitespace removed from file: \(fileURL.path)")
        } catch {
            print("Error: \(error)")
        }
    }
}
