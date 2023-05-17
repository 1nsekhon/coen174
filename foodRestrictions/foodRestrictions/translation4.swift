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
        "prompt": prompt,
        "max_tokens": 1024,
        "n": 1,
        "temperature": 0.5
    ]
    
    AF.request("https://api.openai.com/v1/engines/davinci/completions", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
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
let menuText = "bread, pork"

// Send request to OpenAI API
let prompt = "Do the following menu items contain meat?"
let question = prompt + "\n" + menuText

//


struct apiCall: View {
    var body: some View {
        let _ = sendOpenAIRequest(prompt: question) { result in
            switch result {
            case .success(let response):
                // Process the OpenAI API response here
                //?
                
                // Parse response to extract menu items
                let menuItems = response.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
                
                // Filter menu items that don't contain meat
                let menuItemsWithoutMeat = menuItems.filter { !$0.contains("Yes") }
                
                // Print menu items without meat
                print("Menu Items Without Meat:")
                for item in menuItemsWithoutMeat {
                    print(item)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        Text("done")
    }
}


/*let thefunctioncallwork: () = sendOpenAIRequest(prompt: question) { result in
                            switch result {
                            case .success(let response):
                                // Process the OpenAI API response here
                                //?
                                
                                // Parse response to extract menu items
                                let menuItems = response.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
                                
                                // Filter menu items that don't contain meat
                                let menuItemsWithoutMeat = menuItems.filter { !$0.contains("Yes") }
                                
                                // Print menu items without meat
                                print("Menu Items Without Meat:")
                                for item in menuItemsWithoutMeat {
                                    print(item)
                                }
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                        }*/

