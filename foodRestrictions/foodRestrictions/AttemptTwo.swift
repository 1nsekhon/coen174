//
//  AttemptTwo.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 5/14/23.
//

import SwiftUI
import Foundation
import TabularData




class OpenAiInteraction: ObservableObject {
    @State private var menuText: String = ""
    @State private var menuDF: DataFrame?
    
    struct Response: Hashable, Codable {
        let name: String
    }
    
    @Published var responses: [Response] = []
    
    func createMenuDataFrame() {
        let question = "Make a table(table has 5 columns: food item, description of item, if it contains meat, if it contains gluten, if it contains fruit) for the following menu: \(menuText)"
        
        var r = ""
        
        askQuestion(prompt: question) { (response, error) in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            r = response
        }
        
        let menuList = r.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
        let menuData = menuList.map { $0.components(separatedBy: ",") }
        let menuColumns = menuData[0]
        let menuRows = menuData.dropFirst()
        
        var menuDict: [String: [String]] = [:]
        for column in menuColumns {
            menuDict[column] = []
        }
        
        for row in menuRows {
            for (index, value) in row.enumerated() {
                let column = menuColumns[index]
                menuDict[column]?.append(value)
            }
        }
        
        var menuTable: [[String: String]] = []
        for row in menuRows {
            var rowData: [String: String] = [:]
            for (index, value) in row.enumerated() {
                let column = menuColumns[index]
                rowData[column] = value
            }
            menuTable.append(rowData)
        }
        
        
        /*var col: Column <AnyColumn>
         col = Column(menuColumns)
         
         menuDF = DataFrame(columns: col)
         //menuDF = DataFrame(columns: menuColumns)
         //menuDF = DataFrame(columns: menuColumns, data: menuTable)*/
        //}
    }
    
    func askQuestion(prompt: String, completion: @escaping (String?, Error?) -> Void) {
        let willapiKey = "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"
        let meganapiKey = "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"
        
        let apiKey = meganapiKey
        let urlString = "https://api.openai.com/v1/engines/davinci/completions"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params = [
            "prompt": prompt,
            "max_tokens": 1024,
            "n": 1,
            "temperature": 0.5
        ] as [String : Any]
        
        /*do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            completion(nil, error)
            return
        }*/
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            
            //Convert to JSON
            do {
                let json = try JSONDecoder().decode([Response].self, from: data)
                DispatchQueue.main.async {
                    self.responses = self.responses
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
