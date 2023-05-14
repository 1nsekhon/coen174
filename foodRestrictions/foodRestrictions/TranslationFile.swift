//
//  TranslationFile.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 5/14/23.
//

import Foundation

// Function to ask a question using OpenAI API
func askQuestion(prompt: String, completion: @escaping (String?, Error?) -> Void) {
    let apiKey = "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"
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
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
    } catch {
        completion(nil, error)
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data else {
            completion(nil, error)
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let choices = json?["choices"] as? [[String: Any]], let text = choices[0]["text"] as? String {
                completion(text, nil)
            } else {
                completion(nil, nil)
            }
        } catch {
            completion(nil, error)
        }
    }
    
    task.resume()
}


// Ask for menu text
func inputTxt(){
    
}
/*print("menu text?")
guard let txtOfMenu = readLine() else {
    print("Invalid input")
    exit(0)
}*/

// Create the question string to feed to Chat GPT
let question = "Make a table(table has 5 columns: food item, description of item, if it contains meat, if it contains gluten, if it contains fruit) for the following menu: " + txtOfMenu

// Ask the question and get the response
askQuestion(prompt: question) { (response, error) in
    guard let response = response else {
        print("Error: \(error?.localizedDescription ?? "Unknown error")")
        return
    }
    
    // Parse the Chat GPT response to convert to a table (Pandas DataFrame)
    let menuList = response.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
    var menuData = menuList.map { $0.components(separatedBy: ",") }
    
    // Create the DataFrame (Pandas DataFrame equivalent)
    let menuColumns = menuData.removeFirst()
    var menuDict: [String: [String]] = [:]
    for column in menuColumns {
        menuDict[column] = []
    }
    
    for row in menuData {
        for (index, value) in row.enumerated() {
            let column = menuColumns[index]
            menuDict[column]?.append(value)
        }
    }
    
    // Convert to Swift's Dictionary representation
    var menuTable: [[String: String]] = []
    for row in menuData {
        var rowData: [String: String] = [:]
        for (index, value) in row.enumerated() {
            let column = menuColumns[index]
            rowData[column] = value
        }
        menuTable.append(rowData)
    }
    
    //
