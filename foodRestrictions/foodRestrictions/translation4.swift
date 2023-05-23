//
//  translation4.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 5/17/23.
//

import SwiftUI
import Alamofire
import Foundation


let apiKey = "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"

func sendOpenAIRequest(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
    let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": "Bearer \(apiKey)"
    ]
    
    let parameters: [String: Any] = [
        "model": "text-davinci-003",
        "prompt": prompt,
        "max_tokens": 1024,
        "n": 1,
        "temperature": 0.1
    ]
    
    AF.request("https://api.openai.com/v1/completions", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                if let resultDict = value as? [String: Any],
                   let choices = resultDict["choices"] as? [[String: Any]],
                   let text = choices.first?["text"] as? String {
                    completion(.success(text))
                } else {
                    completion(.failure(NSError(domain: "OpenAIError", code: 0, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
}

// Example menu text
let menuText = "Lion King (Baked) California roll topped with salmon, spicy mayo, unagi sauce, tobiko, and green onion."

// Send request to OpenAI API
let question = "Make a JSON table(table has 5 columns: food item, description of item, if it contains meat, if it contains gluten, if it contains fruit) for only the following food items: " + menuText + ". Do not add any more food items."

struct responseItem: Decodable {
    private enum CodingKeys : String, CodingKey {
        case foodItem = "Food Item"
        case description = "Description"
        case containsMeat = "Contains Meat"
        case containsGluten = "Contains Gluten"
        case containsFruit = "Contains Fruit"
    }
    let foodItem: String
    let description: String
    let containsMeat: String
    let containsGluten: String
    let containsFruit: String
}


struct apiCall: View {
    @State private var str = ""
    
    var body: some View {
        VStack {
            Text(str)
        }
        .onAppear {
            sendOpenAIRequest(prompt: question) { result in
                switch result {
                case .success(let response):
                    // Process the OpenAI API response here
                    print("question: \n" + question + "\n")
                    
                    print("Response, unparsed: ")
                    print(response)
                    print("\n\n\n")
                    
                    let json = response.data(using: .utf8)!
                    let decoder = JSONDecoder()
                    


                    let menuItems: [responseItem] = try! decoder.decode([responseItem].self, from: json)
                    print( menuItems.count)
                    
                    for item in menuItems {
                        if item.containsMeat.caseInsensitiveCompare("no") == .orderedSame {
                            str = str + item.foodItem + ", "
                        }
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

