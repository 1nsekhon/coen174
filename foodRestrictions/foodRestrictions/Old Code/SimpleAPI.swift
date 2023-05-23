//
//  SwiftUIView.swift
//  learningApis
//
//  Created by Megan Wiser on 5/14/23.
//  Following this tutorial: https://www.youtube.com/watch?v=CimY_Sr3gWw
//
// This is the actual API interaction
//
// OLD CODE

/*import SwiftUI

struct Course: Hashable, Codable {
    let name: String
    let image: String
}

class APIHappenings: ObservableObject {
    @Published var courses: [Course] = []
    
    
    func fetch() {
        guard let url = URL(string: "https://api.openai.com/v1/engines/davinci/completions") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
           
            //convert to json
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}*/
