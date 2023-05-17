//
//  translatedPython.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 5/17/23.
//

/*import OpenAI
import Foundation
import SwiftUI

class translatedPython: ObservableObject {
    var key: OpenAI.apiKey
    key = "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"

    func askQuestion(prompt: String) -> String {
        let completions = OpenAI.Completion.create(
            engine: "davinci",
            prompt: prompt,
            maxTokens: 1024,
            n: 1,
            stop: nil,
            temperature: 0.5
        )
        let message = completions.choices[0].text
        // Return the raw strip of the response
        return message.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // Hard-coded menu text
    let txtOfMenu = "GAME• Tado Red Cliff Lake Trout + White Bean Spread $15 Tepary Bean • Smoked Lake Superior Trout Wojapi • Tostada Three Sisters Bison Stew $15 Bison • Squash Broth Hominy • Black Bean • Pickled Squash Elk Poyha $18 Elk • Currant • Wild Onion Blackberry • Rosehip • Berry Glaze Tartare* $18 Chef Choice of Game • Duck Fat Squash Pickled Wild Mushroom • Cured Duck Egg, Cricket Seed Mix* 510 Sumac Popcorn • Sunflower Brittle Venison + Beans $12 Tepary Bean • Braised Venison Guajillo • Chipotle • Juniper Berry NATIVE TACO • Agúyapi Oitéka Cedar Braised Bison $8 Corn Salsa • Turnip Slaw Corn Taco $8 40 Corn Dumpling • Corn Cob Jam • Sumac Popcorn CORN SANDWICH • Choginyapi"

    // Question string to feed to Chat GPT
    let question = "Make a table (table has 5 columns: food item, description of item, if it contains meat, if it contains gluten, if it contains fruit) for the following menu: " + txtOfMenu
    // Response is the Chat GPT response
    let response = askQuestion(prompt: question)

    // Now parse the Chat GPT text response in order to convert it to a Swift array
    var menuList = response.components(separatedBy: "\n")

    // Split rows by commas
    var menuData = menuList.map { $0.components(separatedBy: ",") }

    // Create DataFrame (in Swift, it will be an array of dictionaries)
    var menuDicts: [[String: String]] = []
    if let headerRow = menuData.first {
        for row in menuData.dropFirst() {
            var menuDict: [String: String] = [:]
            for (index, item) in row.enumerated() {
                let key = headerRow[index]
                menuDict[key] = item
            }
            menuDicts.append(menuDict)
        }
    }

    // Print menu dictionary
    for item in menuDicts {
        print(item)
    }

}

OpenAI.apiKey = "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"

func askQuestion(prompt: String) -> String {
    let completions = OpenAI.Completion.create(
        engine: "davinci",
        prompt: prompt,
        maxTokens: 1024,
        n: 1,
        stop: nil,
        temperature: 0.5
    )
    let message = completions.choices[0].text
    // Return the raw strip of the response
    return message.trimmingCharacters(in: .whitespacesAndNewlines)
}

// Hard-coded menu text
let txtOfMenu = "put the text we scan from menu here"

// Question string to feed to Chat GPT
let question = "Make a table (table has 5 columns: food item, description of item, if it contains meat, if it contains gluten, if it contains fruit) for the following menu: " + txtOfMenu
// Response is the Chat GPT response
let response = askQuestion(prompt: question)

// Now parse the Chat GPT text response in order to convert it to a Swift array
var menuList = response.components(separatedBy: "\n")

// Split rows by commas
var menuData = menuList.map { $0.components(separatedBy: ",") }

// Create DataFrame (in Swift, it will be an array of dictionaries)
var menuDicts: [[String: String]] = []
if let headerRow = menuData.first {
    for row in menuData.dropFirst() {
        var menuDict: [String: String] = [:]
        for (index, item) in row.enumerated() {
            let key = headerRow[index]
            menuDict[key] = item
        }
        menuDicts.append(menuDict)
    }
}

// Print menu dictionary
for item in menuDicts {
    print(item)
}
*/
